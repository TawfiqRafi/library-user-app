import 'package:get/get.dart';
import 'package:library_user_app/features/book/repo/book_repo.dart';

class BookController extends GetxController implements GetxService {
  final BookRepo bookRepo;
  BookController({required this.bookRepo});
}