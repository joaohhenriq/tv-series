import 'package:flutter/material.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.onFetchLists,
    required this.loadingButton,
  });

  final void Function() onFetchLists;
  final bool loadingButton;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Oh, looks like something went wrong!',
              ),
            ),
            TvSeriesButton(
              onTap: onFetchLists,
              option: TvSeriesButtonOption.tryAgain,
              loading: loadingButton,
            ),
          ],
        ),
      );
}
