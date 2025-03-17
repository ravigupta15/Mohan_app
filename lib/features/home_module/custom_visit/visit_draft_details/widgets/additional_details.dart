import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/deal_type_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';

class AdditionalDetails extends StatelessWidget {
  const AdditionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title: "Additional Details",fontFamily: AppFontfamily.poppinsSemibold,),
          const SizedBox(height: 14,),
           DealTypeWidget(),
           const SizedBox(height: 14,),
           _CustomInfoWidget(),
           const SizedBox(height: 14,),
           RemarksWidget(),
           const SizedBox(height: 14,),
           _CaptureImage(),
           const SizedBox(height: 14,),
           _ProductTrial(),
           const SizedBox(height: 14,),
           _ActivityWidget()
        ],
      ),
    );
  }

}


class _CustomInfoWidget extends StatelessWidget {
  const _CustomInfoWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
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
            AppText(title: "Customer Information",fontFamily:AppFontfamily.poppinsSemibold,),
            const SizedBox(height: 10,),
            itemsWidget("Vendor Name", "Ramesh"),
            const SizedBox(height: 20,),
            itemsWidget("Shop Name", "Ammas"),
            const SizedBox(height: 20,),
            itemsWidget("Contact", "7049234489"),
            const SizedBox(height: 20,),  
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

class _CaptureImage extends StatelessWidget {
  const _CaptureImage();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.e2Color),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .1),
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
            text: "Capture Image",
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
          const SizedBox(height: 12,),
          Row(
            children: [
              Image.asset("assets/dummy/shop.png",height: 60,),
              const SizedBox(width: 10,),
          addImageWidget()
            ],
          )
        ],
      ),
    );
  }

  Widget addImageWidget(){
    return DottedBorder(
      dashPattern: [5,6],
      borderType: BorderType.RRect,
      color: AppColors.greenColor,
      radius: Radius.circular(13),
      child: Container(
        height: 55,width: 75,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14)
        ),
        child: Icon(Icons.add,size: 40,color: AppColors.light92Color,),
      ));
  }
}

class _ProductTrial extends StatefulWidget {
  const _ProductTrial();

  @override
  State<_ProductTrial> createState() => _ProductTrialState();
}

class _ProductTrialState extends State<_ProductTrial> {
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
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: 'Product Trial',fontFamily: AppFontfamily.poppinsSemibold,),
            Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
);
  }

  expandedWidget({required bool isExpanded}){
    return  Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        border: Border.all(color: Color(0xffE2E2E2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
        collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 10,),
          Row(
            children: [
              customRadioButton(isSelected: true, title: "Yes",),
              const Spacer(),
              customRadioButton(isSelected: false, title: "No",),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              AppText(title: "Trial Type : ",fontFamily: AppFontfamily.poppinsMedium,fontsize: 13,),
              AppText(title: "TSM Required",fontsize: 13,),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              AppText(title: "Appointment : ",fontFamily: AppFontfamily.poppinsMedium,fontsize: 13,),
              AppText(title: "01 January 2025",fontsize: 13,),
            ],
          ),
          const SizedBox(height: 15,),
          Align(
              alignment: Alignment.centerRight,
              child: AppText(title: 'Add Products',
              fontsize: 12,color: AppColors.oliveGray,
              fontFamily: AppFontfamily.poppinsSemibold,),
            ),
            const SizedBox(height: 4,),
          productWidget()
        ],

      ),
    );
  }

  productWidget(){
    return Container(
       decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
        
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: AppText(title: "Item 1",)),
              SvgPicture.asset(AppAssetPaths.deleteIcon)
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              Expanded(child: AppText(title: "Item 2",)),
              SvgPicture.asset(AppAssetPaths.deleteIcon)
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              Expanded(child: AppText(title: "Item 3",)),
              SvgPicture.asset(AppAssetPaths.deleteIcon)
            ],
          ),
        ],
      ),
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
