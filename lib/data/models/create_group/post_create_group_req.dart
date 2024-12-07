class PostCreateGroupReq {
  String? name;
  String? description;
  String? background;

  PostCreateGroupReq({
    this.name, 
    this.description, 
    this.background
  });

  PostCreateGroupReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    background = json['background'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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