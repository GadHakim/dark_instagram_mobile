import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instagram/config.dart';
import 'package:instagram/data/models/http_error_model.dart';
import 'package:instagram/data/store.dart';

abstract class Http {
  Future<http.Response> get(path, [Map<String, String> queryParameters]);

  Future<http.Response> post(path, {body});

  Future<http.Response> put(path, {body});

  Future<http.Response> delete(path, [Map<String, String> queryParameters]);

  static readResponse(
    response,
    result, {
    int successStatusCode = 200,
  }) {
    var data = json.decode(response.body);
    if (response.statusCode == successStatusCode) {
      return result(data);
    } else {
      HttpErrorModel errorModel = HttpErrorModel.fromJson(data);
      throw HttpError(
        errorModel.success,
        errorModel.message,
        errorModel.error,
        errorModel.errorCode,
      );
    }
  }
}

class HttpImpl extends Http {
  static final Store store = Store();

  @override
  get(path, [Map<String, String> queryParameters]) async {
    return await http.get(
      Uri.http(Endpoint.BASE_URL, path, queryParameters),
      headers: {'Authorization': "Bearer ${store.accessToken}"},
    );
  }

  @override
  Future<http.Response> post(path, {body}) async {
    return await http.post(
      Uri.http(Endpoint.BASE_URL, path),
      headers: {'Authorization': "Bearer ${store.accessToken}"},
      body: body,
    );
  }

  @override
  Future<http.Response> put(path, {body}) async {
    return await http.put(
      Uri.http(Endpoint.BASE_URL, path),
      headers: {'Authorization': "Bearer ${store.accessToken}"},
      body: body,
    );
  }

  @override
  Future<http.Response> delete(path, [Map<String, String> queryParameters]) async {
    return await http.delete(
      Uri.http(Endpoint.BASE_URL, path, queryParameters),
      headers: {'Authorization': "Bearer ${store.accessToken}"},
    );
  }
}
