import 'package:get/get.dart';
import 'package:library_user_app/api/api_client.dart';
import 'package:library_user_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

/*  Future<Response> login({required String phone, required String password}) async {
    return apiClient.postData(AppConstants.loginUri, {
      'phone': phone,
      'password': password,
      'user_type': 'customer',
    });
  }

  Future<Response> register({required String name, required String phone, required String password, required String confirmPassword, required String address}) async {
    return apiClient.postData(AppConstants.registerUri, {
      'name' : name,
      'phone': phone,
      'password': password,
      'confirm-password': confirmPassword,
      'address': address,
      'user_type': 'customer',
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
  }*/

}