import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_user_app/api/api_checker.dart';
import 'package:library_user_app/common/custom_snackbar.dart';
import 'package:library_user_app/features/auth/controller/auth_controller.dart';
import 'package:library_user_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:library_user_app/features/profile/models/profile_model.dart';
import 'package:library_user_app/features/profile/repo/profile_repo.dart';

class ProfileController extends GetxController implements GetxService{
  final ProfileRepo profileRepo;
  ProfileController({required this.profileRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;

  XFile? _pickedFile;
  XFile? get pickedFile => _pickedFile;

  /*Future<void> getProfile() async {
    final response = await profileRepo.getProfile();
    if(response.statusCode == 200) {
      _profileModel = ProfileModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> logout() async {
    _isLoading = true;
    update();
    final response = await profileRepo.logout();
    if(response.statusCode == 200) {
      Get.find<AuthController>().removeToken();
      showCustomSnackBar('Successfully Logged out', isError: false);
      Get.offAll(() => const DashboardScreen(pageIndex: 0));
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  void initData() {
    _pickedFile = null;
  }

  Future<void> updateUserInfo({required String name, required String phone, required String password, required String confirmPassword, required String address}) async {
    _isLoading = true;
    update();

    Map<String, String> body = {
      'name' : name,
      'phone': phone,
      'password': password,
      'confirm-password': confirmPassword,
      'address': address,
      'user_type': 'customer',
    };

    final response = await profileRepo.updateProfile(body, _pickedFile);
    if(response.statusCode == 200) {
      getProfile();
      Get.back();
      showCustomSnackBar('Profile Update Successfully', isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }*/

}