class HttpError implements Error {
  final bool success;
  final String message;
  final String error;
  final int errorCode;

  HttpError(this.success, this.message, this.error, this.errorCode);

  @override
  StackTrace get stackTrace => null;
}

class HttpErrorModel {
  bool success;
  String message;
  String error;
  int errorCode;

  HttpErrorModel({this.success, this.message, this.error, this.errorCode});

  HttpErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    error = json['error'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['error'] = this.error;
    data['errorCode'] = this.errorCode;
    return data;
  }
}
