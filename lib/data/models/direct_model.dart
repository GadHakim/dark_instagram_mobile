class DirectModel {
  bool success;
  Direct result;

  DirectModel({this.success, this.result});

  DirectModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = json['result'] != null ? new Direct.fromJson(json['result']) : null;
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

class Direct {
  ChatCreator chatCreator;
  List<Chat> chats;

  Direct({this.chatCreator, this.chats});

  Direct.fromJson(Map<String, dynamic> json) {
    chatCreator =
        json['chat_creator'] != null ? new ChatCreator.fromJson(json['chat_creator']) : null;
    if (json['chats'] != null) {
      chats = new List<Chat>();
      json['chats'].forEach((v) {
        chats.add(new Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chatCreator != null) {
      data['chat_creator'] = this.chatCreator.toJson();
    }
    if (this.chats != null) {
      data['chats'] = this.chats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatCreator {
  int accountId;
  String email;
  String firstName;
  String lastName;
  String fullName;
  String avatarImagePath;

  ChatCreator(
      {this.accountId,
      this.email,
      this.firstName,
      this.lastName,
      this.fullName,
      this.avatarImagePath});

  ChatCreator.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    avatarImagePath = json['avatar_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['avatar_image_path'] = this.avatarImagePath;
    return data;
  }
}

class Chat {
  int accountId;
  String email;
  String firstName;
  String lastName;
  String fullName;
  String avatarImagePath;
  int chatId;
  String chatUuid;

  Chat(
      {this.accountId,
      this.email,
      this.firstName,
      this.lastName,
      this.fullName,
      this.avatarImagePath,
      this.chatId,
      this.chatUuid});

  Chat.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    avatarImagePath = json['avatar_image_path'];
    chatId = json['chat_id'];
    chatUuid = json['chat_uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['avatar_image_path'] = this.avatarImagePath;
    data['chat_id'] = this.chatId;
    data['chat_uuid'] = this.chatUuid;
    return data;
  }
}
