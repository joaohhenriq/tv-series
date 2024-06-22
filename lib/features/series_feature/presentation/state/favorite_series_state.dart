import 'package:flutter/material.dart';
import 'package:tv_series_app/features/series_feature/domain/entity/tv_show_entity.dart';

class FavoriteSeriesState extends ChangeNotifier {
  List<TvShowEntity> tvShowList = [];

  void updateFavoriteSeries(List<TvShowEntity> value) {
    tvShowList = value;
    notifyListeners();
  }
}