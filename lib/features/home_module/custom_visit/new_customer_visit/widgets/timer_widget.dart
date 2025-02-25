import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

import '../../../../../utils/app_date_format.dart';

Widget timerWidget(int currentTimer){
  return  Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
          decoration: ShapeDecoration(
            color: AppColors.edColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )),
            child: AppText(title: AppDateFormat.formatDuration(currentTimer),fontFamily: AppFontfamily.poppinsMedium,),
        );
}