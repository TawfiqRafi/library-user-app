import 'package:flutter/material.dart';
import 'package:library_user_app/utils/app_color.dart';

class BottomNavItemWidget extends StatelessWidget {
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final Function? onTap;
  final bool isSelected;
  const BottomNavItemWidget({super.key, this.onTap, this.isSelected = false, required this.selectedIcon, required this.unselectedIcon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isSelected ? selectedIcon : unselectedIcon, color: isSelected ? AppColor.primary : AppColor.grey),
            const SizedBox(height: 5),

            isSelected ? Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary,
              ),
            ) : const SizedBox(),

          ],
        ),
        onPressed: onTap as void Function()?,
      ),
    );
  }
}