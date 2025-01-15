import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final String id;
  final String imagePath;
  final DateTime dateAdded;

  const Photo({
    required this.id,
    required this.imagePath,
    required this.dateAdded,
  });

  @override
  List<Object?> get props => [
        id,
        imagePath,
        dateAdded,
      ];
}
