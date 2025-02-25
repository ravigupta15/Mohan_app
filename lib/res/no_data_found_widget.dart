import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class NoDataFound extends StatelessWidget {
  final String title;
  const NoDataFound({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
  child: AppText(title: title,
  color: AppColors.redColor,fontsize: 14,
  fontFamily: AppFontfamily.poppinsMedium,
  textAlign: TextAlign.center,
    ));
}
}
