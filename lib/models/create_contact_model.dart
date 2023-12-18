class CreateContactModel {
  String? message;
  Info? info;

  CreateContactModel({this.message, this.info});

  CreateContactModel.fromJson(Map<String, dynamic> json) {
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
  String? mobile;
  String? firstName;
  String? lastName;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Info(
      {this.mobile,
        this.firstName,
        this.lastName,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Info.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
