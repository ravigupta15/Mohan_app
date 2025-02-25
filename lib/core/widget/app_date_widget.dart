
import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

// ignore: must_be_immutable
class AppDateWidget extends StatelessWidget {
  final String title;
  final String hintText;
  void Function()? onTap;
   AppDateWidget({this.title = '', this.onTap,this.hintText="DD-MM-YYYY"});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical:5),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.edColor)
        ),
        child: AppText(title:(title).isEmpty? hintText : title,fontsize: 12,color:
        title.isEmpty?
         AppColors.lightTextColor : AppColors.black ,fontFamily: AppFontfamily.poppinsMedium,),
      ),
    );
  }
}

