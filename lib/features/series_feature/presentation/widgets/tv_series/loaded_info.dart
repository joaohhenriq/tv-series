import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features/shared/shared.dart';

class LoadedInfo extends StatelessWidget {
  const LoadedInfo({
    super.key,
    required this.errorToReturnData,
    required this.noMoreDataAvailable,
    required this.tvSeriesDisplayed,
    required this.onFetchLists,
    required this.loadingButton,
  });

  final bool errorToReturnData;
  final bool noMoreDataAvailable;
  final bool loadingButton;
  final List<TvShowEntity> tvSeriesDisplayed;
  final void Function() onFetchLists;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 12.0,
              left: 12.0,
              right: 12.0,
            ),
            child: SearchBarSeries(onTap: _onTapSearchSeries),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tvSeriesDisplayed.length + 1,
              itemBuilder: (context, index) {
                if (index == tvSeriesDisplayed.length) {
                  if (noMoreDataAvailable) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TvSeriesButton(
                      loading: loadingButton,
                      onTap: onFetchLists,
                      option: errorToReturnData
                          ? TvSeriesButtonOption.tryAgain
                          : TvSeriesButtonOption.loadMore,
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: CardInfo(
                    name: tvSeriesDisplayed[index].name,
                    summary: tvSeriesDisplayed[index].summary,
                    mediumImage: tvSeriesDisplayed[index].mediumImage,
                    onTap: () => _onTapTvSeriesCard(tvSeriesDisplayed[index]),
                  ),
                );
              },
            ),
          ),
        ],
      );

  void _onTapSearchSeries() =>
      Modular.to.pushNamed(SeriesNavigation.searchSeries);

  void _onTapTvSeriesCard(TvShowEntity tvShowEntity) => Modular.to.pushNamed(
        SeriesNavigation.seriesDetail,
        arguments: tvShowEntity,
      );
}
