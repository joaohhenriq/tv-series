import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features/shared/shared.dart';

class LoadedSearchPeople extends StatelessWidget {
  const LoadedSearchPeople({
    super.key,
    required this.peopleList,
  });

  final List<PersonEntity> peopleList;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: peopleList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12.0,
              left: 12.0,
              right: 12.0,
            ),
            child: CardInfo(
              name: peopleList[index].name,
              summary: '',
              mediumImage: peopleList[index].mediumImage,
              onTap: () => _onTapTvSeriesCard(peopleList[index]),
            ),
          );
        },
      );

  void _onTapTvSeriesCard(PersonEntity personEntity) => Modular.to.pushNamed(
        PeopleNavigation.personDetail,
        arguments: personEntity,
      );
}
