class BannerModel {
  String? responseCode;
  String? message;
  List<Content>? content;

  BannerModel({this.responseCode, this.message, this.content});

  BannerModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  int? id;
  String? name;
  Data? data;
  int? isMultiple;
  String? templateName;
  int? view;
  String? createdAt;
  String? updatedAt;
  String? pageTitle;
  String? imageFullPath;

  Content({
    this.id,
    this.name,
    this.data,
    this.isMultiple,
    this.templateName,
    this.view,
    this.createdAt,
    this.updatedAt,
    this.pageTitle,
    this.imageFullPath,
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    isMultiple = json['is_multiple'];
    templateName = json['template_name'];
    view = json['view'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pageTitle = json['page_title'];
    imageFullPath = json['imageFullPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['is_multiple'] = isMultiple;
    data['template_name'] = templateName;
    data['view'] = view;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['page_title'] = pageTitle;
    data['imageFullPath'] = imageFullPath;
    return data;
  }
}

class Data {
  String? image;

  Data({this.image});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}
