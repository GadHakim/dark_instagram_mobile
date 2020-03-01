import 'package:http/http.dart';
import 'package:instagram/config.dart';
import 'package:instagram/data/models/people_model.dart';
import 'package:instagram/utils/http.dart';

abstract class PeopleRepository {
  Future<PeopleModel> getPeople({
    int limit,
  });

  Future<PeopleModel> getSubscribers({
    int limit,
  });
}

class PeopleRepositoryImpl extends PeopleRepository {
  final Http http;

  PeopleRepositoryImpl(this.http);

  @override
  Future<PeopleModel> getPeople({
    int limit = 10,
  }) async {
    Response response = await http.get(Endpoint.PEOPLE, {
      'limit': limit.toString(),
    });

    return Http.readResponse(response, (data) {
      return PeopleModel.fromJson(data);
    });
  }

  @override
  Future<PeopleModel> getSubscribers({
    int limit = 10,
  }) async {
    Response response = await http.get(Endpoint.GET_SUBSCRIBERS, {
      'limit': limit.toString(),
    });

    return Http.readResponse(response, (data) {
      return PeopleModel.fromJson(data);
    });
  }
}
