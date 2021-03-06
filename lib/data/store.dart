import 'package:instagram/data/models/sign_in_model.dart';
import 'package:instagram/data/models/sign_up_model.dart';

class Store {
  static final Store _singleton = Store._internal();

  String _accessToken;
  String _refreshToken;

  String get accessToken => _accessToken;

  String get refreshToken => _refreshToken;

  set token(SignInModel model) {
    _accessToken = model.result.accessToken;
    _refreshToken = model.result.refreshToken;
  }

  set signUpModel(SignUpModel model) {
    _accessToken = model.result.accessToken;
    _refreshToken = model.result.refreshToken;
  }

  factory Store() {
    return _singleton;
  }

  Store._internal();

  @override
  String toString() {
    return ''
        'Store'
        '[accessToken: $_accessToken] '
        '[refreshToken: $_refreshToken]'
        '';
  }
}
