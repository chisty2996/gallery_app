part of 'gallery_bloc.dart';

sealed class GalleryState extends Equatable {
  const GalleryState();
}

final class GalleryInitial extends GalleryState {
  @override
  List<Object> get props => [];
}

final class PermissionChecking extends GalleryState{
  @override
  List<Object?> get props => [];
}

final class RequestingPermission extends GalleryState{
  @override
  List<Object?> get props => [];
}

final class PermissionState extends GalleryState{
  final bool hasPermission;

  const PermissionState({required this.hasPermission});

  @override
  List<Object?> get props => [hasPermission];
}

final class AlbumsFetching extends GalleryState{
  @override
  List<Object?> get props => [];
}

final class AlbumsFetchingSuccess extends GalleryState{
  final List<Album> albums;

  const AlbumsFetchingSuccess({required this.albums});

  static AlbumsFetchingSuccess copyWith(List<Album>? newList){
    return AlbumsFetchingSuccess(albums: newList??[]);
  }

  @override
  List<Object?> get props => [albums];
}

final class AlbumsFetchingFailed extends GalleryState{
  final String? message;

  const AlbumsFetchingFailed({this.message});

  @override
  List<Object?> get props => [message];
}

final class PhotosFetching extends GalleryState{
  @override
  List<Object?> get props => [];
}

final class PhotosFetchingSuccess extends GalleryState{
  final List<Photo> photos;

  const PhotosFetchingSuccess({required this.photos});

  static PhotosFetchingSuccess copyWith(List<Photo>? newList){
    return PhotosFetchingSuccess(photos: newList??[]);
  }

  @override
  List<Object?> get props => [photos];
}

final class PhotosFetchingFailed extends GalleryState{
  final String? message;

  const PhotosFetchingFailed({this.message});

  @override
  List<Object?> get props => [message];
}

final class HighQualityPhotoFetching extends GalleryState{
  @override
  List<Object?> get props => [];
}

final class HighQualityPhotoFetchSuccess extends GalleryState{
  final String path;

  const HighQualityPhotoFetchSuccess({required this.path});

  @override
  List<Object?> get props => [path];
}

final class HighQualityPhotoFetchFailed extends GalleryState{
  final String? message;

  const HighQualityPhotoFetchFailed({this.message});

  @override
  List<Object?> get props => [message];
}
