import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

AppBar customAppBar({required String title, List<Widget>? actions, bool isBack=true}){
  return AppBar(
    scrolledUnderElevation: 0.0,
    backgroundColor: AppColors.whiteColor,
    leading:isBack? InkWell(
      onTap: (){
        Navigator.pop(navigatorKey.currentContext!);
      },
      child: Icon(Icons.arrow_back_ios),
    ):SizedBox.shrink(),
    title: AppText(title: title,
    fontsize: 18,fontFamily: AppFontfamily.poppinsSemibold,
    ),
    centerTitle: true,
    actions: actions,
  );
}