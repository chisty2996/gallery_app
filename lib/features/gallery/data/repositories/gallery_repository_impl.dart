import 'package:flutter/cupertino.dart';
import 'package:gallery_app/core/data_state.dart';
import 'package:gallery_app/features/gallery/data/datasources/gallery_data_sources.dart';
import 'package:gallery_app/features/gallery/data/models/album_model.dart';
import 'package:gallery_app/features/gallery/data/models/photo_model.dart';
import 'package:gallery_app/features/gallery/domain/entities/album.dart';
import 'package:gallery_app/features/gallery/domain/entities/photo.dart';
import 'package:gallery_app/features/gallery/domain/repositories/gallery_repository.dart';

class GalleryRepositoryImpl implements GalleryRepository{

  final GalleryDataSources _galleryDataSources = GalleryDataSources();

  @override
  Future<DataState<bool>> checkPermission() async{
    return await _galleryDataSources.checkPermission();
  }

  @override
  Future<DataState<bool>> requestPermission() async{
    return await _galleryDataSources.requestPermissions();
  }

  @override
  Future<DataState<List<Album>>> getAlbums() async{
    try{
      final response = await _galleryDataSources.getAlbums();

      if(response is DataSuccess){
        List<AlbumModel>? albumModels = response.data;
        if(albumModels!=null){
          return DataSuccess(albumModels.map((e) => e.toEntity()).toList());
        }
      }
    }
    catch(e,s){
      debugPrint(e.toString());
      debugPrint(s.toString());
    }

    return const DataFailed(message: "Album fetching failed");
  }

  @override
  Future<DataState<List<Photo>>> getPhotosByAlbum(String albumId) async{
    try{
      final response = await _galleryDataSources.getPhotosInAlbum(albumId);

      if(response is DataSuccess){
        List<PhotoModel>? photoModels = response.data;
        if(photoModels!=null){
          return DataSuccess(photoModels.map((e) => e.toEntity()).toList());
        }
      }
    }
    catch(e,s){
      debugPrint(e.toString());
      debugPrint(s.toString());
    }

    return const DataFailed(message: "Album fetching failed");
  }

  @override
  Future<DataState<String>> getHighQualityIOSImagePath(String photoId) async{

    try{
      final response = await _galleryDataSources.getHighQualityIOSImagePath(photoId);

      if(response is DataSuccess){
        String? photoPath = response.data;
        if(photoPath!=null){
          return DataSuccess(photoPath);
        }
      }
    }
    catch(e,s){
      debugPrint(e.toString());
      debugPrint(s.toString());
    }

    return const DataFailed(message: "Album fetching failed");
  }


}