import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features/shared/shared.dart';

class SearchSeriesPage extends StatefulWidget {
  const SearchSeriesPage({
    super.key,
    required this.getTvSeriesByName,
  });

  final GetTvSeriesByName getTvSeriesByName;

  @override
  State<SearchSeriesPage> createState() => _SearchSeriesPageState();
}

class _SearchSeriesPageState extends State<SearchSeriesPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Search Series')),
        body: Column(
          children: [
            Consumer<SearchSeriesState>(
              builder: (context, provider, child) => SearchBarWidget(
                labelText: 'Search series',
                controller: textEditingController,
                loading: provider.pageStatus == SearchSeriesStatusEnum.loading,
                onTap: () => _searchSeries(
                  name: textEditingController.text,
                  updatePageStatus: provider.updatePageStatus,
                  updateTvSeriesDisplayed: provider.updateTvSeriesDisplayed,
                ),
              ),
            ),
            Consumer<SearchSeriesState>(
              builder: (context, provider, child) {
                switch (provider.pageStatus) {
                  case SearchSeriesStatusEnum.initial:
                    return const CenteredText(text: 'Search for a series');
                  case SearchSeriesStatusEnum.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case SearchSeriesStatusEnum.loaded:
                    return Expanded(
                      child: LoadedSearchInfo(
                        tvSeriesDisplayed: provider.tvSeriesDisplayed,
                      ),
                    );
                  case SearchSeriesStatusEnum.error:
                    return const CenteredText(
                      text: 'Oh, looks like something went wrong!',
                    );
                  case SearchSeriesStatusEnum.empty:
                    return const CenteredText(text: 'No data available');
                }
              },
            ),
          ],
        ),
      );

  Future<void> _searchSeries({
    required String name,
    required void Function(List<TvShowEntity>) updateTvSeriesDisplayed,
    required void Function(SearchSeriesStatusEnum) updatePageStatus,
  }) async {
    if(name.isEmpty) return;
    FocusScope.of(context).unfocus();
    updatePageStatus(SearchSeriesStatusEnum.loading);
    final result = await widget.getTvSeriesByName(textEditingController.text);
    if (result.isRight) {
      updateTvSeriesDisplayed(result.right);
    } else {
      switch (result.left) {
        case GetTvSeriesByNameEmptyListFailure():
          updatePageStatus(SearchSeriesStatusEnum.empty);
          break;
        case GetTvSeriesByNameCatchFailure():
          updatePageStatus(SearchSeriesStatusEnum.error);
          break;
        default:
          updatePageStatus(SearchSeriesStatusEnum.error);
          break;
      }
    }
  }
}
