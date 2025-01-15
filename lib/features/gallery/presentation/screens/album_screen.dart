
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/core/globals/widgets/custom_dialogue.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:gallery_app/features/gallery/presentation/widgets/album_list_widget.dart';
import 'package:gallery_app/features/gallery/presentation/widgets/permission_widget.dart';
import '../../../../dependency_injection.dart';
import '../../domain/entities/album.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final GalleryBloc _galleryBloc = sl<GalleryBloc>();
  late Alerts _alerts;

  @override
  void initState() {
    super.initState();
    _alerts = Alerts(context: context);
    _galleryBloc.add(const CheckPermission());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _galleryBloc,
      child: Scaffold(
        body: BlocConsumer<GalleryBloc, GalleryState>(
          builder: (context, state) {
            List<Album> albumList = _galleryBloc.storedAlbumList;
            if (state is PermissionState) {
              if (!state.hasPermission) {
                return PermissionWidget(
                  galleryBloc: _galleryBloc,
                );
              }
            } else if (state is AlbumsFetchingSuccess) {
              albumList = state.albums;
            }
            
            return AlbumListWidget(
              albums: albumList,
              galleryBloc: _galleryBloc,
            );
          },
          listener: (BuildContext context, GalleryState state) {
            if (state is AlbumsFetching) {
              _alerts.showLoadingDialog(title: "Loading albums");
            } else if (state is AlbumsFetchingFailed) {
              _alerts.dismissDialog();
            } else if (state is AlbumsFetchingSuccess) {
              _alerts.dismissDialog();
            }
          },
        ),
      ),
    );
  }
}
