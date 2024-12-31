import 'package:library_user_app/features/book/models/book_list_model.dart';

class CurrentBorrowBookModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<BorrowBook>? books;

  CurrentBorrowBookModel({this.totalSize, this.limit, this.offset, this.books});

  CurrentBorrowBookModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['books'] != null) {
      books = <BorrowBook>[];
      json['books'].forEach((v) {
        books!.add(BorrowBook.fromJson(v));
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

class BorrowBook {
  int? id;
  int? userId;
  int? bookId;
  int? lastPage;
  String? borrowedAt;
  String? returnedAt;
  String? createdAt;
  String? updatedAt;
  Books? book;

  BorrowBook({
    this.id,
    this.userId,
    this.bookId,
    this.lastPage,
    this.borrowedAt,
    this.returnedAt,
    this.createdAt,
    this.updatedAt,
    this.book,
  });

  BorrowBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bookId = json['book_id'];
    lastPage = json['last_page'];
    borrowedAt = json['borrowed_at'];
    returnedAt = json['returned_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    book = json['book'] != null ? Books.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['book_id'] = bookId;
    data['last_page'] = lastPage;
    data['borrowed_at'] = borrowedAt;
    data['returned_at'] = returnedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (book != null) {
      data['book'] = book!.toJson();
    }
    return data;
  }
}
