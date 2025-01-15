import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_app/core/data_state.dart';
import 'package:gallery_app/features/gallery/domain/entities/album.dart';
import 'package:gallery_app/features/gallery/domain/entities/photo.dart';
import 'package:gallery_app/features/gallery/domain/usecases/gallery_usecases.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGalleryUseCases extends Mock implements GalleryUseCases {}

void main() {
  late GalleryBloc galleryBloc;
  late MockGalleryUseCases mockGalleryUseCases;

  setUp(() {
    mockGalleryUseCases = MockGalleryUseCases();
    galleryBloc = GalleryBloc(galleryUseCases: mockGalleryUseCases);
  });

  tearDown(() {
    galleryBloc.close();
  });

  test('Initial state is GalleryInitial', () {
    expect(galleryBloc.state, equals(GalleryInitial()));
  });


  group('GetAlbums', () {
    blocTest<GalleryBloc, GalleryState>(
      'emits [AlbumsFetching, AlbumsFetchingSuccess] on success',
      build: () {
        when(() => mockGalleryUseCases.getAlbums())
            .thenAnswer((_) async => const DataSuccess([Album(id: '1', name: 'Album 1', thumbnailPath: '', photoCount: 1)]));
        return galleryBloc;
      },
      act: (bloc) => bloc.add(GetAlbums()),
      expect: () => [
        AlbumsFetching(),
        const AlbumsFetchingSuccess(albums: [Album(id: '1', name: 'Album 1', thumbnailPath: '', photoCount: 1)]),
      ],
    );

    blocTest<GalleryBloc, GalleryState>(
      'emits [AlbumsFetching, AlbumsFetchingFailed] on failure',
      build: () {
        when(() => mockGalleryUseCases.getAlbums())
            .thenAnswer((_) async => const DataFailed(message: 'Error fetching albums'));
        return galleryBloc;
      },
      act: (bloc) => bloc.add(GetAlbums()),
      expect: () => [
        AlbumsFetching(),
        const AlbumsFetchingFailed(message: 'Error fetching albums'),
      ],
    );
  });

  group('GetPhotos', () {
    DateTime dateTime = DateTime.now();
    blocTest<GalleryBloc, GalleryState>(
      'emits [PhotosFetching, PhotosFetchingSuccess] on success',
      build: () {
        when(() => mockGalleryUseCases.getPhotosByAlbum('1'))
            .thenAnswer((_) async => DataSuccess([Photo(id: '1', imagePath: '', dateAdded: dateTime)]));
        return galleryBloc;
      },
      act: (bloc) => bloc.add(const GetPhotos(albumId: '1')),
      expect: () => [
        PhotosFetching(),
        PhotosFetchingSuccess(photos: [Photo(id: '1', imagePath: '', dateAdded: dateTime)]),
      ],
    );

    blocTest<GalleryBloc, GalleryState>(
      'emits [PhotosFetching, PhotosFetchingFailed] on failure',
      build: () {
        when(() => mockGalleryUseCases.getPhotosByAlbum('1'))
            .thenAnswer((_) async => const DataFailed(message: 'Error fetching photos'));
        return galleryBloc;
      },
      act: (bloc) => bloc.add(const GetPhotos(albumId: '1')),
      expect: () => [
        PhotosFetching(),
        const PhotosFetchingFailed(message: 'Error fetching photos'),
      ],
    );
  });
}
