import 'package:http/http.dart';
import 'package:instagram/config.dart';
import 'package:instagram/data/models/direct_model.dart';
import 'package:instagram/utils/http.dart';

abstract class DirectRepository {
  Future<DirectModel> getDirect({
    int limit,
  });
}

class DirectRepositoryImpl extends DirectRepository {
  final Http http;

  DirectRepositoryImpl(this.http);

  @override
  Future<DirectModel> getDirect({
    int limit = 10,
  }) async {
    Response response = await http.get(Endpoint.ALL_DIRECT, {
      'limit': limit.toString(),
    });

    return Http.readResponse(response, (data) {
      return DirectModel.fromJson(data);
    });
  }
}
