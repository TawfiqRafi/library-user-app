import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:library_user_app/features/auth/controller/auth_controller.dart';
import 'package:library_user_app/features/book/screens/my_books_screen.dart';
import 'package:library_user_app/features/dashboard/widget/bottom_nav_item_widget.dart';
import 'package:library_user_app/features/qr/screens/qr_screen.dart';
import 'package:library_user_app/features/home/screens/home_screen.dart';
import 'package:library_user_app/features/book/screens/current_book_screen.dart';
import 'package:library_user_app/features/profile/controller/profile_controller.dart';
import 'package:library_user_app/features/profile/screens/profile_screen.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({super.key, required this.pageIndex});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {

  PageController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  bool _canExit = false;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      const HomeScreen(),
      const CurrentBookScreen(),
      const QrScreen(),
      const MyBooksScreen(),
      const ProfileScreen(),
    ];

    bool isLogin = Get.find<AuthController>().isLoggedIn();
    if(isLogin){
      Get.find<ProfileController>().getProfile();
    }

  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(_pageIndex != 0) {
          _setPage(0);
        }else {
          if(_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Press back again to exit', style: TextStyle(color: Colors.white)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            margin: EdgeInsets.all(Dimensions.marginSizeTen),
          ));
          _canExit = true;

          Timer(const Duration(seconds: 2), () {
            _canExit = false;
          });
        }
      },
      child: Scaffold(

        floatingActionButton: Material(
          elevation: 4,
          shape: const CircleBorder(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 56.0,
                height: 56.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColor.secondary,
                      AppColor.primary
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),


              FloatingActionButton(
                onPressed: () => _setPage(2),
                elevation: 0,
                shape: const CircleBorder(),
                backgroundColor: Colors.transparent,
                child: const Icon(Icons.qr_code_2_rounded, color: Colors.white),
              ),

            ],
          ),
        ),

        floatingActionButtonLocation: !GetPlatform.isMobile ? null : FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: !GetPlatform.isMobile ? const SizedBox() : BottomAppBar(
          elevation: 5,
          notchMargin: 5,
          shadowColor: Colors.grey[300],
          shape: const CircularNotchedRectangle(),
          color: AppColor.white,
          surfaceTintColor: Colors.transparent,

          child: Row(children: [
            BottomNavItemWidget(
              selectedIcon: Icons.home,
              unselectedIcon: Icons.home,
              isSelected: _pageIndex == 0,
              onTap: () => _setPage(0),
            ),

            BottomNavItemWidget(
              selectedIcon: Icons.menu_book_rounded,
              unselectedIcon: Icons.menu_book_rounded,
              isSelected: _pageIndex == 1,
              onTap: () => _setPage(1),
            ),

            const Expanded(child: SizedBox()),

            BottomNavItemWidget(
              selectedIcon: Icons.my_library_books,
              unselectedIcon: Icons.my_library_books,
              isSelected: _pageIndex == 3,
              onTap: () => _setPage(3),
            ),

            BottomNavItemWidget(
              selectedIcon: Icons.person,
              unselectedIcon: Icons.person,
              isSelected: _pageIndex == 4,
              onTap: () => _setPage(4),
            ),
          ]),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}