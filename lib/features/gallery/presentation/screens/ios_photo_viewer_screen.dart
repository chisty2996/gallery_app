import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/features/gallery/domain/entities/photo.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';

class IosPhotoViewerScreen extends StatefulWidget {
  final Photo photo;
  final GalleryBloc galleryBloc;

  const IosPhotoViewerScreen(
      {super.key, required this.photo, required this.galleryBloc});

  @override
  State<IosPhotoViewerScreen> createState() => _IosPhotoViewerScreenState();
}

class _IosPhotoViewerScreenState extends State<IosPhotoViewerScreen> {
  @override
  void initState() {
    super.initState();
    widget.galleryBloc.add(GetHighQualityImage(photoId: widget.photo.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<GalleryBloc, GalleryState>(
        bloc: widget.galleryBloc,
        builder: (context, state) {
          if(state is HighQualityPhotoFetchSuccess){
            return Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.file(
                  File(state.path),
                  fit: BoxFit.contain,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
