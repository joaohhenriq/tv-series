import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features/shared/shared.dart';

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({
    super.key,
    required this.favoriteSeries,
    required this.updateFavoriteSeries,
  });

  final List<TvShowEntity> favoriteSeries;
  final void Function() updateFavoriteSeries;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: favoriteSeries.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12.0,
              left: 12.0,
              right: 12.0,
            ),
            child: CardInfo(
              name: favoriteSeries[index].name,
              summary: favoriteSeries[index].summary,
              mediumImage: favoriteSeries[index].mediumImage,
              onTap: () => _onTapTvSeriesCard(favoriteSeries[index]),
            ),
          );
        },
      );

  Future<void> _onTapTvSeriesCard(TvShowEntity tvShowEntity) async {
    await Modular.to.pushNamed(
      SeriesNavigation.seriesDetail,
      arguments: tvShowEntity,
    );
    updateFavoriteSeries();
  }
}
