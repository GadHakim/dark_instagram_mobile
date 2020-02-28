class PeopleModel {
  bool success;
  List<Person> result;

  PeopleModel({this.success, this.result});

  PeopleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = new List<Person>();
      json['result'].forEach((v) {
        result.add(new Person.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Person {
  int accountId;
  String userEmail;
  String firstName;
  String lastName;
  String avatarImagePath;

  Person(
      {this.accountId,
        this.userEmail,
        this.firstName,
        this.lastName,
        this.avatarImagePath});

  Person.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    userEmail = json['user_email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatarImagePath = json['avatar_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['user_email'] = this.userEmail;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar_image_path'] = this.avatarImagePath;
    return data;
  }
}
