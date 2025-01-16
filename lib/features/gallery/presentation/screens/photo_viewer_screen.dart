import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entities/photo.dart';

class PhotoViewerScreen extends StatelessWidget {
  final Photo photo;
  const PhotoViewerScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.file(
            File(photo.imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
