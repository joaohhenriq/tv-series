import 'dart:convert';

import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_core/local_storage/local_storage.dart';

abstract class SeriesLocalDatasource {
  Future<List<TvShowModel>> getFavoriteSeries();

  Future<List<TvShowModel>> addFavoriteSeries(TvShowModel tvShowModel);

  Future<List<TvShowModel>> deleteFromFavoriteSeries(int id);
}

class SeriesLocalDatasourceImpl implements SeriesLocalDatasource {
  SeriesLocalDatasourceImpl(this.sharedPreferencesClient);

  final SharedPreferencesClient sharedPreferencesClient;

  static const favoriteSeriesKey = 'favoriteSeries';

  @override
  Future<List<TvShowModel>> getFavoriteSeries() async {
    final favoriteSeriesValue =
        await sharedPreferencesClient.getString(favoriteSeriesKey);
    if (favoriteSeriesValue != null && favoriteSeriesValue.isNotEmpty) {
      final List<dynamic> favoriteSeriesList = json.decode(favoriteSeriesValue);
      return favoriteSeriesList.map((e) => TvShowModel.fromMap(e)).toList();
    }
    return [];
  }

  @override
  Future<List<TvShowModel>> addFavoriteSeries(TvShowModel tvShowModel) async {
    final favoriteSeries = await getFavoriteSeries();
    favoriteSeries.add(tvShowModel);
    final result = await sharedPreferencesClient.setString(
      favoriteSeriesKey,
      json.encode(favoriteSeries.map((e) => e.toMap()).toList()),
    );
    if(result) return favoriteSeries;
    throw AddFavoriteSeriesException();
  }

  @override
  Future<List<TvShowModel>> deleteFromFavoriteSeries(int id) async {
    final favoriteSeries = await getFavoriteSeries();
    favoriteSeries.removeWhere((element) => element.id == id);
    final result =  await sharedPreferencesClient.setString(
      favoriteSeriesKey,
      json.encode(favoriteSeries.map((e) => e.toMap()).toList()),
    );
    if(result) return favoriteSeries;
    throw DeleteFromFavoriteSeriesException();
  }
}
