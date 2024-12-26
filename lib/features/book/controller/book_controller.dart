import 'package:get/get.dart';
import 'package:library_user_app/api/api_checker.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/features/book/models/book_list_model.dart';
import 'package:library_user_app/features/book/repo/book_repo.dart';
import 'package:library_user_app/features/dashboard/screens/dashboard_screen.dart';

class BookController extends GetxController implements GetxService {
  final BookRepo bookRepo;
  BookController({required this.bookRepo});

  int? _pageSize;
  int? get pageSize => _pageSize;

  final List<String> _offsetList = [];
  int _offset = 1;
  int get offset => _offset;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  List<Books>? _booksList;
  List<Books>? get booksList => _booksList;

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

  Future<void> getBookList({required String offset, bool willUpdate = true}) async {
    if (offset == '1') {
      _offsetList.clear();
      _offset = 1;
      _booksList = null;
      if(willUpdate) {
        update();
      }
    }

    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      Response response = await bookRepo.getBookList(offset: offset);
      if (response.statusCode == 200) {
        if (offset == '1') {
          _booksList = [];
        }
        _booksList?.addAll(BookListModel.fromJson(response.body).books!);
        _pageSize = BookListModel.fromJson(response.body).totalSize;
        _isLoading = false;
        update();
      }
    } else {
      if(isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

}