import 'package:http/http.dart';
import 'package:instagram/config.dart';
import 'package:instagram/data/models/http_success_model.dart';
import 'package:instagram/data/store.dart';
import 'package:instagram/utils/http.dart';

abstract class SubscribersRepository {
  Future<HttpSuccess> subscribe(int subscriberId);

  Future<HttpSuccess> unsubscribe(int subscriberId);
}

class SubscribersRepositoryImpl extends SubscribersRepository {
  final Http http;
  final Store store = Store();

  SubscribersRepositoryImpl(this.http);

  @override
  Future<HttpSuccess> subscribe(int subscriberId) async {
    Response response = await http.post(Endpoint.SUBSCRIBE, body: {
      'subscriber_id': subscriberId.toString(),
    });

    return Http.readResponse(response, (data) {
      return HttpSuccess.fromJson(data);
    });
  }

  @override
  Future<HttpSuccess> unsubscribe(int subscriberId) async {
    Response response = await http.post(Endpoint.UNSUBSCRIBE, body: {
      'subscriber_id': subscriberId.toString(),
    });

    return Http.readResponse(response, (data) {
      return HttpSuccess.fromJson(data);
    });
  }
}
