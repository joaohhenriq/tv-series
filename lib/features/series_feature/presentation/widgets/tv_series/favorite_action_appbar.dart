import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

class FavoriteActionAppbar extends StatelessWidget {
  const FavoriteActionAppbar({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.favorite),
        onPressed: _onTapFavoriteIcon,
      );

  void _onTapFavoriteIcon() =>
      Modular.to.pushNamed(SeriesNavigation.favoriteSeries);
}
