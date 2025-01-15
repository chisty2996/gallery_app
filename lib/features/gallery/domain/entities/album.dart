import 'package:equatable/equatable.dart';

class Album extends Equatable {
  final String id;
  final String name;
  final String thumbnailPath;
  final int photoCount;

  const Album({
    required this.id,
    required this.name,
    required this.thumbnailPath,
    required this.photoCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        thumbnailPath,
        photoCount,
      ];
}
