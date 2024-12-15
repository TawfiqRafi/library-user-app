import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/features/auth/controller/auth_controller.dart';
import 'package:library_user_app/features/auth/screens/sign_in_screen.dart';
import 'package:library_user_app/features/home/controller/home_controller.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Theme.of(context).disabledColor.withOpacity(0.5),
        elevation: 2,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Welcome to Library', style: robotoBold.copyWith(fontSize: 18)),
      ),
      /*body: GetBuilder<HomeController>(builder: (homeController) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeTwenty),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              homeController.bannerList != null ? homeController.bannerList!.isNotEmpty ? Column(children: [
                CarouselSlider.builder(
                  itemCount: homeController.bannerList?.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radiusTwelve),
                      child: CustomNetworkImage(
                        image: homeController.bannerList?[index].imageFullPath ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      homeController.setCurrentIndex(index);
                    },
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeTen),

                Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(
                homeController.bannerList!.length, (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: homeController.currentIndex == index ? 15 : 10,
                  decoration: BoxDecoration(
                    color: homeController.currentIndex  == index ? AppColor.primary : AppColor.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )),
              ]) : const SizedBox() : Shimmer.fromColors(
                baseColor: AppColor.shimmerColor,
                highlightColor: AppColor.shimmerColor.withOpacity(0.1),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radiusTwelve),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeTwenty),

              Text('Service Categories', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeTwenty)),
              const SizedBox(height: Dimensions.paddingSizeTen),

              homeController.categoryList != null ? homeController.categoryList!.isNotEmpty ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeController.categoryList!.length,
                itemBuilder: (context, index) {
                  final category = homeController.categoryList![index];
                  return InkWell(
                    onTap: () {

                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: CustomNetworkImage(
                                image: category.image ?? '',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category.name ?? '',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSixteen),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ) : const Center(child: Text("No Categories Available")) : Shimmer.fromColors(
                baseColor: AppColor.shimmerColor,
                highlightColor: AppColor.shimmerColor.withOpacity(0.1),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                ),
              ),

            ]),
          ),
        );
      }),*/
    );
  }
}
