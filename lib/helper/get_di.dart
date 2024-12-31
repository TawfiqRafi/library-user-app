import 'package:library_user_app/api/api_client.dart';
import 'package:library_user_app/features/auth/controller/auth_controller.dart';
import 'package:library_user_app/features/auth/repo/auth_repo.dart';
import 'package:library_user_app/features/book/controller/book_controller.dart';
import 'package:library_user_app/features/book/repo/book_repo.dart';
import 'package:library_user_app/features/profile/controller/profile_controller.dart';
import 'package:library_user_app/features/profile/repo/profile_repo.dart';
import 'package:library_user_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  /// Repository
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => BookRepo(apiClient: Get.find()));

  /// Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));
  Get.lazyPut(() => BookController(bookRepo: Get.find()));

  /// Retrieving localized data
  Map<String, Map<String, String>> di = {};

  return di;
}
