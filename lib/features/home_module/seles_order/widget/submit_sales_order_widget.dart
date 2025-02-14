import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/deal_type_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

import '../../../../core/widget/app_text.dart';
import '../../../../core/widget/app_text_field/app_textfield.dart';

class SubmitSalesOrderWidget extends StatelessWidget {
  final bool isPreview;
  const SubmitSalesOrderWidget({required this.isPreview});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         _AddedProductWidget(),
         const SizedBox(height: 15,),
         _AdditionalDetailsWidget(),
        //  const SizedBox(height: 15,),
        //  _CaptureImage(),
         const SizedBox(height: 15,),
         RemarksWidget(),
         const SizedBox(height: 15,),
         _ActivityWidget(),
         const SizedBox(height: 15,),
         _CustomInfoWidget(),
         const SizedBox(height: 15,),
         _CouponCodeWidget()
        ],
      ),
    );
  }

}


class _AddedProductWidget extends StatelessWidget {
  const _AddedProductWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Align(
              alignment: Alignment.centerRight,
              child: AppText(title: 'Add Products',
              fontsize: 12,color: AppColors.oliveGray,
              fontFamily: AppFontfamily.poppinsSemibold,),
            ),
            const SizedBox(height: 6,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          decoration: BoxDecoration(
            color:AppColors.itemsBG,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.e2Color),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title: 'Added Items',
              fontsize: 14,color: AppColors.black,
              fontFamily: AppFontfamily.poppinsSemibold,),
                const SizedBox(height: 10,),
               expandWidget()
            ],
          ),
        ),
      ],
    );
  }

  expandWidget(){
    return Container(
         decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 16),
      child: Column(
            children: [
          productItemWidget(1),
          const SizedBox(height: 12,),
          productItemWidget(2),
          const SizedBox(height: 12,),
          productItemWidget(3),
            ],
          ),
      );
  }

productItemWidget(int index){
  return Row(
    children: [
      AppText(title: "Item $index",fontFamily: AppFontfamily.poppinsMedium,fontsize: 12,),
      const Spacer(),
      addedProductWidget(),
      const SizedBox(width: 20,),
      SvgPicture.asset(AppAssetPaths.deleteIcon)
    ],
  );
}

  addedProductWidget(){
    return  Expanded(
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customContainerForAddRemove(isAdd: false),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: AppText(title: "2"),
              ),
              customContainerForAddRemove(isAdd: true),
            ],
          ),
    );
  }

Widget customContainerForAddRemove({required bool isAdd}){
    return InkWell(
      onTap: (){},
      child: Container(
        height: 18,width: 18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.edColor,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Icon(isAdd? Icons.add:Icons.remove,
        size: 16,
        color: isAdd?AppColors.greenColor:AppColors.redColor,
        ),
      ),
    );
  }

}


class _AdditionalDetailsWidget extends StatelessWidget {
  const _AdditionalDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "Additional Details",fontFamily: AppFontfamily.poppinsSemibold,),
         const SizedBox(height: 14,),
           DealTypeWidget(),
           const SizedBox(height: 14,),
           
      ],
    );
  }
}
class _ActivityWidget extends StatelessWidget {
  const _ActivityWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 11),
          decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(offset: Offset(0, 0),color: AppColors.black.withValues(alpha: .2),blurRadius: 10)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Activity',fontFamily: AppFontfamily.poppinsSemibold,),
              Icon(Icons.expand_less,color: AppColors.light92Color,),
        ],
      ),
    );
  }
}


class _CustomInfoWidget extends StatelessWidget {
  const _CustomInfoWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: false,
      collapsedWidget: collapsedWidget(isExpanded: true),
     expandedWidget: expandedWidget(isExpanded: false));
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
              AppText(title: 'Customer Information',fontFamily: AppFontfamily.poppinsSemibold,),
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
            const SizedBox(height: 10,),
            itemsWidget("Vendor Name", "Ramesh"),
            const SizedBox(height: 10,),
            itemsWidget("Shop Name", "Ammas"),
            const SizedBox(height: 10,),
            itemsWidget("Contact", "7049234489"),
            const SizedBox(height: 10,),
            itemsWidget("Location", "123, Market Street"),
        ],
      ),
    );
  }




  Widget itemsWidget(String title, String subTitle){
    return Row(
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        AppText(title: subTitle,
        fontsize: 13,
        fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
      ],
    );
  }
}

class _CouponCodeWidget extends StatelessWidget {
  const _CouponCodeWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandWidget(isExpanded: false));
  }

  Widget collapsedWidget({required bool isExpanded}){
    return Container(
        padding:isExpanded? EdgeInsets.symmetric(horizontal: 10,vertical: 12):EdgeInsets.zero,
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         AppText(title: "Coupon Codes",fontFamily:AppFontfamily.poppinsSemibold,),
            Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,color: AppColors.light92Color,),
       ],
      ),
    );
  }

  Widget expandWidget({required bool isExpanded}){
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
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 8,),
          AppTextfield(
            fillColor: false,
            suffixWidget: Container(
               decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8)
              )
            ),
              child: Icon(Icons.arrow_forward,color: AppColors.whiteColor,),
            ),
          )
        ],
      ),
    );
  }
}