import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class LabelTextTextfield extends StatelessWidget {
  final String title;
  final bool isRequiredStar;
  final String fontFamily;
  final Color textColor;
  const LabelTextTextfield({required this.title, required this.isRequiredStar,
  this.fontFamily = AppFontfamily.poppinsRegular,this.textColor =AppColors.lightTextColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         AppText(title: title,color: textColor,fontFamily: fontFamily,),
          isRequiredStar?
          AppText(title: " *",color: AppColors.redColor,):SizedBox.fromSize(),
      ],
    );
  }
}
class LabelTextTextfieldDocument extends StatelessWidget {
  final String title;
  final bool isRequiredStar;
  const LabelTextTextfieldDocument({required this.title, required this.isRequiredStar});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(title: title,fontFamily: AppFontfamily.poppinsBold),
        isRequiredStar?
        AppText(title: " *",color: AppColors.redColor):SizedBox.fromSize(),
      ],
    );
  }
}