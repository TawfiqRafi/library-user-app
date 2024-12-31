import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/common/custom_image.dart';
import 'package:library_user_app/features/auth/controller/auth_controller.dart';
import 'package:library_user_app/features/auth/screens/sign_in_screen.dart';
import 'package:library_user_app/features/book/screens/borrow_book_history_screen.dart';
import 'package:library_user_app/features/profile/controller/profile_controller.dart';
import 'package:library_user_app/features/profile/screens/edit_profile_screen.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile', backButton: false,
      ),
      body: GetBuilder<ProfileController>(builder: (profileController) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeTwenty),
            child: Column(children: [

              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColor.primary),
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomNetworkImage(image: profileController.profileModel?.content?.image ?? '',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeFifteen),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(Dimensions.radiusEight),
                ),
                padding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
                margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeFifteen),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  Text('Name: ${profileController.profileModel?.content?.firstName ?? ''}', style: robotoBold.copyWith(
                      fontSize: 16)),
                  const SizedBox(height: Dimensions.paddingSizeTen),

                  Text('Phone: ${profileController.profileModel?.content?.phone ?? ''}', style: robotoRegular.copyWith(
                      fontSize: 16)),
                  const SizedBox(height: Dimensions.paddingSizeTen),

                  Text('Address: ${profileController.profileModel?.content?.address ?? ''}', style: robotoRegular
                      .copyWith(fontSize: 16)),

                ]),
              ),

              InkWell(
                onTap: () {
                  Get.to(() => const EditProfileScreen());
                },
                child: ListTile(
                  tileColor: AppColor.grey.withOpacity(0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusEight),
                  ),
                  leading: const Icon(Icons.edit_note),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeFifteen),

              InkWell(
                onTap: () {
                  Get.to(() => const BorrowBookHistoryScreen());
                },
                child: ListTile(
                  tileColor: AppColor.grey.withOpacity(0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusEight),
                  ),
                  leading: const Icon(Icons.menu_book_rounded),
                  title: const Text('Borrow Books History'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeFifteen),

              InkWell(
                onTap: () {
                  profileController.logout();
                },
                child: ListTile(
                  tileColor: AppColor.grey.withOpacity(0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusEight),
                  ),
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),

            ]),
          ),
        );
      }));
  }
}
