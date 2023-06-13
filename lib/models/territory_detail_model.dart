
class TerritoryDetailModel {
  String? message;
  TerritoryDetailInfo? info;

  TerritoryDetailModel({this.message, this.info});

  TerritoryDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'] != null ? new TerritoryDetailInfo.fromJson(json['info']) : null;
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

class TerritoryDetailInfo {
  int? id;
  int? userId;
  String? name;
  String? image;
  Null? assignedTo;
  String? status;
  Null? assignedOn;
  String? createdAt;
  String? updatedAt;
  List<Addresses>? addresses;

  TerritoryDetailInfo(
      {this.id,
        this.userId,
        this.name,
        this.image,
        this.assignedTo,
        this.status,
        this.assignedOn,
        this.createdAt,
        this.updatedAt,
        this.addresses});

  TerritoryDetailInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    image = json['image'];
    assignedTo = json['assigned_to'];
    status = json['status'];
    assignedOn = json['assigned_on'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['assigned_to'] = this.assignedTo;
    data['status'] = this.status;
    data['assigned_on'] = this.assignedOn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int? id;
  int? territoryId;
  int? userId;
  int? houseNo;
  String? streetName;
  String? city;
  String? state;
  int? zipcode;
  DateTime? createdAt;
  String? updatedAt;

  Addresses(
      {this.id,
        this.territoryId,
        this.userId,
        this.houseNo,
        this.streetName,
        this.city,
        this.state,
        this.zipcode,
        this.createdAt,
        this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    territoryId = json['territory_id'];
    userId = json['user_id'];
    houseNo = json['house_no'];
    streetName = json['street_name'];
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['territory_id'] = this.territoryId;
    data['user_id'] = this.userId;
    data['house_no'] = this.houseNo;
    data['street_name'] = this.streetName;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipcode'] = this.zipcode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
