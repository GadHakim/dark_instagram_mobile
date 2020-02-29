import 'package:http/http.dart';
import 'package:instagram/config.dart';
import 'package:instagram/data/models/all_post_model.dart';
import 'package:instagram/utils/http.dart';

abstract class PostRepository {
  Future<AllPostModel> getAllPost({
    int limit,
  });
}

class PostRepositoryImpl extends PostRepository {
  final Http http;

  PostRepositoryImpl(this.http);

  @override
  Future<AllPostModel> getAllPost({
    int limit = 10,
  }) async {
    Response response = await http.get(Endpoint.ALL_POST, {
      'limit': limit.toString(),
    });

    return Http.readResponse(response, (data) {
      return AllPostModel.fromJson(data);
    });
  }
}
