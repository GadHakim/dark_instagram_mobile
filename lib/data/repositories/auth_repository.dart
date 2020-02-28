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
    var response = await http.post(
      Uri.http(
        Endpoint.BASE_URL,
        Endpoint.LOGIN,
      ),
      body: {
        "email": email,
        "password": password,
      },
    );

    return Http.readResponse(response, (data) {
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
    var response = await http.post(
      Uri.http(
        Endpoint.BASE_URL,
        Endpoint.REGISTRATION,
      ),
      body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
      },
    );

    return Http.readResponse(response, (data) {
      return SignUpModel.fromJson(data);
    }, successStatusCode: 201);
  }
}
