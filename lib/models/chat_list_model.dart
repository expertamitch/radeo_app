class ChatListModel {
  String? message;
  List<ChatListItem>? info;

  ChatListModel({this.message, this.info});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['info'] != null) {
      info = <ChatListItem>[];
      json['info'].forEach((v) {
        info!.add(new ChatListItem.fromJson(v));
      });
    }
  }
}

class ChatListItem {
  int? userId;
  User? user;

  ChatListItem({this.userId, this.user});

  ChatListItem.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  int? addedBy;
  String? loginType;
  String? profileImage;
  String? createdAt;
  String? updatedAt;
  Message? message;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.profileImage,
      this.mobile,
      this.addedBy,
      this.loginType,
      this.createdAt,
      this.updatedAt,
      this.message});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    profileImage = json['profile_image'];
    addedBy = json['added_by'];
    loginType = json['login_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }
}

class Message {
  int? id;
  int? userId;
  String? location;
  String? messageType;
  String? messageContent;
  List<String>? attachments;
  String? responseType;
  String? responses;
  DateTime? createdAt;
  String? updatedAt;

  Message(
      {this.id,
      this.userId,
      this.location,
      this.messageType,
      this.messageContent,
      this.attachments,
      this.responseType,
      this.responses,
      this.createdAt,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    location = json['location'];
    messageType = json['message_type'];
    messageContent = json['message_content'];
    attachments = json['attachments']!=null?json['attachments'].cast<String>():[];
    responseType = json['response_type'];
    responses = json['responses'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['location'] = this.location;
    data['message_type'] = this.messageType;
    data['message_content'] = this.messageContent;
    data['attachments'] = this.attachments;
    data['response_type'] = this.responseType;
    data['responses'] = this.responses;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
