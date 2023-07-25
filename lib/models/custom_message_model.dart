import 'dart:io';

class CustomMessageModel {
  String? message;
  Info? info;

  CustomMessageModel({this.message, this.info});

  CustomMessageModel.fromJson(Map<String, dynamic> json,) {
    message = json['message'];
    info = json['info'] != null ? new Info.fromJson(json['info'], ) : null;
  }
}

class Info {
  List<CustomMessage>? customMessages;

  Info({this.customMessages});

  Info.fromJson(Map<String, dynamic> json, ) {
    if (json['audio'] != null) {
      customMessages = <CustomMessage>[];
      json['audio'].forEach((v) {
        customMessages!.add(new CustomMessage.fromJson(v));
      });
    }
    else if (json['text'] != null) {
      customMessages = <CustomMessage>[];
      json['text'].forEach((v) {
        customMessages!.add(new CustomMessage.fromJson(v));
      });
    }
    else if (json['video'] != null) {
      customMessages = <CustomMessage>[];
      json['video'].forEach((v) {
        customMessages!.add(new CustomMessage.fromJson(v));
      });
    }
    else if (json['checkbox'] != null) {
      customMessages = <CustomMessage>[];
      json['checkbox'].forEach((v) {
        customMessages!.add(new CustomMessage.fromJson(v));
      });
    }
  }

}

class CustomMessage {
  int? id;
  bool isSelected=false;
  int? userId;
  String? content;
  String? title;
  String? thumbnail;
  String? file;
  String? type;
  String? createdAt;
  String? updatedAt;

  CustomMessage(
      {this.id,
        this.userId,
        this.isSelected=false,
        this.content,
        this.thumbnail,
        this.file,
        this.title,
        this.type,
        this.createdAt,
        this.updatedAt});

  CustomMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    userId = json['user_id'];
    content = json['content'];
    title = json['title'];
    file = json['file'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

}
