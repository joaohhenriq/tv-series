import 'package:equatable/equatable.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

class FetchListStatusEntity extends Equatable {
  const FetchListStatusEntity({
    this.allTvSeriesFetched = const [],
    this.tvSeriesDisplayed = const [],
    this.nextPage = 0,
    this.errorToReturnData = false,
    this.noMoreDataAvailable = false,
  });

  final List<TvShowEntity> allTvSeriesFetched;
  final List<TvShowEntity> tvSeriesDisplayed;
  final int nextPage;
  final bool errorToReturnData;
  final bool noMoreDataAvailable;

  @override
  List<Object?> get props => [
        allTvSeriesFetched,
        tvSeriesDisplayed,
        nextPage,
        errorToReturnData,
        noMoreDataAvailable,
      ];

  FetchListStatusEntity copyWith({
    List<TvShowEntity>? allTvSeriesFetched,
    List<TvShowEntity>? tvSeriesDisplayed,
    int? nextPage,
    bool? errorToReturnData,
    bool? noMoreDataAvailable,
  }) =>
      FetchListStatusEntity(
        allTvSeriesFetched: allTvSeriesFetched ?? this.allTvSeriesFetched,
        tvSeriesDisplayed: tvSeriesDisplayed ?? this.tvSeriesDisplayed,
        nextPage: nextPage ?? this.nextPage,
        errorToReturnData: errorToReturnData ?? this.errorToReturnData,
        noMoreDataAvailable: noMoreDataAvailable ?? this.noMoreDataAvailable,
      );
}
