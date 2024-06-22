import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

class TvSeriesPage extends StatefulWidget {
  const TvSeriesPage({
    super.key,
    required this.getSeriesListItems,
    required this.getFavoriteSeries,
  });

  final GetSeriesListItems getSeriesListItems;
  final GetFavoriteSeries getFavoriteSeries;

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<TvSeriesState>();
      await _fetchLists(
        currentStatusLists: provider.currentStatus,
        updateStatusLists: provider.updateFetchListStatus,
        updateLoadingButton: provider.updateLoadingButton,
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Tv Series'),
          actions: [
            Consumer<TvSeriesState>(
              builder: (context, provider, child) {
                if(provider.pageStatus != TvSeriesPageStatus.loaded) {
                  return const SizedBox.shrink();
                }
                return const FavoriteActionAppbar();
              }
            )
          ],
        ),
        body: Consumer<TvSeriesState>(
          builder: (context, provider, child) {
            switch (provider.pageStatus) {
              case TvSeriesPageStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case TvSeriesPageStatus.loaded:
                return LoadedInfo(
                  loadingButton: provider.loadingButton,
                  errorToReturnData: provider.errorToReturnData,
                  noMoreDataAvailable: provider.noMoreDataAvailable,
                  tvSeriesDisplayed: provider.tvSeriesDisplayed,
                  onFetchLists: () => _fetchLists(
                    currentStatusLists: provider.currentStatus,
                    updateStatusLists: provider.updateFetchListStatus,
                    updateLoadingButton: provider.updateLoadingButton,
                  ),
                );
              case TvSeriesPageStatus.error:
                return ErrorInfo(
                  loadingButton: provider.loadingButton,
                  onFetchLists: () => _fetchLists(
                    currentStatusLists: provider.currentStatus,
                    updateStatusLists: provider.updateFetchListStatus,
                    updateLoadingButton: provider.updateLoadingButton,
                  ),
                );
              case TvSeriesPageStatus.empty:
                return const EmptyInfo();
            }
          },
        ),
      );

  Future<void> _fetchLists({
    required FetchListStatusEntity currentStatusLists,
    required void Function(FetchListStatusEntity) updateStatusLists,
    required void Function(bool) updateLoadingButton,
  }) async {
    updateLoadingButton(true);
    final getListsStatus = await widget.getSeriesListItems(currentStatusLists);
    await widget.getFavoriteSeries();
    updateLoadingButton(false);
    updateStatusLists(getListsStatus);
  }
}
