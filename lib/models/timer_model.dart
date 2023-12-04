class TimerModel {
  String? message;
  Info? info;

  TimerModel({this.message, this.info});

  TimerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}

class Info {
  int? id;
  int? userId;
  String? lastUpdatedTime;
  String? date;
  String? time;
  String? status;
  String? createdAt;
  String? updatedAt;

  Info(
      {this.id,
        this.userId,
        this.lastUpdatedTime,
        this.date,
        this.time,
        this.status,
        this.createdAt,
        this.updatedAt});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lastUpdatedTime = json['last_updated_time'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['last_updated_time'] = this.lastUpdatedTime;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

