import 'package:tv_series_app/features/series_feature/series_feature.dart';

abstract class GroupEpisodesBySeason {
  List<SeasonEntity> call(List<EpisodeEntity> episodeList);
}

class GroupEpisodesBySeasonImpl implements GroupEpisodesBySeason {
  @override
  List<SeasonEntity> call(List<EpisodeEntity> episodeList) {
    if (episodeList.isEmpty) return [];

    List<EpisodeEntity> orderedEpisodeList = _orderList(episodeList);
    Map<int, List<EpisodeEntity>> seasonMap =
        _groupBySeasonWithMap(orderedEpisodeList);
    return _convertSeasonMapToEntityList(seasonMap);
  }

  List<EpisodeEntity> _orderList(
    List<EpisodeEntity> episodeList,
  ) {
    if (episodeList.isEmpty) return [];
    List<EpisodeEntity> orderedList = List.from(episodeList);
    orderedList.sort((a, b) {
      int compareSeason = a.season.compareTo(b.season);
      return compareSeason != 0 ? compareSeason : a.number.compareTo(b.number);
    });
    return orderedList;
  }

  Map<int, List<EpisodeEntity>> _groupBySeasonWithMap(
    List<EpisodeEntity> episodeList,
  ) {
    Map<int, List<EpisodeEntity>> seasonMap = {};
    for (final episode in episodeList) {
      if (!seasonMap.containsKey(episode.season)) {
        seasonMap[episode.season] = [];
      }
      seasonMap[episode.season]!.add(episode);
    }
    return seasonMap;
  }

  List<SeasonEntity> _convertSeasonMapToEntityList(
    Map<int, List<EpisodeEntity>> seasonMap,
  ) {
    return seasonMap.entries.map((entry) {
      return SeasonEntity(
        number: entry.key,
        episodes: entry.value,
      );
    }).toList();
  }
}
