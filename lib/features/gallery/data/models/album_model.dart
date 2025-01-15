import 'package:gallery_app/features/gallery/domain/entities/album.dart';

class AlbumModel {
  final String id;
  final String name;
  final String thumbnailPath;
  final int photoCount;

  const AlbumModel({
    required this.id,
    required this.name,
    required this.thumbnailPath,
    required this.photoCount,
  });

  Album toEntity() {
    return Album(
      id: id,
      name: name,
      thumbnailPath: thumbnailPath,
      photoCount: photoCount,
    );
  }
}
