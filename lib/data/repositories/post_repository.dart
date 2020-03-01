import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:instagram/config.dart';
import 'package:instagram/data/models/all_post_model.dart';
import 'package:instagram/data/models/subscribers_posts_model.dart';
import 'package:instagram/data/store.dart';
import 'package:instagram/utils/http.dart';
import 'package:path/path.dart';

abstract class PostRepository {
  Future<AllPostModel> getAllPost({
    int limit,
  });

  Future<SubscribersPostsModel> getSubscribersPosts({
    int limit,
  });

  Future addPost({
    String comment,
    List<File> file,
  });
}

class PostRepositoryImpl extends PostRepository {
  final Http http;
  final Store store = Store();

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

  @override
  Future<SubscribersPostsModel> getSubscribersPosts({
    int limit = 10,
  }) async {
    Response response = await http.get(Endpoint.SUBSCRIBERS_POSTS, {
      'limit': limit.toString(),
    });

    return Http.readResponse(response, (data) {
      return SubscribersPostsModel.fromJson(data);
    });
  }

  @override
  Future addPost({
    String comment,
    List<File> file,
  }) async {
    print(file);

    var uri = Uri.http(Endpoint.BASE_URL, Endpoint.ADD_POST);
    var request = new MultipartRequest("POST", uri);
    request.headers['Authorization'] = "Bearer ${store.accessToken}";
    request.fields['comment'] = comment;

    List<MultipartFile> newList = new List<MultipartFile>();
    for (int i = 0; i < file.length; i++) {
      File imageFile = file[i];
      var stream = new ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = new MultipartFile(
        "content",
        stream,
        length,
        filename: basename(imageFile.path),
      );
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
