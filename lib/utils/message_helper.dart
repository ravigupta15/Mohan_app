import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

class MessageHelper{
   static void showSuccessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static void showErrorSnackBar(BuildContext context, String message,{required,backgroundColor =AppColors.redColor,}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message,style: TextStyle(
        color:backgroundColor==AppColors.redColor? AppColors.whiteColor:AppColors.black
      ),),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } 

  static void showInternetSnackBar() {
    const snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text("No internet connection",style: TextStyle(
        color: AppColors.whiteColor
      ),),
      backgroundColor: AppColors.redColor,
    );
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  } 

 static showToast(String title,{ToastGravity gravity = ToastGravity.SNACKBAR}){
   Fluttertoast.showToast(
       msg: title,
       toastLength: Toast.LENGTH_SHORT,
       gravity: gravity,
       textColor: Colors.white,
       backgroundColor: AppColors.black
   );
 }


}