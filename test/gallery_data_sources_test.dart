import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_app/core/data_state.dart';
import 'package:gallery_app/features/gallery/data/models/album_model.dart';
import 'package:gallery_app/features/gallery/data/models/photo_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:gallery_app/features/gallery/data/datasources/gallery_data_sources.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

@GenerateMocks([MethodChannel, Permission])
import 'gallery_data_sources_test.mocks.dart';



void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GalleryDataSources galleryDataSources;
  late MockMethodChannel mockMethodChannel;

  setUp(() {
    mockMethodChannel = MockMethodChannel();
    galleryDataSources = GalleryDataSources(channel: mockMethodChannel);
  });


  group('getHighQualityIOSImagePath', () {
    test('returns DataSuccess with path when image is fetched successfully', () async {
      final mockResult = {'path': 'path/to/high_quality_image.jpg'};
      when(mockMethodChannel.invokeMethod('getHighQualityImage', 'photoId')).thenAnswer((_) async => mockResult);

      final result = await galleryDataSources.getHighQualityIOSImagePath('photoId');

      expect(result, isA<DataSuccess<String>>());
      expect(result.data, 'path/to/high_quality_image.jpg');
    });

    test('returns DataFailed when result is null', () async {
      final mockResult = {'path': null};
      when(mockMethodChannel.invokeMethod('getHighQualityImage', 'photoId')).thenAnswer((_) async => mockResult);

      final result = await galleryDataSources.getHighQualityIOSImagePath('photoId');

      expect(result, isA<DataFailed<String>>());
      expect(result.message, 'Fetching photo failed');
    });

    test('returns DataFailed when exception is thrown', () async {
      when(mockMethodChannel.invokeMethod('getHighQualityImage', 'photoId'))
          .thenThrow(PlatformException(code: 'ERROR', message: 'Failed to fetch image'));

      final result = await galleryDataSources.getHighQualityIOSImagePath('photoId');

      expect(result, isA<DataFailed<String>>());
      expect(result.message, 'Fetching photo failed');
    });
  });

  group('loadIOSPhotos', () {
    test('returns a list of PhotoModel when photos are fetched successfully', () async {
      final mockResponse = [
        {'id': '1', 'path': 'path/to/photo1.jpg'},
        {'id': '2', 'path': 'path/to/photo2.jpg'},
      ];
      when(mockMethodChannel.invokeMethod('getPhotosInAlbum', {'albumId': 'albumId'}))
          .thenAnswer((_) async => mockResponse);
      final result = await galleryDataSources.loadIOSPhotos('albumId');

      // Assert
      expect(result, isA<List<PhotoModel>>());
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[0].imagePath, 'path/to/photo1.jpg');
      expect(result[1].id, '2');
      expect(result[1].imagePath, 'path/to/photo2.jpg');
    });

    test('returns an empty list when there is an error fetching photos', () async {
      when(mockMethodChannel.invokeMethod('getPhotosInAlbum', {'albumId': 'albumId'}))
          .thenThrow(PlatformException(code: 'ERROR', message: 'Failed to fetch photos'));

      final result = await galleryDataSources.loadIOSPhotos('albumId');

      expect(result, isA<List<PhotoModel>>());
      expect(result.isEmpty, true);
    });

    test('returns an empty list when the response is null', () async {
      when(mockMethodChannel.invokeMethod('getPhotosInAlbum', {'albumId': 'albumId'}))
          .thenAnswer((_) async => null);
      final result = await galleryDataSources.loadIOSPhotos('albumId');
      expect(result, isA<List<PhotoModel>>());
      expect(result.isEmpty, true);
    });
  });

  group('loadAndroidPhotos', () {
    test('returns a list of PhotoModel when photos are fetched successfully', () async {
      final mockResponse = [
        {'albumId': 'albumId1', 'path': 'path/to/photo1.jpg'},
        {'albumId': 'albumId1', 'path': 'path/to/photo2.jpg'},
        {'albumId': 'albumId2', 'path': 'path/to/photo3.jpg'},
      ];
      when(mockMethodChannel.invokeMethod('getImages'))
          .thenAnswer((_) async => mockResponse);

      final result = await galleryDataSources.loadAndroidPhotos('albumId1');

      expect(result, isA<List<PhotoModel>>());
      expect(result.length, 2);
      expect(result[0].id, 'path/to/photo1.jpg');
      expect(result[0].imagePath, 'path/to/photo1.jpg');
      expect(result[1].id, 'path/to/photo2.jpg');
      expect(result[1].imagePath, 'path/to/photo2.jpg');
    });

    test('returns an empty list when no photos match the albumId', () async {
      final mockResponse = [
        {'albumId': 'albumId2', 'path': 'path/to/photo3.jpg'},
      ];
      when(mockMethodChannel.invokeMethod('getImages'))
          .thenAnswer((_) async => mockResponse);

      final result = await galleryDataSources.loadAndroidPhotos('albumId1');

      expect(result, isA<List<PhotoModel>>());
      expect(result.isEmpty, true);
    });

    test('returns an empty list when there is an error fetching photos', () async {
      when(mockMethodChannel.invokeMethod('getImages'))
          .thenThrow(PlatformException(code: 'ERROR', message: 'Failed to fetch images'));

      final result = await galleryDataSources.loadAndroidPhotos('albumId1');

      expect(result, isA<List<PhotoModel>>());
      expect(result.isEmpty, true);
    });

    test('returns an empty list when the response is null', () async {
      when(mockMethodChannel.invokeMethod('getImages'))
          .thenAnswer((_) async => null);

      final result = await galleryDataSources.loadAndroidPhotos('albumId1');

      expect(result, isA<List<PhotoModel>>());
      expect(result.isEmpty, true);
    });
  });

  group('loadAndroidAlbums', () {
    test('returns a list of Albums when albums are fetched successfully', () async {
      final mockResponse = [
        {'albumId': 'album1', 'albumName': 'Vacation', 'path': 'path/to/photo1.jpg'},
        {'albumId': 'album1', 'albumName': 'Vacation', 'path': 'path/to/photo2.jpg'},
        {'albumId': 'album2', 'albumName': 'Family', 'path': 'path/to/photo3.jpg'},
      ];
      when(mockMethodChannel.invokeMethod('getImages'))
          .thenAnswer((_) async => mockResponse);
      final result = await galleryDataSources.loadAndroidAlbums();


      expect(result, isA<List<AlbumModel>>());
      expect(result.length, 2);
      expect(result[0].id, 'album1');
      expect(result[0].name, 'Vacation');
      expect(result[1].id, 'album2');
      expect(result[1].name, 'Family');
    });

    test('returns an empty list when no albums', () async {

      final mockResponse = [
        // {'albumId': 'album1', 'albumName': 'Vacation', 'path': 'path/to/photo1.jpg'},
      ];
      when(mockMethodChannel.invokeMethod('getImages'))
          .thenAnswer((_) async => mockResponse);


      final result = await galleryDataSources.loadAndroidAlbums();

      expect(result, isA<List<AlbumModel>>());
      expect(result.isEmpty, true);
    });

    test('returns an empty list when there is an error fetching albums', () async {

      when(mockMethodChannel.invokeMethod('getImages'))
          .thenThrow(PlatformException(code: 'ERROR', message: 'Failed to fetch images'));


      final result = await galleryDataSources.loadAndroidAlbums();


      expect(result, isA<List<AlbumModel>>());
      expect(result.isEmpty, true);
    });

    test('returns an empty list when the response is null', () async {
      when(mockMethodChannel.invokeMethod('getImages'))
          .thenAnswer((_) async => null);


      final result = await galleryDataSources.loadAndroidAlbums();

      expect(result, isA<List<AlbumModel>>());
      expect(result.isEmpty, true);
    });
  });

  group('loadIOSAlbums', () {
    test('returns List of albums when data is fetched successfully', () async {
      final mockAlbums = [
        {'id': 'album1', 'name': 'Vacation'},
        {'id': 'album2', 'name': 'Family'},
      ];

      final mockPhotosForAlbum1 = [
        {'path': 'path/to/photo1.jpg'},
        {'path': 'path/to/photo2.jpg'},
      ];
      final mockPhotosForAlbum2 = [
        {'path': 'path/to/photo3.jpg'},
      ];

      when(mockMethodChannel.invokeMethod('getAlbums'))
          .thenAnswer((_) async => mockAlbums);
      when(mockMethodChannel.invokeMethod(
          'getPhotosInAlbum', {'albumId': 'album1'}))
          .thenAnswer((_) async => mockPhotosForAlbum1);
      when(mockMethodChannel.invokeMethod(
          'getPhotosInAlbum', {'albumId': 'album2'}))
          .thenAnswer((_) async => mockPhotosForAlbum2);

      final result = await galleryDataSources.loadIOSAlbums();

      expect(result, isA<List<AlbumModel>>());
      expect(result.length, 2);

      expect(result[0].id, equals('album1'));
      expect(result[0].name, equals('Vacation'));
      expect(result[0].thumbnailPath, equals('path/to/photo1.jpg'));
      expect(result[0].photoCount, equals(2));

      expect(result[1].id, equals('album2'));
      expect(result[1].name, equals('Family'));
      expect(result[1].thumbnailPath, equals('path/to/photo3.jpg'));
      expect(result[1].photoCount, equals(1));
    });
    test('returns empty list when no albums are found', () async {
      final mockAlbums = [];

      when(mockMethodChannel.invokeMethod('getAlbums'))
          .thenAnswer((_) async => mockAlbums);

      final result = await galleryDataSources.loadIOSAlbums();

      expect(result, isA<List<AlbumModel>>());
      expect(result.isEmpty, true);
    });

    test('returns empty list when no photos are found in albums', () async {
      final mockAlbums = [
        {'id': 'album1', 'name': 'Vacation'},
      ];

      final mockPhotosForAlbum1 = [];

      when(mockMethodChannel.invokeMethod('getAlbums'))
          .thenAnswer((_) async => mockAlbums);
      when(mockMethodChannel.invokeMethod('getPhotosInAlbum', {'albumId': 'album1'}))
          .thenAnswer((_) async => mockPhotosForAlbum1);

      final result = await galleryDataSources.loadIOSAlbums();

      expect(result, isA<List<AlbumModel>>());
      expect(result.isEmpty, true);
    });

    test('returns empty list when an exception is thrown', () async {
      when(mockMethodChannel.invokeMethod('getAlbums'))
          .thenThrow(PlatformException(code: 'ERROR', message: 'Failed to get albums'));

      final result = await galleryDataSources.loadIOSAlbums();


      expect(result, isA<List<AlbumModel>>());
      expect(result.isEmpty, true);
    });
  });



}


