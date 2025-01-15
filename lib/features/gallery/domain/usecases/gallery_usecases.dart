import 'package:gallery_app/core/data_state.dart';
import 'package:gallery_app/features/gallery/domain/entities/album.dart';
import 'package:gallery_app/features/gallery/domain/repositories/gallery_repository.dart';

import '../entities/photo.dart';

class GalleryUseCases{
  final GalleryRepository galleryRepository;

  const GalleryUseCases({required this.galleryRepository});

  Future<DataState<bool>> checkPermission()async{
    return await galleryRepository.checkPermission();
  }

  Future<DataState<bool>> requestPermission() async{
    return await galleryRepository.requestPermission();
  }

  Future<DataState<List<Album>>> getAlbums() async{
    return await galleryRepository.getAlbums();
  }

  Future<DataState<List<Photo>>> getPhotosByAlbum(String albumId) async{
    return await galleryRepository.getPhotosByAlbum(albumId);
  }

  Future<DataState<String>> getHighQualityPhotoPath(String photoId) async{
    return await galleryRepository.getHighQualityIOSImagePath(photoId);
  }
}