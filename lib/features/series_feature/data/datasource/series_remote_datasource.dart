import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_core/network/network.dart';
import 'package:tv_series_app/features_util/apis/apis.dart';

const showIndexEndpoint = '$tvMazeUrl/shows?page={page}';
const showSearchEndpoint = '$tvMazeUrl/search/shows?q={name}';
const showEpisodeEndpoint = '$tvMazeUrl/shows/{id}/episodes';

abstract class SeriesRemoteDatasource {
  Future<List<TvShowModel>> getTvSeriesByPage(int page);

  Future<List<TvShowModel>> getTvSeriesByName(String name);

  Future<List<EpisodeModel>> getEpisodesBySeriesId(int id);
}

class SeriesRemoteDatasourceImpl implements SeriesRemoteDatasource {
  SeriesRemoteDatasourceImpl(this.network);

  final HttpNetwork network;

  @override
  Future<List<TvShowModel>> getTvSeriesByPage(int page) async {
    final response = await network.get(
      showIndexEndpoint.replaceAll('{page}', page.toString()),
    );
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => TvShowModel.fromMap(e))
          .toList();
    } else if (response.statusCode == 404) {
      throw GetTvSeriesByPageNotFoundException();
    }
    throw Exception('Failed to load data');
  }

  @override
  Future<List<TvShowModel>> getTvSeriesByName(String name) async {
    final response = await network.get(
      showSearchEndpoint.replaceAll('{name}', name),
    );
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => TvShowModel.fromMap(e))
          .toList();
    }
    throw Exception('Failed to load data');
  }

  @override
  Future<List<EpisodeModel>> getEpisodesBySeriesId(int id) async {
    final response = await network.get(
      showEpisodeEndpoint.replaceAll('{id}', id.toString()),
    );
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => EpisodeModel.fromMap(e))
          .toList();
    }
    throw Exception('Failed to load data');
  }
}
