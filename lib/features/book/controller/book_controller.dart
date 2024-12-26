import 'package:get/get.dart';
import 'package:library_user_app/api/api_checker.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/features/book/repo/book_repo.dart';
import 'package:library_user_app/features/dashboard/screens/dashboard_screen.dart';

class BookController extends GetxController implements GetxService {
  final BookRepo bookRepo;
  BookController({required this.bookRepo});

  Future<bool> borrowBook({required String barcode}) async {
    Response response = await bookRepo.borrowBook(barcode: barcode);
    if(response.statusCode == 200) {
      showCustomSnackBar('Book borrowed successfully', isError: false);
      Get.to(() => const DashboardScreen(pageIndex: 1));
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode == 200;
  }

}