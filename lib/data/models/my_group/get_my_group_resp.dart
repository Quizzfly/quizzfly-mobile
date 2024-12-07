class GetMyGroupsResp {
  String? status;
  List<MyGroupsData>? data;

  GetMyGroupsResp({
    this.status,
    this.data,
  });

  GetMyGroupsResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MyGroupsData>[];
      json['data'].forEach((v) {
        data!.add(MyGroupsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyGroupsData {
  String? role;
  MyGroups? group;

  MyGroupsData({
    this.role,
    this.group,
  });

  MyGroupsData.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    group = json['group'] != null ? MyGroups.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (role != null) data['role'] = role;
    if (group != null) data['group'] = group!.toJson();
    return data;
  }
}

class MyGroups {
  String? id;
  String? name;
  String? description;
  String? background;
  String? createdAt;
  String? updatedAt;

  MyGroups({
    this.id,
    this.name,
    this.description,
    this.background,
    this.createdAt,
    this.updatedAt,
  });

  MyGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    background = json['background'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (background != null) data['background'] = background;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    return data;
  }
}
