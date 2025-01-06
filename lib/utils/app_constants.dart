class AppConstants  {
  static const String appName = 'Library User App';
  static const double appVersion = 1.0;
  static const String fontFamily = 'Roboto';

  static const String baseUrl = 'http://192.168.50.229/library-admin/public';

  static const String loginUri = '/api/user/login';
  static const String registerUri = '/api/user/register';

  static const String profileUri = '/api/user/profile';
  static const String updateProfileUri = '/api/user/update';

  static const String borrowBook = '/api/borrow-book';
  static const String bookList = '/api/books';
  static const String currentBorrowedBooks = '/api/current-borrowed-books';
  static const String borrowBookHistory = '/api/borrowing-history';
  static const String returnBook = '/api/return-book';
  static const String updateLastPage = '/api/update-last-page';
  static const String addBook = '/api/books/store';
  static const String myBooks = '/api/books/list';
  static const String editBook = '/api/books/edit';

  static const String token = 'library_user_app_token';
}