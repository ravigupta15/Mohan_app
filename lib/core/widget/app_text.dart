import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  final String title;
  double? fontsize;
  FontWeight? fontWeight;
  String? fontFamily;
  Color ?color;
  int? maxLines;
  TextAlign?textAlign;
  TextDecoration decoration;
   AppText({required this.title,this.fontFamily = AppFontfamily.poppinsRegular, this.fontWeight,this.fontsize,this.color = AppColors.black1,this.
  maxLines,this.textAlign,this.decoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Text(title,
    maxLines: maxLines,
    textAlign: textAlign,
    overflow:maxLines==null?null: TextOverflow.ellipsis,
    style: TextStyle(
      decoration: decoration,
      decorationColor: color,
      fontSize: fontsize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color
    ),
    );
  }
}