class RegisterModel {
  String? message;
  Info? info;
  String? token;

  RegisterModel({this.message, this.info, this.token});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Info {
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? updatedAt;
  String? createdAt;
  int? id;

  Info(
      {this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.updatedAt,
        this.createdAt,
        this.id});

  Info.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
