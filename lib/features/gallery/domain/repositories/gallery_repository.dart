import 'package:gallery_app/core/data_state.dart';
import 'package:gallery_app/features/gallery/domain/entities/photo.dart';

import '../entities/album.dart';

abstract class GalleryRepository{

  Future<DataState<bool>> checkPermission();

  Future<DataState<bool>> requestPermission();

  Future<DataState<List<Album>>> getAlbums();

  Future<DataState<List<Photo>>> getPhotosByAlbum(String albumId);
}