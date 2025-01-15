import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_app/core/data_state.dart';
import 'package:gallery_app/features/gallery/data/models/album_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/photo_model.dart';

class GalleryDataSources {
  final MethodChannel platform;

  GalleryDataSources({MethodChannel? channel})
      : platform = channel ?? const MethodChannel("photo_gallery_channel");

  Future<DataState<bool>> checkPermission() async {
    try {
      if (Platform.isAndroid) {
        int? sdkVersion = await getAndroidSdkVersion();
        if (sdkVersion != null && sdkVersion >= 33) {
          return await _checkPermission(Permission.photos);
        } else {
          return await _checkPermission(Permission.storage);
        }
      } else if (Platform.isIOS) {
        return await _checkPermission(Permission.photos);
      }
    } catch (e,s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return const DataFailed(message: "Failed to check permission");
  }

  Future<DataState<bool>> _checkPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    bool isGranted = status == PermissionStatus.granted || status == PermissionStatus.limited;
    return isGranted ? const DataSuccess(true) : const DataSuccess(false);
  }

  Future<DataState<bool>> requestPermissions() async {
    try {
      if (Platform.isAndroid) {
        PermissionStatus status;
        int? sdkVersion = await getAndroidSdkVersion();
        if ((sdkVersion ?? 33) >= 33) {
          status = await Permission.photos.status;
          if (status.isDenied) {
            status = await Permission.photos.request();
          }
        } else {
          status = await Permission.storage.status;
          if (status.isDenied) {
            status = await Permission.storage.request();
          }
        }
        return _handlePermissionStatus(status);
      } else if (Platform.isIOS) {
        final status = await Permission.photos.status;
        if (status.isDenied) {
          return _handlePermissionStatus(await Permission.photos.request());
        }
        return _handlePermissionStatus(status);
      }

      return const DataFailed(message: "Unsupported platform");
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      return DataFailed(message: e.toString());
    }
  }

  DataState<bool> _handlePermissionStatus(PermissionStatus status) {

    switch (status) {
      case PermissionStatus.granted:
        return const DataSuccess(true);
      case PermissionStatus.limited:
        return const DataSuccess(true);
      case PermissionStatus.denied:
        return const DataFailed(
            message: "Permission denied. Please grant access to photos.");
      case PermissionStatus.permanentlyDenied:
        return const DataFailed(
            message:
                "Permission permanently denied. Please enable in Settings");
      case PermissionStatus.restricted:
        return const DataFailed(message: "Permission restricted");
      default:
        return const DataFailed(message: "Permission status unknown");
    }
  }

  Future<DataState<List<AlbumModel>>> getAlbums() async {
    try {
      if (Platform.isAndroid) {
        final List<AlbumModel> albums = await loadAndroidAlbums();
        return DataSuccess(albums);
      } else {
        final List<AlbumModel> albumsList = await loadIOSAlbums();
        return DataSuccess(albumsList);
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return const DataFailed(message: "Album fetching failed");
  }

  Future<List<AlbumModel>> loadIOSAlbums() async {
    List<AlbumModel> albums = [];
    try {
      List<dynamic> response = await platform.invokeMethod('getAlbums');

      for (var album in response) {
        final photos = await platform.invokeMethod('getPhotosInAlbum', {'albumId': album['id']});

        if (photos.isNotEmpty) {
          albums.add(AlbumModel(
            id: album['id'],
            name: album['name'],
            thumbnailPath: (photos.first as Map)['path'],
            photoCount: photos.length,
          ));
        }
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return albums;
  }


  Future<List<AlbumModel>> loadAndroidAlbums() async {
    List<AlbumModel> albums = [];

    try {
      List<dynamic> result = await platform.invokeMethod("getImages");

      final Map<String, List<Map<String, dynamic>>> albumsMap = {};

      for (var image in result) {
        final albumId = image['albumId'] as String;
        final albumName = image['albumName'] as String;
        final path = image['path'] as String;

        if (!albumsMap.containsKey(albumId)) {
          albumsMap[albumId] = [];
        }
        albumsMap[albumId]!.add({
          'path': path,
          'albumName': albumName,
        });
      }

      albums = albumsMap.entries.map((entry) {
        return AlbumModel(
          id: entry.key,
          name: entry.value.first['albumName'] as String,
          thumbnailPath: entry.value.first['path'] as String,
          photoCount: entry.value.length,
        );
      }).toList();
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }

    return albums;
  }


  Future<DataState<List<PhotoModel>>> getPhotosInAlbum(String albumId) async {
    try {
      if (Platform.isAndroid) {

        final List<PhotoModel> photos = await loadAndroidPhotos(albumId);
        return DataSuccess(photos);
      } else {

        final List<PhotoModel> photos = await loadIOSPhotos(albumId);
        return DataSuccess(photos);
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return const DataFailed(message: "Fetching photos failed");
  }

  Future<List<PhotoModel>> loadAndroidPhotos(String albumId) async {
    List<PhotoModel> photos = [];
    try {
      final List<dynamic> result = await platform.invokeMethod('getImages');

      // Create a mutable list by converting the result to List
      photos = List<PhotoModel>.from(
        result
            .where((image) => image['albumId'] == albumId)
            .map((image) => PhotoModel(
          id: image['path'],
          imagePath: image['path'],
          dateAdded: DateTime.now(),
        )),
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return photos;
  }

  Future<List<PhotoModel>> loadIOSPhotos(String albumId) async {
    List<PhotoModel> photos = [];
    try {
      final List<dynamic> response = await platform.invokeMethod('getPhotosInAlbum', {'albumId': albumId});

      // Create a mutable list by converting the response to List
      photos = List<PhotoModel>.from(
        response
            .map((photo) => PhotoModel(
          id: photo['id'],
          imagePath: photo['path'],
          dateAdded: DateTime.now(),
        )),
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return photos;
  }

  Future<DataState<String>> getHighQualityIOSImagePath(String photoId)async{
    try{
      final Map<dynamic, dynamic> result = await platform.invokeMethod(
        'getHighQualityImage',
        photoId,
      );
      final path = (result)['path'] as String?;
      if(path!=null){
        return DataSuccess(path);
      }
    }
    catch(e,s){
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return const DataFailed(message: "Fetching photo failed");
  }


  Future<int?> getAndroidSdkVersion() async {
      try {
        final int? sdkVersion =
            await platform.invokeMethod<int>('getSdkVersion');
        log("sdk version: $sdkVersion");
        return sdkVersion;
      } on PlatformException catch (e) {
        log("Failed to get SDK version: '${e.message}'.");
      }
    return null;
  }
}
