class BookListModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Books>? books;

  BookListModel({this.totalSize, this.limit, this.offset, this.books});

  BookListModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  int? id;
  String? title;
  String? slug;
  String? author;
  String? image;
  String? barcode;
  String? createdAt;
  String? updatedAt;
  bool? available;

  Books({
    this.id,
    this.title,
    this.slug,
    this.author,
    this.image,
    this.barcode,
    this.createdAt,
    this.updatedAt,
    this.available,
  });

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    author = json['author'];
    image = json['image'];
    barcode = json['barcode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['author'] = author;
    data['image'] = image;
    data['barcode'] = barcode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['available'] = available;
    return data;
  }
}
