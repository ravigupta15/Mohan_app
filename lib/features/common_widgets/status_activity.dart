
// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/utils/app_date_format.dart';

import '../home_module/kyc/model/activity_model.dart';

// ignore: must_be_immutable
class StatusWidget extends StatelessWidget {
  List<Activities>? activities;
   StatusWidget({required this.activities});

  @override
  Widget build(BuildContext context) {
    return (activities?? []).isEmpty ? EmptyWidget() :
     ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collpasedWidget(isExpanded: true),
     expandedWidget: expandedWidget(isExpanded: false));
  }


 Widget collpasedWidget({required bool isExpanded}){
    return Container(
     padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 10,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow:!isExpanded?[]:  [
          BoxShadow(offset: Offset(0, 0),color: AppColors.black.withValues(alpha: .1),blurRadius: 10)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Status',fontFamily: AppFontfamily.poppinsSemibold,),
              Icon(Icons.expand_less,color: AppColors.light92Color,),
        ],
      ),
    );
  }

 Widget expandedWidget({required bool isExpanded}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: Column(
        children: [
           collpasedWidget(isExpanded: isExpanded),
            const SizedBox(height: 10,),
             dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
            ListView.separated(
              separatorBuilder: (ctx,index){
                return const SizedBox(height: 15,);
              },
              shrinkWrap: true,
              itemCount: (activities?.length??0),
              itemBuilder: (ctx,index){
                var model = activities?[index];
              return contentWidget(model);
            }),
           ],
      ),
  );
 }

 Widget contentWidget(Activities? model){
  return Column(
    children: [
      Row(
        children: [
        SvgPicture.asset(AppAssetPaths.selectedTimeIcon,
        colorFilter: ColorFilter.mode(
         (model?.status??'').isEmpty|| (model?.status??'').toLowerCase() =='pending'?
         AppColors.light92Color:
          AppColors.greenColor, BlendMode.srcIn),
        ),
        const SizedBox(width: 7,),
        Expanded(child: AppText(title: model?.role??'',fontFamily: AppFontfamily.poppinsMedium,)),
        Row(
          children: [
            SvgPicture.asset(AppAssetPaths.dateIcon),
            const SizedBox(width: 2,),
            AppText(title: AppDateFormat.formatDate(model?.date??''),fontsize: 10,fontWeight: FontWeight.w300,)
          ],
        )
        ],
      ),
      (model?.status??'').isEmpty || (model?.status??'').toLowerCase() =='pending'?
      EmptyWidget():
      commentWidget(model),
    ],
  );
 }

 Widget commentWidget(Activities? model){
  return Container(
    margin: EdgeInsets.only(left: 30,top: 14),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      border: Border.all(color: AppColors.e2Color,width: .5),
      borderRadius: BorderRadius.circular(5)
    ),
    padding: EdgeInsets.only(top: 9,left: 12,right: 12,bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(AppAssetPaths.userIcon),
            const SizedBox(width: 3,),
            AppText(title: model?.name??'',fontsize: 10,fontFamily:AppFontfamily.poppinsMedium,),
            const SizedBox(width: 6,),
            AppText(title: AppDateFormat.convertTo12HourFormat(model?.time??''),fontsize: 10,fontWeight: FontWeight.w300,),
          ],
        ),
         const SizedBox(height: 12,),
         AppText(title:model?.status??'',fontsize: 10,fontWeight: FontWeight.w300,)
      ],
    ),
  );
 }

}
