class DNCListModel {
  String? message;
  List<DNCModel>? info;

  DNCListModel({this.message, this.info});

  DNCListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['info'] != null) {
      info = <DNCModel>[];
      json['info'].forEach((v) {
        info!.add(new DNCModel.fromJson(v));
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

class DNCModel {
  int? id;
  int? userId;
  String? name;
  String? image;
  int? assignedTo;
  String? status;
   String? createdAt;
  String? updatedAt;
  List<DoNotCalls>? doNotCalls;

  DNCModel(
      {this.id,
        this.userId,
        this.name,
        this.image,
        this.assignedTo,
        this.status,
         this.createdAt,
        this.updatedAt,
        this.doNotCalls});

  DNCModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    image = json['image'];
    assignedTo = json['assigned_to'];
    status = json['status'];
     createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['do_not_calls'] != null) {
      doNotCalls = <DoNotCalls>[];
      json['do_not_calls'].forEach((v) {
        doNotCalls!.add(new DoNotCalls.fromJson(v));
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
     data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.doNotCalls != null) {
      data['do_not_calls'] = this.doNotCalls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoNotCalls {
  int? id;
  int? userId;
  int? territoryId;
  String? address;
  String? reason;
  String? status;
  DateTime? createdAt;
  String? updatedAt;

  DoNotCalls(
      {this.id,
        this.userId,
        this.territoryId,
        this.address,
        this.reason,
        this.status,
        this.createdAt,
        this.updatedAt});

  factory DoNotCalls.clone(DoNotCalls source) {
    return DoNotCalls(
      id: source.id,
      userId: source.userId,
      territoryId: source.territoryId,
      address: source.address,
      reason: source.reason,
      status: source.status,
      createdAt: source.createdAt,

      updatedAt: source.updatedAt,




    );
  }

  DoNotCalls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    territoryId = json['territory_id'];
    address = json['address'];
    reason = json['reason'];
    status = json['status'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['territory_id'] = this.territoryId;
    data['address'] = this.address;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
