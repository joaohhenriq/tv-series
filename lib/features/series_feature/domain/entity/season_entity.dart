import 'package:equatable/equatable.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

class SeasonEntity extends Equatable {
  const SeasonEntity({
    this.number = 0,
    this.episodes = const [],
  });

  final int number;
  final List<EpisodeEntity> episodes;

  @override
  List<Object?> get props => [
        number,
        episodes,
      ];

  SeasonEntity copyWith({
    int? number,
    List<EpisodeEntity>? episodes,
  }) =>
      SeasonEntity(
        number: number ?? this.number,
        episodes: episodes ?? this.episodes,
      );
}
