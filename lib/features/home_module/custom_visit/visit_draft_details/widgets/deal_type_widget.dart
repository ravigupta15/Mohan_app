import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/custom_slider_widget.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

// ignore: must_be_immutable
class DealTypeWidget extends StatelessWidget {
  double? value;
   DealTypeWidget({this.value});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false));
  }

  collapsedWidget({required bool isExpanded}){
    return Container(
      padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:!isExpanded?[]: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(
            text: "Deal Type",
            style: TextStyle(
             fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.black1 
            ),
            children: [
              TextSpan(
                text: "*",style: TextStyle(
                  color: AppColors.redColor,fontFamily: AppFontfamily.poppinsSemibold
                )
              )
            ]
          )),
            Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
    );
  }

  expandedWidget({required bool isExpanded}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 15,),
          CustomSliderWidget(value: value,)
        ],
      ),
    );
  }
}
