class PostCreateGroupResp {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? name;
  String? description;
  String? background;

  PostCreateGroupResp({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.description,
    this.background
  });

  PostCreateGroupResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    description = json['description'];
    background = json['background'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (createdAt != null) {
      data['created_at'] = createdAt;
    }
    if (updatedAt != null) {
      data['updated_at'] = updatedAt;
    }
    if (deletedAt != null) {
      data['deleted_at'] = deletedAt;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (description != null) {
      data['description'] = description;
    }
    if (background != null) {
      data['background'] = background;
    }
    return data;
  }
}