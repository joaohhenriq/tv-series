import 'package:tv_series_app/features/series_feature/series_feature.dart';

abstract class GetSeriesListItems {
  Future<FetchListStatusEntity> call(FetchListStatusEntity currentStatus);
}

class GetSeriesListItemsImpl implements GetSeriesListItems {
  GetSeriesListItemsImpl({required this.getTvSeriesByPage});

  final GetTvSeriesByPage getTvSeriesByPage;

  static const _numberOfTvSeriesDisplayed = 40;

  @override
  Future<FetchListStatusEntity> call(
    FetchListStatusEntity currentStatus,
  ) async {
    if (currentStatus.allTvSeriesFetched.isEmpty) {
      return await _fetchAndSetInitialSeries(currentStatus);
    } else if (currentStatus.tvSeriesDisplayed.length !=
        currentStatus.allTvSeriesFetched.length) {
      return _loadMoreDisplayedSeries(currentStatus);
    } else {
      return await _fetchAndAppendMoreSeries(currentStatus);
    }
  }

  Future<FetchListStatusEntity> _fetchAndSetInitialSeries(
    FetchListStatusEntity currentStatus,
  ) async {
    final series = await _fetchTvSeries(currentStatus.nextPage);
    if (series == null) {
      return currentStatus.copyWith(errorToReturnData: true);
    } else if (series.isEmpty) {
      return currentStatus.copyWith(noMoreDataAvailable: true);
    }
    return FetchListStatusEntity(
      nextPage: currentStatus.nextPage + 1,
      allTvSeriesFetched: series,
      tvSeriesDisplayed: series.sublist(0, _getDisplayLimit(series.length)),
    );
  }

  FetchListStatusEntity _loadMoreDisplayedSeries(
    FetchListStatusEntity currentStatus,
  ) {
    final remainingSeriesCount = currentStatus.allTvSeriesFetched.length -
        currentStatus.tvSeriesDisplayed.length;
    final displayLimit = remainingSeriesCount < _numberOfTvSeriesDisplayed
        ? remainingSeriesCount
        : _numberOfTvSeriesDisplayed;

    return FetchListStatusEntity(
      nextPage: currentStatus.nextPage,
      allTvSeriesFetched: currentStatus.allTvSeriesFetched,
      tvSeriesDisplayed: [
        ...currentStatus.tvSeriesDisplayed,
        ...currentStatus.allTvSeriesFetched.sublist(
          currentStatus.tvSeriesDisplayed.length,
          currentStatus.tvSeriesDisplayed.length + displayLimit,
        ),
      ],
    );
  }

  Future<FetchListStatusEntity> _fetchAndAppendMoreSeries(
    FetchListStatusEntity currentStatus,
  ) async {
    final moreTvSeries = await _fetchTvSeries(currentStatus.nextPage);
    if (moreTvSeries == null) {
      return currentStatus.copyWith(errorToReturnData: true);
    } else if (moreTvSeries.isEmpty) {
      return currentStatus.copyWith(noMoreDataAvailable: true);
    }
    return FetchListStatusEntity(
      nextPage: currentStatus.nextPage + 1,
      allTvSeriesFetched: [
        ...currentStatus.allTvSeriesFetched,
        ...moreTvSeries
      ],
      tvSeriesDisplayed: [
        ...currentStatus.tvSeriesDisplayed,
        ...moreTvSeries.sublist(0, _getDisplayLimit(moreTvSeries.length)),
      ],
    );
  }

  Future<List<TvShowEntity>?> _fetchTvSeries(int page) async {
    final result = await getTvSeriesByPage(page);
    if (result.isRight) {
      return result.right;
    } else if (result.isLeft &&
        result.left is GetTvSeriesByPageNotFoundFailure) {
      return [];
    }
    return null;
  }

  int _getDisplayLimit(int length) =>
      length < _numberOfTvSeriesDisplayed ? length : _numberOfTvSeriesDisplayed;
}
