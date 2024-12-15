import 'package:flutter/material.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final Color? color;
  final Color? textColor;
  final Function()? onTap;
  final bool isBorderEnable;
  final bool isLoading;
  const CustomButton({super.key, this.height = 45, this.width, required this.text, this.color = AppColor.primary,
    this.textColor, this.onTap, this.isBorderEnable = true, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: isLoading ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 15, width: 15,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeTen),

            Text('Loading', style: robotoMedium.copyWith(color: Colors.white)),
          ]) : Text(text, style: robotoMedium.copyWith(color: textColor ?? AppColor.white)),
        ),
      ),
    );
  }
}
