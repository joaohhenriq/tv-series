import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

void main() {
  late GroupEpisodesBySeasonImpl groupEpisodesBySeasonImpl;

  setUp(() {
    groupEpisodesBySeasonImpl = GroupEpisodesBySeasonImpl();
  });

  test('should convert and order to a season list when a list with episodes is passed as param', () {
    final list = [
      const EpisodeEntity(season: 2, number: 1),
      const EpisodeEntity(season: 1, number: 2),
      const EpisodeEntity(season: 1, number: 1),
      const EpisodeEntity(season: 2, number: 2),
    ];

    final expected = [
      const SeasonEntity(number: 1, episodes: [EpisodeEntity(season: 1, number: 1), EpisodeEntity(season: 1, number: 2)]),
      const SeasonEntity(number: 2, episodes: [EpisodeEntity(season: 2, number: 1), EpisodeEntity(season: 2, number: 2)]),
    ];

    final result = groupEpisodesBySeasonImpl(list);
    expect(result, expected);
  });
}