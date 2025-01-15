import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/core/routes/app_routes.dart';
import 'package:gallery_app/features/gallery/domain/entities/album.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:go_router/go_router.dart';

class AlbumListWidget extends StatelessWidget {
  final List<Album> albums;
  final GalleryBloc galleryBloc;
  const AlbumListWidget({super.key, required this.albums, required this.galleryBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 120,
          child: Text(
            "Albums",
            style: Theme.of(context).primaryTextTheme.headlineLarge,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // Move the Expanded widget here
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      context.push(AppRoutes.photosScreen, extra: {"album": albums[index], "bloc": galleryBloc});
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              image: FileImage(File(albums[index].thumbnailPath)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.0,
                          left: 8.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                albums[index].name,
                                style: Theme.of(context).primaryTextTheme.titleLarge,
                              ),
                              Text(
                                "${albums[index].photoCount.toString()} photos",
                                style: Theme.of(context).primaryTextTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
