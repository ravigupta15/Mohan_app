import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';


class ComplaintItemsWidget extends StatelessWidget {
  final String title;
  final String name;
  final String date;
  final String reasonTitle;
  final String status;
  final int tabBarIndex;
  const ComplaintItemsWidget({required this.title,required this.name,required this.date,required this.reasonTitle,
  required this.status, required this.tabBarIndex
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: AppText(title:title,fontsize: 18,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,maxLines: 1,)),
              reasonWidget(reasonTitle)
            ],
          ),
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            children: [
              SvgPicture.asset(AppAssetPaths.userIcon,width: 14,height: 14,),
              SizedBox(width: 6,),
              AppText(title: name,fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
              SizedBox(width: 16,),
              SvgPicture.asset(AppAssetPaths.dateIcon,width: 14,height: 14,),
              SizedBox(width: 6,),
              AppText(title: date,fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
            ],
          ),
        ),
         Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Divider(
                  color: AppColors.edColor,
                ),
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
       padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        children: [
          Container(
            height: 5,width: 5,
            decoration: BoxDecoration(
              color: AppColors.greenColor,shape: BoxShape.circle
            ),
          ),
          const SizedBox(width: 4,),
          tabBarIndex == 1?
            AppText(title: status,fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,):
          Row(
            children: [
              AppText(title: "Pending : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
          AppText(title: status,fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
            ],
          )
        ],
      ),
    );
  }
}