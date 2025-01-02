import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_user_app/api/api_client.dart';
import 'package:library_user_app/utils/app_constants.dart';

class BookRepo {
  final ApiClient apiClient;
  BookRepo({required this.apiClient});

  Future<Response> borrowBook({required String barcode}) async {
    return await apiClient.postData(AppConstants.borrowBook, {
      'barcode': barcode
    });
  }

  Future<Response> getBookList({required String offset}) async {
    return await apiClient.getData('${AppConstants.bookList}?limit=10&offset=$offset');
  }

  Future<Response> getCurrentBorrowedBooks({required String offset}) async {
    return await apiClient.getData('${AppConstants.currentBorrowedBooks}?limit=10&offset=$offset');
  }

  Future<Response> getBorrowBookHistory({required String offset}) async {
    return await apiClient.getData('${AppConstants.borrowBookHistory}?limit=10&offset=$offset');
  }

  Future<Response> returnBook({required String barcode}) async {
    return await apiClient.postData(AppConstants.returnBook, {
      'barcode': barcode
    });
  }

  Future<Response> updateLastPage({required String barcode, required int lastPage}) async {
    return await apiClient.postData(AppConstants.updateLastPage, {
      'barcode': barcode,
      'last_page': lastPage
    });
  }

  Future<Response> addBook(Map<String, String> body, XFile? image) async {
    return await apiClient.postMultipartData(AppConstants.addBook, body, [MultipartBody('image', image)]);
  }

}