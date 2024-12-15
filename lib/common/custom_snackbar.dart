import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:library_user_app/utils/dimensions.dart';

  showCustomSnackBar(String? message, {bool isError = true, showToaster = true}) {
  if(message != null && message.isNotEmpty) {

    if(showToaster && !GetPlatform.isWeb){
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: Dimensions.fontSizeFourteen,
      );
    }
  }
}