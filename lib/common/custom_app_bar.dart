import 'package:flutter/material.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final Function? onBackPressed;
  final Widget? actionWidget;

  const CustomAppBar({super.key, required this.title, this.backButton = true, this.onBackPressed, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSixteen, fontWeight: FontWeight.w600)),
      centerTitle: true,
      leading: backButton ? IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: Theme.of(context).textTheme.bodyLarge!.color,
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
      ) : const SizedBox(),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Theme.of(context).disabledColor.withOpacity(0.5),
      elevation: 2,
      actions: actionWidget != null ? [actionWidget!] : [const SizedBox()],
    );
  }

  @override
  Size get preferredSize => const Size(1170, 50);
}