import 'package:flutter/material.dart';
import 'package:gallery_app/core/routes/app_routes.dart';
import 'package:gallery_app/features/gallery/domain/entities/album.dart';
import 'package:gallery_app/features/gallery/domain/entities/photo.dart';
import 'package:gallery_app/features/gallery/presentation/screens/album_screen.dart';
import 'package:gallery_app/features/gallery/presentation/screens/photo_viewer_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/gallery/presentation/screens/photos_screen.dart';

class RouteGenerator {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.albumScreen,
    routes: [
      ///Album Screen
      GoRoute(
          path: AppRoutes.albumScreen,
          pageBuilder: (context, state) =>
              const MaterialPage(child: AlbumScreen())),

      ///Photos Screen
      GoRoute(
        path: AppRoutes.photosScreen,
        pageBuilder: (context, state) {
          final Map data = state.extra as Map;

          return MaterialPage(
            child: PhotosScreen(
              album: data['album'],
              galleryBloc: data['bloc'],
            ),
          );
        },
      ),

      ///Photo viewer screen
      GoRoute(
        path: AppRoutes.photoViewerScreen,
        pageBuilder: (context, state) {
          final Photo data = state.extra as Photo;

          return MaterialPage(
            child: PhotoViewerScreen(photo: data)
          );
        },
      )
    ],
  );
}
