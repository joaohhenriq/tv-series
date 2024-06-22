import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  const PersonEntity({
    this.id = 0,
    this.name = '',
    this.mediumImage = '',
    this.originalImage = '',
  });

  final int id;
  final String name;
  final String mediumImage;
  final String originalImage;

  @override
  List<Object?> get props => [
    id,
    name,
    mediumImage,
    originalImage,
  ];
}
