class TerritoryListModel {
  String? message;
  List<TerritoryInfo>? info;

  TerritoryListModel({this.message, this.info});

  TerritoryListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['info'] != null) {
      info = <TerritoryInfo>[];
      json['info'].forEach((v) {
        info!.add(new TerritoryInfo.fromJson(v));
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

class TerritoryInfo {
  int? id;
  int? userId;
  String? name;
  String? image;
  Null? assignedTo;
  String? status;
  Null? assignedOn;
  String? createdAt;
  String? updatedAt;

  TerritoryInfo(
      {this.id,
        this.userId,
        this.name,
        this.image,
        this.assignedTo,
        this.status,
        this.assignedOn,
        this.createdAt,
        this.updatedAt});

  TerritoryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    image = json['image'];
    assignedTo = json['assigned_to'];
    status = json['status'];
    assignedOn = json['assigned_on'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
