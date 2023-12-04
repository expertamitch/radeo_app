import 'all_group_list_response_model.dart';

class EventsModel {
  String? message;
  List<EventInfoModel>? info;

  EventsModel({this.message, this.info});

  EventsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['info'] != null) {
      info = <EventInfoModel>[];
      json['info'].forEach((v) {
        info!.add(new EventInfoModel.fromJson(v));
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

class EventInfoModel {
  int? id;
  String? name;
  int? userId;
  String? location;
  String? description;
  DateTime? dateTime;

  String? recurrence;
  String? type;
  String? qrCode;
  String? createdAt;
  String? updatedAt;
  String? requested;
  List<UserData>? eventUsers;

  factory EventInfoModel.clone(EventInfoModel source) {
    List<UserData>? cloneUsers=[];
    source.eventUsers?.forEach((element) {
      cloneUsers.add(UserData.clone(element));
    });


    return EventInfoModel(
      id: source.id,
      name: source.name,
      userId: source.userId,
      location: source.location,
      description: source.description,
      dateTime: source.dateTime,
      recurrence: source.recurrence,
      type: source.type,
      qrCode: source.qrCode,
      createdAt: source.createdAt,
      updatedAt: source.updatedAt,
      requested: source.requested,
      eventUsers: cloneUsers,
    );
  }

  EventInfoModel(
      {this.id,
      this.name,
      this.userId,
      this.location,
      this.description,
      this.dateTime,
      this.recurrence,
      this.type,
      this.qrCode,
      this.createdAt,
      this.updatedAt,
      this.requested,
      this.eventUsers});

  EventInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    location = json['location'];
    description = json['description'];
    dateTime = DateTime.parse(json['date_time']);
    recurrence = json['recurrence'];
    type = json['type'];
    qrCode = json['qr_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    requested = json['requested'];
    if (json['event_users'] != null) {
      eventUsers = <UserData>[];
      json['event_users'].forEach((v) {
        eventUsers!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['date_time'] = this.dateTime;
    data['recurrence'] = this.recurrence;
    data['type'] = this.type;
    data['qr_code'] = this.qrCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['requested'] = this.requested;
    if (this.eventUsers != null) {
      data['event_users'] = this.eventUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
