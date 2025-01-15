import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_app/core/data_state.dart';
import 'package:gallery_app/features/gallery/domain/entities/album.dart';
import 'package:gallery_app/features/gallery/domain/entities/photo.dart';
import 'package:gallery_app/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:gallery_app/features/gallery/domain/usecases/gallery_usecases.dart';
import 'package:mocktail/mocktail.dart';

class MockGalleryRepository extends Mock implements GalleryRepository {}

void main() {
  late MockGalleryRepository mockGalleryRepository;
  late GalleryUseCases galleryUseCases;

  setUp(() {
    mockGalleryRepository = MockGalleryRepository();
    galleryUseCases = GalleryUseCases(galleryRepository: mockGalleryRepository);
  });

  group('GalleryUseCases', () {
    test('checkPermission should call repository and return DataState<bool>', () async {
      const expectedResponse = DataSuccess<bool>(true);
      when(() => mockGalleryRepository.checkPermission())
          .thenAnswer((_) async => expectedResponse);

      final result = await galleryUseCases.checkPermission();

      expect(result, expectedResponse);
      verify(() => mockGalleryRepository.checkPermission()).called(1);
    });

    test('requestPermission should call repository and return DataState<bool>', () async {
      const expectedResponse = DataSuccess<bool>(true);
      when(() => mockGalleryRepository.requestPermission())
          .thenAnswer((_) async => expectedResponse);

      final result = await galleryUseCases.requestPermission();

      expect(result, expectedResponse);
      verify(() => mockGalleryRepository.requestPermission()).called(1);
    });

    test('getAlbums should call repository and return DataState<List<Album>>', () async {
      final albumList = [const Album(id: '1', name: 'album1', thumbnailPath: 'path/c.jpg', photoCount: 2)];
      final expectedResponse = DataSuccess<List<Album>>(albumList);
      when(() => mockGalleryRepository.getAlbums())
          .thenAnswer((_) async => expectedResponse);

      final result = await galleryUseCases.getAlbums();

      expect(result, expectedResponse);
      verify(() => mockGalleryRepository.getAlbums()).called(1);
    });

    test('getPhotosByAlbum should call repository and return DataState<List<Photo>>', () async {
      DateTime dateTime = DateTime.now();

      final photoList = [Photo(id: '1', imagePath: 'path/c.jpg', dateAdded: dateTime)];
      final expectedResponse = DataSuccess<List<Photo>>(photoList);
      when(() => mockGalleryRepository.getPhotosByAlbum('1'))
          .thenAnswer((_) async => expectedResponse);

      final result = await galleryUseCases.getPhotosByAlbum('1');

      expect(result, expectedResponse);
      verify(() => mockGalleryRepository.getPhotosByAlbum('1')).called(1);
    });

    test('getHighQualityPhotoPath should call repository and return DataState<String>', () async {
      const photoPath = 'path/to/photo';
      const expectedResponse = DataSuccess<String>(photoPath);
      when(() => mockGalleryRepository.getHighQualityIOSImagePath('1'))
          .thenAnswer((_) async => expectedResponse);

      final result = await galleryUseCases.getHighQualityPhotoPath('1');

      expect(result, expectedResponse);
      verify(() => mockGalleryRepository.getHighQualityIOSImagePath('1')).called(1);
    });
  });
}
