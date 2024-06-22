import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features_core/network/network.dart';
import 'package:tv_series_app/features_util/apis/apis.dart';

const peopleSearchEndpoint = '$tvMazeUrl/search/people?q={name}';

abstract class PeopleRemoteDatasource {
  Future<List<PeopleModel>> getPersonByName(String name);
}

class PeopleRemoteDatasourceImpl implements PeopleRemoteDatasource {
  PeopleRemoteDatasourceImpl(this.network);

  final HttpNetwork network;

  @override
  Future<List<PeopleModel>> getPersonByName(String name) async {
    final response = await network.get(
      peopleSearchEndpoint.replaceAll('{name}', name),
    );
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => PeopleModel.fromMap(e))
          .toList();
    }
    throw Exception('Failed to load data');
  }
}
