

  import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

Widget cardItemsWidget(String title, String subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: "$title : ",
          fontFamily: AppFontfamily.poppinsRegular,
          fontsize: 13,
        ),
        Flexible(
          child: AppText(
            title: subTitle,
            fontsize: 13,
            fontFamily: AppFontfamily.poppinsRegular,
            color: AppColors.lightTextColor,
          ),
        ),
      ],
    );
  }
