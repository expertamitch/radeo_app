class AllRedeoMemberListResponseModel {
  AllRedeoMemberListResponseModel({
      this.message, 
      this.info,});

  AllRedeoMemberListResponseModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['info'] != null) {
      info = [];
      json['info'].forEach((v) {
        info!.add(Info.fromJson(v));
      });
    }
  }

  String? message;
  List<Info>? info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (info != null) {
      map['info'] = info!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class Info {
  Info({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.addedBy,
    this.createdAt,
    this.updatedAt,});

  Info.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  int? addedBy;
  String? createdAt;
  String? updatedAt;
  bool selected=false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['mobile'] = mobile;
    map['added_by'] = addedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}