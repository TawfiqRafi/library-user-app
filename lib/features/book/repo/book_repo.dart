import 'package:get/get.dart';
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

}