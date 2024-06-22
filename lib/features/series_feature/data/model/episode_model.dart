import 'package:tv_series_app/features/series_feature/series_feature.dart';

class EpisodeModel extends EpisodeEntity {
  const EpisodeModel({
    super.id = 0,
    super.name = '',
    super.summary = '',
    super.number = 0,
    super.season = 0,
    super.mediumImage = '',
    super.originalImage = '',
  });

  factory EpisodeModel.fromMap(Map<String, dynamic> map) => EpisodeModel(
    id: map['id'] ?? 0,
    name: map['name'] ?? '',
    number: map['number'] ?? 0,
    season: map['season'] ?? 0,
    summary: map['summary'] ?? '',
    mediumImage: map['image'] != null && map['image']['medium'] != null
        ? map['image']['medium']
        : '',
    originalImage: map['image'] != null && map['image']['original'] != null
        ? map['image']['original']
        : '',
  );
}
