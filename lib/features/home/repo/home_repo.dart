import 'package:get/get.dart';
import 'package:library_user_app/api/api_client.dart';
import 'package:library_user_app/utils/app_constants.dart';

class HomeRepo{
  final ApiClient apiClient;
  HomeRepo({required this.apiClient});

/*  Future<Response> getBannerList() async {
    return apiClient.getData(AppConstants.bannerListUri);
  }

  Future<Response> getCategoryList() async {
    return apiClient.getData(AppConstants.categoryListUri);
  }*/

}