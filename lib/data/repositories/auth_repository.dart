import 'package:http/http.dart' as http;
import 'package:instagram/config.dart';
import 'package:instagram/data/models/sign_in_model.dart';
import 'package:instagram/data/models/sign_up_model.dart';
import 'package:instagram/utils/http.dart';

abstract class AuthRepository {
  Future<SignInModel> signIn(
    String email,
    String password,
  );

  Future<SignUpModel> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
  );
}

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<SignInModel> signIn(
    String email,
    String password,
  ) async {
    var response = await http.post(Internet.SIGN_IN, body: {
      "email": email,
      "password": password,
    });

    return request(response, (data) {
      return SignInModel.fromJson(data);
    });
  }

  @override
  Future<SignUpModel> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    var response = await http.post(Internet.SIGN_UP, body: {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
    });

    return request(response, (data) {
      return SignUpModel.fromJson(data);
    }, statusCodeSuccess: 201);
  }
}
