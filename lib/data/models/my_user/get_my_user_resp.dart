class GetMyUserResp {
  String? status;
  Data? data;
  GetMyUserResp({this.status, this.data});
  GetMyUserResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? email;
  String? role;
  String? createdAt;
  String? updatedAt;
  UserInfo? userInfo;
  Data(
      {this.id,
      this.email,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.userInfo});
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (role != null) {
      data['role'] = role;
    }
    if (createdAt != null) {
      data['created_at'] = createdAt;
    }
    if (updatedAt != null) {
      data['updated_at'] = updatedAt;
    }
    if (userInfo != null) {
      data['user_info'] = userInfo?.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? id;
  String? username;
  dynamic name;
  dynamic avatar;
  String? createdAt;
  String? updatedAt;
  UserInfo(
      {this.id,
      this.username,
      this.name,
      this.avatar,
      this.createdAt,
      this.updatedAt});
  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (username != null) {
      data['username'] = username;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (avatar != null) {
      data['avatar'] = avatar;
    }
    if (createdAt != null) {
      data['created_at'] = createdAt;
    }
    if (updatedAt != null) {
      data['updated_at'] = updatedAt;
    }
    return data;
  }
}
