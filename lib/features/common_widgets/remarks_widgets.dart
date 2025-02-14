
import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class RemarksWidget extends StatelessWidget {
  const RemarksWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: remarkesCollapsedWidget(isExpanded: true),
       expandedWidget: remarkesExpandedWidget(isExpanded: false));
  }

  remarkesCollapsedWidget({required bool isExpanded}){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         AppText(title: "Remarks",fontFamily:AppFontfamily.poppinsSemibold,),
         Icon(isExpanded? Icons.expand_more:Icons.expand_more,color: AppColors.light92Color,),
       ],
      ),
    );
  }


  remarkesExpandedWidget({required bool isExpanded}){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        border: Border.all(color: Color(0xffE2E2E2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: "Remarks",fontFamily:AppFontfamily.poppinsSemibold,),
              Icon(Icons.expand_less,color: AppColors.light92Color,),
            ],
          ),
          const SizedBox(height: 8,),
          AppTextfield(
            fillColor: false,maxLines: 3,
            hintText: "Need row items in large quanity for bread.",
          )
        ],
      ),
    );
  }

  Widget remakrsContentWidget(){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
        
      ),
      padding: EdgeInsets.only(left: 10,right: 10,top:10,bottom: 15),
      child: AppText(title: "Need row items in large quanity for bread. Need row items in large quanity for bread.",
      
      ),
    );
  }
}
