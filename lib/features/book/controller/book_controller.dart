import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_user_app/api/api_checker.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/features/book/models/book_list_model.dart';
import 'package:library_user_app/features/book/models/current_borrow_book_model.dart';
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

  bool _isLastPageLoading = false;
  bool get isLastPageLoading => _isLastPageLoading;
  
  List<Books>? _booksList;
  List<Books>? get booksList => _booksList;

  List<BorrowBook>? _currentBorrowedBooks;
  List<BorrowBook>? get currentBorrowedBooks => _currentBorrowedBooks;

  List<BorrowBook>? _borrowBookHistory;
  List<BorrowBook>? get borrowBookHistory => _borrowBookHistory;

  XFile? _pickedBookImage;
  XFile? get pickedBookImage => _pickedBookImage;

  Future<bool> borrowBook({required String barcode}) async {
    Response response = await bookRepo.borrowBook(barcode: barcode);
    if(response.statusCode == 200) {
      showCustomSnackBar('Book borrowed successfully', isError: false);
      await getBorrowBookHistory(offset: '1');
      Get.to(() => const DashboardScreen(pageIndex: 1));
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode == 200;
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
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

  Future<void> getCurrentBorrowedBooks({required String offset, bool willUpdate = true}) async {
    if (offset == '1') {
      _offsetList.clear();
      _offset = 1;
      _currentBorrowedBooks = null;
      if(willUpdate) {
        update();
      }
    }

    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      Response response = await bookRepo.getCurrentBorrowedBooks(offset: offset);
      if (response.statusCode == 200) {
        if (offset == '1') {
          _currentBorrowedBooks = [];
        }
        _currentBorrowedBooks?.addAll(CurrentBorrowBookModel.fromJson(response.body).books!);
        _pageSize = CurrentBorrowBookModel.fromJson(response.body).totalSize;
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

  Future<void> getBorrowBookHistory({required String offset, bool willUpdate = true}) async {
    if (offset == '1') {
      _offsetList.clear();
      _offset = 1;
      _borrowBookHistory = null;
      if(willUpdate) {
        update();
      }
    }

    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      Response response = await bookRepo.getBorrowBookHistory(offset: offset);
      if (response.statusCode == 200) {
        if (offset == '1') {
          _borrowBookHistory = [];
        }
        _borrowBookHistory?.addAll(CurrentBorrowBookModel.fromJson(response.body).books!);
        _pageSize = CurrentBorrowBookModel.fromJson(response.body).totalSize;
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

  Future<bool> returnBook({required String barcode}) async {
    _isLoading = true;
    update();

    Response response = await bookRepo.returnBook(barcode: barcode);
    if(response.statusCode == 200) {
      showCustomSnackBar('Book returned successfully', isError: false);
      await getCurrentBorrowedBooks(offset: '1');
      await getBorrowBookHistory(offset: '1');
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
    return response.statusCode == 200;
  }

  Future<bool> updateLastPage({required String barcode, required int lastPage}) async {
    _isLastPageLoading = true;
    update();

    Response response = await bookRepo.updateLastPage(barcode: barcode, lastPage: lastPage);
    if(response.statusCode == 200) {
      showCustomSnackBar('Last page updated successfully', isError: false);
      await getCurrentBorrowedBooks(offset: '1');
      await getBorrowBookHistory(offset: '1');
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLastPageLoading = false;
    update();
    return response.statusCode == 200;
  }

  void pickImage() async {
    _pickedBookImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  void initData() {
    _pickedBookImage = null;
  }

  Future<void> addBook({required String? title, String? author}) async {
    _isLoading = true;
    update();

    Map<String, String> body = {
      'title' : title ?? '',
      'author': author ?? '',
    };

    final response = await bookRepo.addBook(body, _pickedBookImage);
    if(response.statusCode == 200) {
      getBookList(offset: '1');
      Get.back();
      showCustomSnackBar('Book Added Successfully', isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

}