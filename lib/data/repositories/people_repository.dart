import 'package:http/http.dart' as http;
import 'package:instagram/data/models/people_model.dart';
import 'package:instagram/data/store.dart';
import 'package:instagram/utils/http.dart';

abstract class PeopleRepository {
  Future<PeopleModel> getPeople({
    int limit,
  });
}

class PeopleRepositoryImpl extends PeopleRepository {
  Store _store = Store();

  @override
  Future<PeopleModel> getPeople({
    int limit = 10,
  }) async {
    var uri = Uri.http('192.168.0.100:3000', 'people', {
      'limit': limit.toString(),
    });

    var response = await http.get(uri, headers: {
      "Authorization": "Bearer ${_store.accessToken}",
    });

    return request(response, (data) {
      return PeopleModel.fromJson(data);
    });
  }
}
