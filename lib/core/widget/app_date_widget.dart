
import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class AppDateWidget extends StatelessWidget {
  final String? title;
  void Function()? onTap;
   AppDateWidget({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7,vertical:5),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.edColor)
        ),
        child: AppText(title:title?? "DD-MM-YYYY",fontsize: 12,color: AppColors.lightTextColor,fontFamily: AppFontfamily.poppinsMedium,),
      ),
    );
  }
}

