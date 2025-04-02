
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
 final Widget? buttonWidget;
   StatusWidget({required this.activities, this.buttonWidget});

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
     padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColors.cardBorder),
        boxShadow:!isExpanded?[]:  [
          BoxShadow(offset: Offset(0, 0),color: AppColors.black.withValues(alpha: .1),blurRadius: 10)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Status',fontFamily: AppFontfamily.poppinsSemibold,),
               Icon(
            !isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.light92Color,
          ),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (activities?.length??0),
              itemBuilder: (ctx,index){
                var model = activities?[index];
              return contentWidget(model);
            }),
            buttonWidget ?? EmptyWidget()
           ],
      ),
  );
 }

 Widget contentWidget(Activities? model){
  return Column(
    children: [
      Row(
        children: [

        SvgPicture.asset(
          (model?.status??'').isEmpty|| (model?.status??'').toString().toLowerCase().contains('pending')?
          AppAssetPaths.pendingStatusIcon :
          (model?.status??'').toString().toLowerCase().contains('rejected')?
          AppAssetPaths.rejectedStatusIcon:
          AppAssetPaths.selectedTimeIcon,
          
        colorFilter: ColorFilter.mode(
         (model?.status??'').isEmpty|| (model?.status??'').toString().toLowerCase().contains('pending')?
         AppColors.light92Color:
         (model?.status??'').toString().toLowerCase().contains('rejected')?
         AppColors.redColor:
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
         AppText(title:
         (model?.commentType ?? '').toString().toLowerCase() == 'workflow'?
         (model?.status??'') : (model?.comments ?? ''),fontsize: 10,fontWeight: FontWeight.w300,)
      ],
    ),
  );
 }

}
