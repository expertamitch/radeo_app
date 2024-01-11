class PlansModel {
  String? message;
  List<PlanDetail>? info;

  PlansModel({this.message, this.info});

  PlansModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['info'] != null) {
      info = <PlanDetail>[];
      json['info'].forEach((v) {
        info!.add(new PlanDetail.fromJson(v));
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

class PlanDetail {
  int? id;
  String? name;
  double? price;
  List<String>? details;
  List<String>? planPoints;
  String? createdAt;
  String? updatedAt;

  PlanDetail(
      {this.id,
        this.name,
        this.price,
        this.details,
        this.planPoints,
        this.createdAt,
        this.updatedAt});

  PlanDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
    details = json['details'].cast<String>();
    planPoints = json['plan_points'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['details'] = this.details;
    data['plan_points'] = this.planPoints;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

