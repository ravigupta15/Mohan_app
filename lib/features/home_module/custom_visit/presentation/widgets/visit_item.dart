import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';


class VisitItem extends StatelessWidget {
  final String title;
  final String subTitle;
  const VisitItem({required this.title,required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(title: "$title : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: subTitle,fontsize: 8,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
      ],
    );
  }
}