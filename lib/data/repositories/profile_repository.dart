import 'package:http/http.dart';
import 'package:instagram/config.dart';
import 'package:instagram/data/models/profile_model.dart';
import 'package:instagram/utils/http.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
}

class ProfileRepositoryImpl extends ProfileRepository {
  final Http http;

  ProfileRepositoryImpl(this.http);

  @override
  Future<ProfileModel> getProfile() async {
    Response response = await http.get(Endpoint.PROFILE);

    return Http.readResponse(response, (data) {
      return ProfileModel.fromJson(data);
    });
  }
}
