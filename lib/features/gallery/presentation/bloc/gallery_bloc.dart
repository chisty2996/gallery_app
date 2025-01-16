
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/core/data_state.dart';
import 'package:gallery_app/features/gallery/domain/entities/album.dart';
import 'package:gallery_app/features/gallery/domain/entities/photo.dart';
import 'package:gallery_app/features/gallery/domain/usecases/gallery_usecases.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryUseCases galleryUseCases;
  GalleryBloc({required this.galleryUseCases}) : super(GalleryInitial()) {
    on<CheckPermission>(onCheckPermission);
    on<RequestPermission>(onRequestPermission);
    on<GetAlbums>(onFetchingAlbums);
    on<GetPhotos>(onFetchingPhotos);
    on<GetHighQualityImage>(onFetchHighQualityPhoto);
  }

  List<Album> storedAlbumList = [];
  Map<String, List<Photo>> storedPhotos = {};

  void onCheckPermission(CheckPermission event, Emitter<GalleryState> emit) async{
    emit(PermissionChecking());

    final response = await galleryUseCases.checkPermission();

    if(response is DataSuccess){
      bool? hasPermission = response.data;

      if(hasPermission!=null){

        emit(PermissionState(hasPermission: hasPermission));
        if(hasPermission==true){
          add(GetAlbums());
        }
      }
      else{
        emit(const PermissionState(hasPermission: false));
      }
    }
    else{
      emit(const PermissionState(hasPermission: false));
    }
  }

  void onRequestPermission(RequestPermission event, Emitter<GalleryState> emit)async{
    emit(RequestingPermission());

    final response = await galleryUseCases.requestPermission();

    if(response is DataSuccess){
      bool? hasPermission = response.data;
      if(hasPermission!=null){

        emit(PermissionState(hasPermission: hasPermission));
        if(hasPermission==true){
          add(GetAlbums());
        }
      }
      else{
        emit(const PermissionState(hasPermission: false));
      }
    }
    else{
      emit(const PermissionState(hasPermission: false));
    }
  }

  void onFetchingAlbums(GetAlbums event, Emitter<GalleryState> emit) async{
    emit(AlbumsFetching());

    final response = await galleryUseCases.getAlbums();

    if(response is DataSuccess){
      List<Album>? albums = response.data;
      if(albums!=null){
        storedAlbumList = albums;
        emit(AlbumsFetchingSuccess.copyWith(albums));
      }
      else{
        emit(AlbumsFetchingFailed(message: response.message));
      }
    }
    else{
      emit(AlbumsFetchingFailed(message: response.message));
    }
  }

  void onFetchingPhotos(GetPhotos event, Emitter<GalleryState> emit) async{
    emit(PhotosFetching());

    final response = await galleryUseCases.getPhotosByAlbum(event.albumId);

    if(response is DataSuccess){
      List<Photo>? photos = response.data;

      if(photos!=null){
        storedPhotos[event.albumId] = photos;
        emit(PhotosFetchingSuccess.copyWith(photos));
      }
      else{
        emit(PhotosFetchingFailed(message: response.message));
      }
    }
    else{
      emit(PhotosFetchingFailed(message: response.message));
    }
  }

  void onFetchHighQualityPhoto(GetHighQualityImage event, Emitter<GalleryState> emit) async{
    emit(HighQualityPhotoFetching());

    final response = await galleryUseCases.getHighQualityPhotoPath(event.photoId);

    if(response is DataSuccess){
      String? photo = response.data;

      if(photo!=null){
        emit(HighQualityPhotoFetchSuccess(path: photo));
      }
      else{
        emit(HighQualityPhotoFetchFailed(message: response.message));
      }
    }
    else{
      emit(HighQualityPhotoFetchFailed(message: response.message));
    }
  }

}
