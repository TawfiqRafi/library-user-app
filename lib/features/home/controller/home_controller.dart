import 'package:get/get.dart';
import 'package:library_user_app/api/api_checker.dart';
import 'package:library_user_app/features/home/models/banner_model.dart';
import 'package:library_user_app/features/home/models/category_model.dart';
import 'package:library_user_app/features/home/repo/home_repo.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});

  List<Content>? _bannerList;
  List<Content>? get bannerList => _bannerList;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  List<Category>? _categoryList;
  List<Category>? get categoryList => _categoryList;

/*  Future<void> getBannerList() async {
    final response = await homeRepo.getBannerList();
    if(response.statusCode == 200) {
      _bannerList = [];
      _bannerList?.addAll(response.body['content'].map<Content>((data) => Content.fromJson(data)).toList());
    }else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    update();
  }

  Future<void> getCategoryList() async {
    final response = await homeRepo.getCategoryList();
    if(response.statusCode == 200) {
      _categoryList = [];
      _categoryList?.addAll(response.body['content'].map<Category>((data) => Category.fromJson(data)).toList());
    }else {
      ApiChecker.checkApi(response);
    }
    update();
  }*/

}