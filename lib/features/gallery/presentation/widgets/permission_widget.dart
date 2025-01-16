import 'package:flutter/material.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'grant_access_button.dart';

class PermissionWidget extends StatelessWidget {
  final GalleryBloc galleryBloc;
  const PermissionWidget({super.key, required this.galleryBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/permission.png",
            height: 149,
            width: 123,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Require Permission",
          style: Theme.of(context).primaryTextTheme.bodyMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "To show your black and white photos\nwe just need your folder permission.\nWe promise, we don't take your photos",
          style: Theme.of(context).primaryTextTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        GrantAccessButton(
          onTap: ()  {
            galleryBloc.add(const RequestPermission());
          },
        )
      ],
    );
  }
}
