class ProfileModel {
  bool success;
  Result result;

  ProfileModel({this.success, this.result});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String userEmail;
  String firstName;
  String lastName;
  String avatarImagePath;
  String fullName;

  Result({this.userEmail, this.firstName, this.lastName, this.avatarImagePath});

  Result.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatarImagePath = json['avatar_image_path'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email'] = this.userEmail;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar_image_path'] = this.avatarImagePath;
    data['full_name'] = this.fullName;
    return data;
  }
}
