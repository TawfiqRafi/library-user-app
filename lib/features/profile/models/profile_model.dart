class ProfileModel {
  int? id;
  String? name;
  String? email;
  int? isAdmin;
  String? createdAt;
  String? updatedAt;
  String? image;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    isAdmin = json['is_admin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['is_admin'] = isAdmin;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    return data;
  }
}
