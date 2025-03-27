
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

// ignore: must_be_immutable
class RemarksWidget extends StatelessWidget {
  final bool isEditable;
  final TextEditingController? controller;
  final String remarks;
  String? Function(String?)? validator;
  final bool isRequired;
  final double horizontalPadding;
   RemarksWidget({this.isEditable=true, this.controller, this.remarks = '',this.validator, this.isRequired=false,
   this.horizontalPadding = 10
   });

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: remarkesCollapsedWidget(isExpanded: true),
       expandedWidget: remarkesExpandedWidget(isExpanded: false));
  }

  remarkesCollapsedWidget({required bool isExpanded}){
    return Container(
        padding:!isExpanded?null: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: 14),
      child: Row(
       children: [
         AppText(title: "Remarks",fontFamily:AppFontfamily.poppinsSemibold,),
       isRequired?  AppText(title: "*",color: AppColors.redColor,): SizedBox.shrink(),
         const Spacer(),
         Icon(isExpanded? Icons.expand_more:Icons.expand_less,color: AppColors.light92Color,),
       ],
      ),
    );
  }


  remarkesExpandedWidget({required bool isExpanded}){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        // border: Border.all(color: Color(0xffE2E2E2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           remarkesCollapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 8,),
          isEditable?
          AppTextfield(
            fillColor: false,maxLines: 3,
            controller: controller,
            hintText: "Enter your remarks",
            inputFormatters: [
              FilteringTextInputFormatter.deny(
              RegExp(r'^\s+'),
              )
            ],
            validator: validator,
          ) : remakrsContentWidget()
        ],
      ),
    );
  }

  Widget remakrsContentWidget(){
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      alignment: remarks.isEmpty ? Alignment.center : null,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        scrollDirection: Axis.vertical,
        child: AppText(title:remarks.isEmpty ? "No Remakrs" : remarks,)),
    );
  }
}
