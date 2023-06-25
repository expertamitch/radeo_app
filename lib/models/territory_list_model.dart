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

 }


class TerritoryInfo {
  int? id;
  int? userId;
  String? name;
  String? image;
  int? assignedTo;
  String? status;
  String? assignedOn;
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

 }





