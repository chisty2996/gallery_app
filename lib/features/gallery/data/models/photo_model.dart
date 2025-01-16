import 'package:gallery_app/features/gallery/domain/entities/photo.dart';

class PhotoModel {
  final String id;
  final String imagePath;
  final DateTime dateAdded;

  const PhotoModel({
    required this.id,
    required this.imagePath,
    required this.dateAdded,
  });

  Photo toEntity() {
    return Photo(
      id: id,
      imagePath: imagePath,
      dateAdded: dateAdded,
    );
  }
}
