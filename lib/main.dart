import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:library_user_app/features/auth/controller/auth_controller.dart';
import 'package:library_user_app/routes/routes.dart';
import 'package:library_user_app/routes/routes_name.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/app_constants.dart';
import 'helper/get_di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return GetBuilder<AuthController>(
      builder: (authController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColor.white,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
            useMaterial3: true,
          ),
          initialRoute: authController.isLoggedIn() ? RoutesName.getDashboardScreen() : RoutesName.getSignInScreen(),
          getPages: AppRoutes.appRoutes(),
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 500),
        );
      }
    );
  }
}