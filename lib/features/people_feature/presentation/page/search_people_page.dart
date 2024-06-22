import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features/shared/shared.dart';

class SearchPeoplePage extends StatefulWidget {
  const SearchPeoplePage({
    super.key,
    required this.getPersonByName,
  });

  final GetPersonByName getPersonByName;

  @override
  State<SearchPeoplePage> createState() => _SearchPeoplePageState();
}

class _SearchPeoplePageState extends State<SearchPeoplePage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Search People')),
        body: Column(
          children: [
            Consumer<SearchPeopleState>(
              builder: (context, provider, child) => SearchBarWidget(
                labelText: 'Search person',
                controller: textEditingController,
                loading: provider.pageStatus == SearchPeopleStatusEnum.loading,
                onTap: () => _searchPeople(
                  name: textEditingController.text,
                  updatePageStatus: provider.updatePageStatus,
                  updatePeopleList: provider.updatePeopleList,
                ),
              ),
            ),
            Consumer<SearchPeopleState>(
              builder: (context, provider, child) {
                switch (provider.pageStatus) {
                  case SearchPeopleStatusEnum.initial:
                    return const CenteredText(text: 'Search for a person');
                  case SearchPeopleStatusEnum.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case SearchPeopleStatusEnum.loaded:
                    return Expanded(
                      child: LoadedSearchPeople(
                        peopleList: provider.peopleList,
                      ),
                    );
                  case SearchPeopleStatusEnum.error:
                    return const CenteredText(
                      text: 'Oh, looks like something went wrong!',
                    );
                  case SearchPeopleStatusEnum.empty:
                    return const CenteredText(text: 'No data available');
                }
              },
            ),
          ],
        ),
      );

  Future<void> _searchPeople({
    required String name,
    required void Function(List<PersonEntity>) updatePeopleList,
    required void Function(SearchPeopleStatusEnum) updatePageStatus,
  }) async {
    if(name.isEmpty) return;
    FocusScope.of(context).unfocus();
    updatePageStatus(SearchPeopleStatusEnum.loading);
    final result = await widget.getPersonByName(textEditingController.text);
    if (result.isRight) {
      updatePeopleList(result.right);
    } else {
      switch (result.left) {
        case GetPeopleByNameEmptyListFailure():
          updatePageStatus(SearchPeopleStatusEnum.empty);
          break;
        case GetPeopleByNameCatchFailure():
          updatePageStatus(SearchPeopleStatusEnum.error);
          break;
        default:
          updatePageStatus(SearchPeopleStatusEnum.error);
          break;
      }
    }
  }
}
