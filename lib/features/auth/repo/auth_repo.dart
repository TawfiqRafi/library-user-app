import 'package:get/get.dart';
import 'package:library_user_app/api/api_client.dart';
import 'package:library_user_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login({required String email, required String password}) async {
    return apiClient.postData(AppConstants.loginUri, {
      'email': email,
      'password': password,
    });
  }

  Future<Response> register({required String name, /*required String phone, */required String password, required String confirmPassword, required String email}) async {
    return apiClient.postData(AppConstants.registerUri, {
      'name' : name,
      // 'phone': phone,
      'password': password,
      'confirm_password': confirmPassword,
      'email': email,
    });
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<void> removeToken() async {
    await sharedPreferences.remove(AppConstants.token);
    apiClient.token = '';
  }

}