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
  bool isEditing = false;
  int? id;
  int? userId;
  bool selected = false;
  String? groupName;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Users>? users;
  int? groupUsersCount;

  factory GroupModel.clone(GroupModel source) {
    return GroupModel(
      isEditing: source.isEditing,
      id: source.id,
      userId: source.userId,
      groupName: source.groupName,
      createdAt: source.createdAt,
      updatedAt: source.updatedAt,
      selected: source.selected,
      users: source.users!.map((e) => Users.clone(e)).toList(),
      groupUsersCount: source.groupUsersCount,
    );
  }

  GroupModel(
      {this.id,
      this.userId,
      this.selected = false,
      this.groupName,
      this.isEditing = false,
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
  String? contactType;
  List<UserData>? users;

  factory Users.clone(Users source) {
    return Users(
      contactType: source.contactType,
      users: source.users!.map((e) => UserData.clone(e)).toList(),
    );
  }

  Users({this.contactType, this.users});

  Users.fromJson(Map<String, dynamic> json) {
    contactType = json['contact_type'];
    if (json['users'] != null) {
      users = <UserData>[];
      json['users'].forEach((v) {
        users!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_type'] = this.contactType;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  int? id;
  int? groupId;
  int? userId;
  bool isAttendant = false;
  bool isLocalAttendant = false;
  bool isVisible = true;

  bool selected = false;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? contact_type;
  int? from_group_id;
  String? lastName;
  String? email;
  String? mobile;
  String? status;

  UserData({
    this.id,
    this.contact_type,
    this.name,
    this.status,
    this.groupId,
    this.userId,
    this.from_group_id,
    this.isAttendant = false,
    this.isLocalAttendant = false,
    this.selected = false,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
  });

  factory UserData.clone(UserData source) {
    return UserData(
      status: source.status,
      name: source.name,
      from_group_id: source.from_group_id,
      contact_type: source.contact_type,
      id: source.id,
      selected: source.selected,
      groupId: source.groupId,
      userId: source.userId,
      isAttendant: source.isAttendant,
      firstName: source.firstName,
      lastName: source.lastName,
      email: source.email,
      mobile: source.mobile,
    );
  }

  UserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    id = json['id'];
    contact_type = json['contact_type'];
    from_group_id = json['from_group_id'];
    groupId = json['group_id'];
    userId = json['user_id'];
    isAttendant = json['is_attendent'] ?? false;
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
    data['is_attendent'] = this.isAttendant;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;

    return data;
  }
}
