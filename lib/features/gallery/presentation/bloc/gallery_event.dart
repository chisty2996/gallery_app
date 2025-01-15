part of 'gallery_bloc.dart';

sealed class GalleryEvent extends Equatable {
  const GalleryEvent();
}

class CheckPermission extends GalleryEvent{
  const CheckPermission();

  @override
  List<Object?> get props => [];
}

class RequestPermission extends GalleryEvent{
  const RequestPermission();

  @override
  List<Object?> get props => [];
}

class GetAlbums extends GalleryEvent{

  @override
  List<Object?> get props => [];
}

class GetPhotos extends GalleryEvent{
  final String albumId;

  const GetPhotos({required this.albumId});

  @override
  List<Object?> get props => [albumId];
}