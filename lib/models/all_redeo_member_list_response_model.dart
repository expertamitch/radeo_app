class AllRedeoMemberListResponseModel {
  AllRedeoMemberListResponseModel({
    this.message,
    this.info,
  });

  AllRedeoMemberListResponseModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['info'] != null) {
      info = [];
      json['info'].forEach((v) {
        info!.add(ContactInfo.fromJson(v));
      });
    }
  }

  String? message;
  List<ContactInfo>? info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (info != null) {
      map['info'] = info!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ContactInfo {
  ContactInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.country_code,
    this.mobile,
    this.isAttendant=false,
    this.addedBy,
    this.fullName,this.selected=false,
    this.createdAt,
    this.updatedAt,
  });

  factory ContactInfo.clone(ContactInfo source) {
    return ContactInfo(
      country_code: source.country_code,
      id: source.id,
      firstName: source.firstName,
      lastName: source.lastName,
      email: source.email,
      mobile: source.mobile,
      addedBy: source.addedBy,
      createdAt: source.createdAt,
      fullName: source.fullName,
      updatedAt: source.updatedAt,
      selected: source.selected,
      isAttendant: source.isAttendant,


    );
  }

  ContactInfo.fromJson(dynamic json) {
    country_code = json['country_code'];
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName="$firstName ${lastName??''}";
  }

  int? id;
  String? firstName;
  String? country_code;
  String? fullName;
  String? lastName;
  String? email;
  String? mobile;
  int? addedBy;
  String? createdAt;
  String? updatedAt;
  bool selected = false;
  bool isAttendant = false;
  bool isVisible = true;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_code'] = country_code;
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
