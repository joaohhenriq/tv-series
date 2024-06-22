import 'package:flutter/material.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

enum SearchSeriesStatusEnum {
  initial,
  loading,
  loaded,
  error,
  empty,
}

class SearchSeriesState extends ChangeNotifier {
  SearchSeriesStatusEnum pageStatus = SearchSeriesStatusEnum.initial;

  List<TvShowEntity> tvSeriesDisplayed = [];

  void updatePageStatus(SearchSeriesStatusEnum newStatus) {
    pageStatus = newStatus;
    notifyListeners();
  }

  void updateTvSeriesDisplayed(List<TvShowEntity> value) {
    pageStatus = SearchSeriesStatusEnum.loaded;
    tvSeriesDisplayed = value;
    notifyListeners();
  }
}