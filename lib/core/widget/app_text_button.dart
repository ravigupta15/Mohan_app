import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

// ignore: must_be_immutable
class AppTextButton extends StatelessWidget {
  final String title;
  VoidCallback?onTap;
  Color color;
   double height;
   double? width;
   bool isLoading;
   AppTextButton({required this.title,this.onTap, this.color = AppColors.greenColor,
   this.height =48.0,this.width ,this.isLoading=false
   });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
        child: AppText(title: title,
        color: AppColors.whiteColor,
        fontFamily: AppFontfamily.poppinsMedium,
        fontsize: 16
            ),
      ),
    );
  }
}