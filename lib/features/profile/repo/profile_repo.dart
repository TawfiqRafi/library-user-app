import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_user_app/api/api_client.dart';
import 'package:library_user_app/utils/app_constants.dart';

class ProfileRepo {
  final ApiClient apiClient;
  ProfileRepo({required this.apiClient});

/*  Future<Response> getProfile() async {
    return await apiClient.getData(AppConstants.profileUri);
  }

  Future<Response> logout() async {
    return await apiClient.postData(AppConstants.logoutUri, {});
  }

  Future<Response> updateProfile(Map<String, String> body, XFile? image) async {
    return await apiClient.postMultipartData(AppConstants.updateProfileUri, body, [MultipartBody('image', image)]);
  }*/

}