class AllPostModel {
  bool success;
  List<AllPost> result;

  AllPostModel({this.success, this.result});

  AllPostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = new List<AllPost>();
      json['result'].forEach((v) {
        result.add(new AllPost.fromJson(v));
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

class AllPost {
  int publicationId;
  int accountId;
  int likeCount;
  String comment;
  List<Content> content;
  PostCreator postCreator;
  List<Comments> comments;

  AllPost(
      {this.publicationId,
        this.accountId,
        this.likeCount,
        this.comment,
        this.content,
        this.postCreator,
        this.comments});

  AllPost.fromJson(Map<String, dynamic> json) {
    publicationId = json['publication_id'];
    accountId = json['account_id'];
    likeCount = json['like_count'];
    comment = json['comment'];
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
    postCreator = json['post_creator'] != null
        ? new PostCreator.fromJson(json['post_creator'])
        : null;
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publication_id'] = this.publicationId;
    data['account_id'] = this.accountId;
    data['like_count'] = this.likeCount;
    data['comment'] = this.comment;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    if (this.postCreator != null) {
      data['post_creator'] = this.postCreator.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  int contentId;
  String contentType;
  String contentPath;

  Content({this.contentId, this.contentType, this.contentPath});

  Content.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    contentType = json['content_type'];
    contentPath = json['content_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_id'] = this.contentId;
    data['content_type'] = this.contentType;
    data['content_path'] = this.contentPath;
    return data;
  }
}

class PostCreator {
  String email;
  String firstName;
  String lastName;
  String fullName;
  String avatarImagePath;

  PostCreator(
      {this.email,
        this.firstName,
        this.lastName,
        this.fullName,
        this.avatarImagePath});

  PostCreator.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    avatarImagePath = json['avatar_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['avatar_image_path'] = this.avatarImagePath;
    return data;
  }
}

class Comments {
  int publicationCommentId;
  String comment;
  CommentUser commentUser;

  Comments({this.publicationCommentId, this.comment, this.commentUser});

  Comments.fromJson(Map<String, dynamic> json) {
    publicationCommentId = json['publication_comment_id'];
    comment = json['comment'];
    commentUser = json['comment_user'] != null
        ? new CommentUser.fromJson(json['comment_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publication_comment_id'] = this.publicationCommentId;
    data['comment'] = this.comment;
    if (this.commentUser != null) {
      data['comment_user'] = this.commentUser.toJson();
    }
    return data;
  }
}

class CommentUser {
  int accountId;
  String email;
  String firstName;
  String lastName;
  String fullName;
  String avatarImagePath;

  CommentUser(
      {this.accountId,
        this.email,
        this.firstName,
        this.lastName,
        this.fullName,
        this.avatarImagePath});

  CommentUser.fromJson(Map<String, dynamic> json) {
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
