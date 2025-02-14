import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';


class KycItem extends StatelessWidget {

  final String title;
  final String name;
  final String date;
  final String userIcon;
  final String dateIcon;


  const KycItem({required this.title,required this.name,required this.date,required this.userIcon,required this.dateIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "$title",fontsize: 20,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        SizedBox(height: 5,),
        Row(
          children: [
            SvgPicture.asset(userIcon,width: 14,height: 14,),
            SizedBox(width: 6,),
            AppText(title: name,fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
            SizedBox(width: 16,),
            SvgPicture.asset(dateIcon,width: 14,height: 14,),
            SizedBox(width: 6,),
            AppText(title: date,fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
          ],
        )
      ],
    );
  }
}