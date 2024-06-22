import 'package:flutter/material.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

enum TvSeriesPageStatus { loading, loaded, error, empty }

class TvSeriesState extends ChangeNotifier {
  TvSeriesPageStatus pageStatus = TvSeriesPageStatus.loading;
  bool loadingButton = false;

  int nextPage = 0;
  bool errorToReturnData = false;
  bool noMoreDataAvailable = false;
  List<TvShowEntity> allTvSeriesFetched = [];
  List<TvShowEntity> tvSeriesDisplayed = [];

  FetchListStatusEntity get currentStatus => FetchListStatusEntity(
    errorToReturnData: errorToReturnData,
    noMoreDataAvailable: noMoreDataAvailable,
    nextPage: nextPage,
    allTvSeriesFetched: allTvSeriesFetched,
    tvSeriesDisplayed: tvSeriesDisplayed,
  );

  void updateLoadingButton(bool value) {
    loadingButton = value;
    notifyListeners();
  }

  void updatePageStatus(TvSeriesPageStatus newStatus) {
    pageStatus = newStatus;
    notifyListeners();
  }

  void updateFetchListStatus(FetchListStatusEntity value) {
    if(value.allTvSeriesFetched.isEmpty) {
      if(value.errorToReturnData) {
        updatePageStatus(TvSeriesPageStatus.error);
        return;
      }
      updatePageStatus(TvSeriesPageStatus.empty);
      return;
    }

    updatePageStatus(TvSeriesPageStatus.loaded);
    noMoreDataAvailable = value.noMoreDataAvailable;
    errorToReturnData = value.errorToReturnData;
    nextPage = value.nextPage;
    tvSeriesDisplayed = value.tvSeriesDisplayed;
    allTvSeriesFetched = value.allTvSeriesFetched;
    notifyListeners();
  }
}
