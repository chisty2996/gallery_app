import 'package:flutter/material.dart';
import 'package:gallery_app/core/routes/app_routes.dart';
import 'package:gallery_app/features/gallery/presentation/screens/album_screen.dart';
import 'package:go_router/go_router.dart';

class RouteGenerator{
 static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.albumScreen,
    routes: [
      ///Album Screen
      GoRoute(
          path: AppRoutes.albumScreen,
          pageBuilder: (context, state) => const MaterialPage(child: AlbumScreen())
      ),
    ],
  );
}

