import 'dart:convert';

import 'package:instagram/data/models/http_error_model.dart';

request(
  response,
  result, {
  int statusCodeSuccess = 200,
}) {
  var data = json.decode(response.body);
  if (response.statusCode == statusCodeSuccess) {
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
