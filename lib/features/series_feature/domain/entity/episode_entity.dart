import 'package:equatable/equatable.dart';

class EpisodeEntity extends Equatable {
  const EpisodeEntity({
    this.id = 0,
    this.name = '',
    this.number = 0,
    this.season = 0,
    this.mediumImage = '',
    this.originalImage = '',
    this.summary = '',
  });

  final int id;
  final String name;
  final int number;
  final int season;
  final String summary;
  final String mediumImage;
  final String originalImage;

  @override
  List<Object?> get props => [
        id,
        name,
        number,
        season,
        summary,
        mediumImage,
        originalImage,
      ];

  EpisodeEntity copyWith({
    int? id,
    String? name,
    int? number,
    int? season,
    String? summary,
    String? mediumImage,
    String? originalImage,
  }) =>
      EpisodeEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        number: number ?? this.number,
        season: season ?? this.season,
        summary: summary ?? this.summary,
        mediumImage: mediumImage ?? this.mediumImage,
        originalImage: originalImage ?? this.originalImage,
      );
}
