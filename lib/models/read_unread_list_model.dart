class ReadUnreadListModel {
  String? message;
  Info? info;

  ReadUnreadListModel({this.message, this.info});

  ReadUnreadListModel.fromJson(Map<String, dynamic> json) {
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
  List<ReadUnreadMessageModel>? data;
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
      data = <ReadUnreadMessageModel>[];
      json['data'].forEach((v) {
        data!.add(new ReadUnreadMessageModel.fromJson(v));
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

class ReadUnreadMessageModel {
  int? id;
  int? userId;
  String? messageType;
  String? messageContent;
  List<String>? attachments;
  String? location;
  String? responseType;
  int? forUser;
  String? createdAt;
  DateTime? updatedAt;
  int? isRead;

  ReadUnreadMessageModel({
    this.location,
    this.id,
    this.userId,
    this.messageType,
    this.messageContent,
    this.attachments,
    this.responseType,
    this.forUser,
    this.createdAt,
    this.updatedAt,
    this.isRead,
  });

  ReadUnreadMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    userId = json['user_id'];
    messageType = json['message_type'];
    messageContent = json['message_content'];
    attachments =
        json['attachments'] == null ? [] : json['attachments'].cast<String>();
    responseType = json['response_type'];

    forUser = json['for_user'];
    createdAt = json['created_at'];
    updatedAt = DateTime.parse(json['updated_at']);
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['message_type'] = this.messageType;
    data['message_content'] = this.messageContent;
    data['attachments'] = this.attachments;
    data['response_type'] = this.responseType;
    data['for_user'] = this.forUser;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_read'] = this.isRead;
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
