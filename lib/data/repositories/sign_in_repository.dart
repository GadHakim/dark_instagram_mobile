import 'package:http/http.dart' as http;
import 'package:instagram/config.dart';
import 'package:instagram/data/models/sign_in_model.dart';
import 'package:instagram/utils/http.dart';

abstract class SignInRepository {
  Future<SignInModel> signIn(String email, String password);
}

class SignInRepositoryImpl extends SignInRepository {
  @override
  Future<SignInModel> signIn(String email, String password) async {
    var response = await http.post(Internet.SIGN_IN, body: {
      "email": email,
      "password": password,
    });

    return request(response, (data) {
      return SignInModel.fromJson(data);
    });
  }
}
