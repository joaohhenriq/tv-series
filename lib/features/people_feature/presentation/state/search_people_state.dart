import 'package:flutter/material.dart';
import 'package:tv_series_app/features/people_feature/people_feature.dart';

enum SearchPeopleStatusEnum {
  initial,
  loading,
  loaded,
  error,
  empty,
}

class SearchPeopleState extends ChangeNotifier {
  SearchPeopleStatusEnum pageStatus = SearchPeopleStatusEnum.initial;

  List<PersonEntity> peopleList = [];

  void updatePageStatus(SearchPeopleStatusEnum newStatus) {
    pageStatus = newStatus;
    notifyListeners();
  }

  void updatePeopleList(List<PersonEntity> value) {
    pageStatus = SearchPeopleStatusEnum.loaded;
    peopleList = value;
    notifyListeners();
  }
}