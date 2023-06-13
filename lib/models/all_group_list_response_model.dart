class AllGroupListResponseModel {
  String? message;
  List<GroupModel>? info;

  AllGroupListResponseModel({this.message, this.info});

  AllGroupListResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['info'] != null) {
      info = <GroupModel>[];
      json['info'].forEach((v) {
        info!.add(new GroupModel.fromJson(v));
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

class GroupModel {
  int? id;
  int? userId;
  bool selected=false;
  String? groupName;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Users>? users;
  int? groupUsersCount;

  GroupModel(
      {this.id,
        this.userId,
        this.groupName,
        this.createdAt,
        this.updatedAt,
        this.users,
        this.groupUsersCount});

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    groupName = json['group_name'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    groupUsersCount = json['group_users_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['group_name'] = this.groupName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['group_users_count'] = this.groupUsersCount;
    return data;
  }
}

class Users {
  int? id;
  int? groupId;
  int? userId;
  bool? isAttendent;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;


  Users(
      {this.id,
        this.groupId,
        this.userId,
        this.isAttendent,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
         });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    userId = json['user_id'];
    isAttendent = json['is_attendent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['user_id'] = this.userId;
    data['is_attendent'] = this.isAttendent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;

    return data;
  }
}
