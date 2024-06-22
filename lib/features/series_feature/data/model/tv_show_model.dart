import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_util/helpers/helpers.dart';

class TvShowModel extends TvShowEntity {
  const TvShowModel({
    super.id = 0,
    super.name = '',
    super.mediumImage = '',
    super.originalImage = '',
    super.premiered = '',
    super.ended = '',
    super.scheduleDays = const [],
    super.scheduleTime = '',
    super.genres = const [],
    super.summary = '',
  });

  factory TvShowModel.fromEntity(TvShowEntity entity) {
    return TvShowModel(
      id: entity.id,
      name: entity.name,
      mediumImage: entity.mediumImage,
      originalImage: entity.originalImage,
      premiered: entity.premiered,
      ended: entity.ended,
      scheduleDays: entity.scheduleDays,
      scheduleTime: entity.scheduleTime,
      genres: entity.genres,
      summary: entity.summary,
    );
  }

  factory TvShowModel.fromMap(Map<String, dynamic> map) {
    final show = map['show'] ?? map;
    return TvShowModel(
      id: show['id'] ?? 0,
      name: show['name'] ?? '',
      mediumImage: show['image'] != null && show['image']['medium'] != null
          ? show['image']['medium']
          : '',
      originalImage: show['image'] != null && show['image']['original'] != null
          ? show['image']['original']
          : '',
      premiered: show['premiered'] ?? '',
      ended: show['ended'] ?? '',
      scheduleDays: List<String>.from(
        show['schedule'] != null && show['schedule']['days'] != null
            ? show['schedule']['days']
            : [],
      ),
      scheduleTime: show['schedule'] != null && show['schedule']['time'] != null
          ? show['schedule']['time']
          : '',
      genres: List<String>.from(show['genres'] ?? []),
      summary: Helpers.removeHtmlFromString(show['summary'] ?? ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': {
        'medium': mediumImage,
        'original': originalImage,
      },
      'premiered': premiered,
      'ended': ended,
      'schedule': {
        'days': scheduleDays,
        'time': scheduleTime,
      },
      'genres': genres,
      'summary': summary,
    };
  }
}
