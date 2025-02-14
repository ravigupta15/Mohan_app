import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';


class JourneyPlanItemsWidget extends StatelessWidget {
  final String title;

  const JourneyPlanItemsWidget({required this.title,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: AppText(title:title,fontsize: 20,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
          ),
        SizedBox(height: 10,),
         Divider(
           color: AppColors.edColor,
         ),
        statusWidget()
      ],
    );
  }

  reasonWidget(String title){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.cardBorder)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
      child: AppText(title: title,fontsize: 12,fontFamily: AppFontfamily.poppinsMedium,),
    );
  }

  statusWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Container(
            height: 5,width: 5,
            decoration: BoxDecoration(
              color: AppColors.greenColor,shape: BoxShape.circle
            ),
          ),
          const SizedBox(width: 4,),
          AppText(title: "Approved : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
          AppText(title: "2025-01-01",fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
        ],
      ),
    );
  }
}