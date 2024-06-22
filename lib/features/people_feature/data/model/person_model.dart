import 'package:tv_series_app/features/people_feature/people_feature.dart';

class PeopleModel extends PersonEntity {
  const PeopleModel({
    super.id = 0,
    super.name = '',
    super.mediumImage = '',
    super.originalImage = '',
  });

  factory PeopleModel.fromMap(Map<String, dynamic> map) {
    final show = map['person'] ?? map;
    return PeopleModel(
      id: show['id'] ?? 0,
      name: show['name'] ?? '',
      mediumImage: show['image'] != null && show['image']['medium'] != null
          ? show['image']['medium']
          : '',
      originalImage: show['image'] != null && show['image']['original'] != null
          ? show['image']['original']
          : '',
    );
  }
}
