import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/core/routes/app_routes.dart';
import 'package:gallery_app/features/gallery/domain/entities/album.dart';
import 'package:gallery_app/features/gallery/domain/entities/photo.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:go_router/go_router.dart';

class PhotosScreen extends StatefulWidget {
  final Album album;
  final GalleryBloc galleryBloc;

  const PhotosScreen(
      {super.key, required this.album, required this.galleryBloc});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  void initState() {
    super.initState();
    widget.galleryBloc.add(GetPhotos(albumId: widget.album.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.album.name,
          style: Theme.of(context).primaryTextTheme.headlineMedium,
        ),
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<GalleryBloc, GalleryState>(
        bloc: widget.galleryBloc,
        builder: (context, state) {
          List<Photo>? photos =
              widget.galleryBloc.storedPhotos[widget.album.id];

          if (state is PhotosFetchingSuccess) {
            photos = state.photos;
          }

          if (photos != null) {
            if (photos.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if(Platform.isAndroid){
                          log("path: ${photos![index].imagePath}");
                          context.push(AppRoutes.photoViewerScreen, extra: photos![index]);
                        }
                        else{
                          log("path: ${photos![index].imagePath}");
                          context.push(AppRoutes.iOSPhotoViewerScreen, extra: {"photo": photos![index], "bloc": widget.galleryBloc});
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: FileImage(
                              File(photos![index].imagePath),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }

          return Center(
            child: Text(
              "No Photos",
              style: Theme.of(context).primaryTextTheme.headlineLarge,
            ),
          );
        },
      ),
    );
  }
}
