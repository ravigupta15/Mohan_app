import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class DocumantWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  Function()?onTap;

   DocumantWidget({super.key, required this.image, required this.title, required this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 150,
          height: 85,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: AppColors.edColor), 
            borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              color: AppColors.black.withValues(alpha: .1),
              blurRadius: 1
            )
          ] 
          ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Camera Image
              SvgPicture.asset(
                image,
                width: 28,
                color: AppColors.greenColor,
                height: 28,
              ),
              SizedBox(height: 4), 
              
              AppText(
                title: title,
                fontsize: 12,
                fontFamily: AppFontfamily.poppinsSemibold,
              ),
              // SizedBox(height: 2), 
              // "Take a Photo" button
              AppText(
                title: subtitle,
                fontsize: 10,
                color: AppColors.mossGreyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
