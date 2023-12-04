class ChatHistoryModel {
  String? message;
  List<MessageItemData>? info;

  ChatHistoryModel({this.message, this.info});

  ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['info'] != null) {
      info = <MessageItemData>[];
      json['info'].forEach((v) {
        info!.add(new MessageItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageItemData {
  int? id;
  int? userId;
   String? messageType;
  String? messageContent;
   List<String>? attachments;
  String? responseType;
   int? forUser;
  DateTime? createdAt;
  String? updatedAt;
  String? side;

  MessageItemData(
      {this.id,
        this.userId,
         this.messageType,
        this.messageContent,
         this.attachments,
        this.responseType,
          this.forUser,
        this.createdAt,
        this.updatedAt,
        this.side});

  MessageItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
     messageType = json['message_type'];
    messageContent = json['message_content'];
     attachments =json['attachments']==null?[]: json['attachments'].cast<String>();
    responseType = json['response_type'];
     forUser = json['for_user'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = json['updated_at'];
    side = json['side'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
     data['message_type'] = this.messageType;
    data['message_content'] = this.messageContent;
     data['attachments'] = this.attachments;
    data['response_type'] = this.responseType;
      data['for_user'] = this.forUser;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['side'] = this.side;
    return data;
  }
}
