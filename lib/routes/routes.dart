import 'package:get/get.dart';
import 'package:library_user_app/features/auth/screens/sign_in_screen.dart';
import 'package:library_user_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:library_user_app/routes/routes_name.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RoutesName.dashboardScreen,
      page: () => const DashboardScreen(pageIndex: 0),
    ),

    GetPage(
      name: RoutesName.signInScreen,
      page: () => const SignInScreen(),
    ),

  ];
}
