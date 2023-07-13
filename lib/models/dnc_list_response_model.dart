class DNCListResponseModel {
  String? message;
  List<Info>? info;

  DNCListResponseModel({this.message, this.info});

  DNCListResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['info'] != null) {
      info = <Info>[];
      json['info'].forEach((v) {
        info!.add(new Info.fromJson(v));
      });
    }
  }

 }

class Info {
  int? id;
  int? userId;
  String? name;
  String? location;
  String? email;
  String? phoneNo;
  int? noeId;
  String? createdAt;
  String? updatedAt;

  Info(
      {this.id,
        this.userId,
        this.name,
        this.location,
        this.email,
        this.phoneNo,
        this.noeId,
        this.createdAt,
        this.updatedAt});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    location = json['location'];
    email = json['email'];
    phoneNo = json['phone_no'];
    noeId = json['noe_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

 }
