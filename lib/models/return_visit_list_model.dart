class ReturnVisitListModel {
  String? message;
  Info? info;

  ReturnVisitListModel({this.message, this.info});

  ReturnVisitListModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<NOEModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Info(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Info.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <NOEModel>[];
      json['data'].forEach((v) {
        data!.add(new NOEModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class NOEModel {
  int? id;
  int? userId;
  String? name;
  String? nameImage;
  String? location;
  String? email;
  String? telephone;
  String? territoryName;
  int? territoryId;
  String? givenContentType;
  String? givenContentName;
  String? maritalStatus;
  int? boys;
  int? girls;
  String? notes;
  String? attachments;
  String? indicators;
  DateTime? dateTime;
  String? createdAt;
  String? updatedAt;
  ReturnVisit? returnVisit;
  List<ReturnVisit>? returnVisits;

  NOEModel(
      {this.id,
        this.userId,
        this.name,
        this.nameImage,
        this.location,
        this.email,
        this.telephone,
        this.territoryName,
        this.territoryId,
        this.givenContentType,
        this.returnVisits,
        this.givenContentName,
        this.maritalStatus,
        this.boys,
        this.girls,
        this.notes,
        this.attachments,
        this.indicators,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.returnVisit});

  NOEModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    nameImage = json['name_image'];
    territoryName = json['territory_name'];
    location = json['location'];
    email = json['email'];
    telephone = json['telephone'];
    territoryId = json['territory_id'];
    givenContentType = json['given_content_type'];
    givenContentName = json['given_content_name'];
    maritalStatus = json['marital_status'];
    boys = json['boys'];
    girls = json['girls'];
    notes = json['notes'];
    attachments = json['attachments'];
    indicators = json['indicators'];
    dateTime = DateTime.parse(json['date_time']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    returnVisit = json['return_visit'] != null
        ? new ReturnVisit.fromJson(json['return_visit'])
        : null;
    if (json['return_visits'] != null) {
      returnVisits = <ReturnVisit>[];
      json['return_visits'].forEach((v) {
        returnVisits!.add(new ReturnVisit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['name_image'] = this.nameImage;
    data['location'] = this.location;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['territory_id'] = this.territoryId;
    data['given_content_type'] = this.givenContentType;
    data['given_content_name'] = this.givenContentName;
    data['marital_status'] = this.maritalStatus;
    data['boys'] = this.boys;
    data['girls'] = this.girls;
    data['notes'] = this.notes;
    data['attachments'] = this.attachments;
    data['indicators'] = this.indicators;
    data['date_time'] = this.dateTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.returnVisit != null) {
      data['return_visit'] = this.returnVisit!.toJson();
    }
    return data;
  }
}

class ReturnVisit {
  int? id;
  int? userId;
  int? noeId;
  String? type;
  String? notificationSelf;
  bool? notificationOther;
  String? level;
  DateTime? returnDate;
  String? description;
  String? indicators;
  String? createdAt;
  String? updatedAt;

  ReturnVisit(
      {this.id,
        this.userId,
        this.noeId,
        this.type,
        this.notificationSelf,
        this.notificationOther,
        this.level,
        this.returnDate,
        this.description,
        this.indicators,
        this.createdAt,
        this.updatedAt});

  ReturnVisit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    noeId = json['noe_id'];
    type = json['type'];
    notificationSelf = json['notification_self'];
    notificationOther = json['notification_other'];
    level = json['level'];
    returnDate = DateTime.parse(json['return_date']);
    description = json['description'];
    indicators = json['indicators'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['noe_id'] = this.noeId;
    data['type'] = this.type;
    data['notification_self'] = this.notificationSelf;
    data['notification_other'] = this.notificationOther;
    data['level'] = this.level;
    data['return_date'] = this.returnDate;
    data['description'] = this.description;
    data['indicators'] = this.indicators;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
