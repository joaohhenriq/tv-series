import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features/shared/shared.dart';

class LoadedSearchInfo extends StatelessWidget {
  const LoadedSearchInfo({
    super.key,
    required this.tvSeriesDisplayed,
  });

  final List<TvShowEntity> tvSeriesDisplayed;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: tvSeriesDisplayed.length,
        itemBuilder: (context, index) {
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
      );

  void _onTapTvSeriesCard(TvShowEntity tvShowEntity) => Modular.to.pushNamed(
        SeriesNavigation.seriesDetail,
        arguments: tvShowEntity,
      );
}
