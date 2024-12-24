import 'package:get/get.dart';
import 'package:library_user_app/api/api_checker.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/features/auth/repo/auth_repo.dart';
import 'package:library_user_app/features/dashboard/screens/dashboard_screen.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  String? _selectedUserType;
  String? get selectedUserType => _selectedUserType;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login({required String email, required String password}) async {
    _isLoading = true;
    update();

    final response = await authRepo.login(email: email, password: password);
    if(response.statusCode == 200) {
      final token = response.body['access_token'];
      await authRepo.saveUserToken(token);
      Get.offAll(() => const DashboardScreen(pageIndex: 0));
    }else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<void> register({required String name, /*required String phone, */required String password, required String confirmPassword, required String email}) async {
    _isLoading = true;
    update();

    final response = await authRepo.register(name: name, password: password, confirmPassword: confirmPassword, email: email);
    if(response.statusCode == 201) {
      final token = response.body['access_token'];
      await authRepo.saveUserToken(token);
      showCustomSnackBar('You have successfully registered', isError: false);
      Get.offAll(() => const DashboardScreen(pageIndex: 0));
    }else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
  }

  Future<void> removeToken() async {
    await authRepo.removeToken();
  }

}