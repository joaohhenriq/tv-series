import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

class FavoriteSeriesPage extends StatefulWidget {
  const FavoriteSeriesPage({
    super.key,
    required this.favoriteSeriesSingleton,
  });

  final FavoriteSeriesSingleton favoriteSeriesSingleton;

  @override
  State<FavoriteSeriesPage> createState() => _FavoriteSeriesPageState();
}

class _FavoriteSeriesPageState extends State<FavoriteSeriesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<FavoriteSeriesState>();
      _fetchFavoriteSeries(
        favoriteSeries: widget.favoriteSeriesSingleton.favoriteSeries,
        updateFavoriteSeries: provider.updateFavoriteSeries,
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Favorite Series')),
        body: Consumer<FavoriteSeriesState>(builder: (
          context,
          provider,
          child,
        ) {
          if (widget.favoriteSeriesSingleton.favoriteSeries.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('No favorite series yet'),
              ),
            );
          }
          return FavoriteListView(
              favoriteSeries: provider.tvShowList,
              updateFavoriteSeries: () => _fetchFavoriteSeries(
                    favoriteSeries:
                        widget.favoriteSeriesSingleton.favoriteSeries,
                    updateFavoriteSeries: provider.updateFavoriteSeries,
                  ));
        }),
      );

  void _fetchFavoriteSeries({
    required List<TvShowEntity> favoriteSeries,
    required void Function(List<TvShowEntity>) updateFavoriteSeries,
  }) {
    updateFavoriteSeries(favoriteSeries);
  }
}
