import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/book_trial_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/capture_image_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

import '../../visit_draft_details/widgets/deal_type_widget.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         _AddedProductWidget(),
         const SizedBox(height: 15,),
         _AdditionalDetailsWidget(),
         const SizedBox(height: 15,),
         _CaptureImage(),
         const SizedBox(height: 15,),
         RemarksWidget(),
         const SizedBox(height: 15,),
         _ActivityWidget(),
         const SizedBox(height: 15,),
         _CustomInfoWidget()
        ],
      ),
    );
  }

}

class _AddedProductWidget extends StatelessWidget {
  const _AddedProductWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
      decoration: BoxDecoration(
        color:AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffE2E2E2)),
        
      ),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: AppText(title: 'Add Products',
              fontsize: 12,color: AppColors.oliveGray,
              fontFamily: AppFontfamily.poppinsSemibold,),
            ),
            const SizedBox(height: 10,),
            ExpandableWidget(
              initExpanded: true,
              collapsedWidget: collapsedWidget(isExpanded: true),
             expandedWidget: expandWidget(isExpanded: false))
        ],
      ),
    );
  }

collapsedWidget({required bool isExpanded}){
    return Container(
         decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      alignment: Alignment.center,
      padding:isExpanded? EdgeInsets.symmetric(horizontal: 15,vertical: 12):EdgeInsets.zero,
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: "Bread",fontFamily:AppFontfamily.poppinsSemibold,),
            Icon(!isExpanded? Icons.expand_less:Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
      );
  }

  expandWidget({required bool isExpanded}){
    return Container(
         decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 20),
      child: Column(
            children: [
              collapsedWidget(isExpanded: isExpanded),
              Padding(padding: EdgeInsets.only(top: 9,bottom: 9),
          child: dotteDivierWidget(dividerColor:  AppColors.edColor,thickness: 1.6),),
          productItemWidget(1),
          const SizedBox(height: 7,),
          productItemWidget(2),
          const SizedBox(height: 7,),
          productItemWidget(3),
            ],
          ),
      );
  }

productItemWidget(int index){
  return Row(
    children: [
      AppText(title: "Item $index",fontFamily: AppFontfamily.poppinsMedium,fontsize: 12,),
      const SizedBox(width: 10,),
      AppText(title: "Variation",fontFamily: AppFontfamily.poppinsMedium,fontsize: 12,),
      addedProductWidget(),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 15,width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.greenColor)
                ),
              ),
              customContainerForAddRemove(isAdd: true),
              const SizedBox(width: 3,),
              AppText(title: "kg",fontsize: 10,color: AppColors.lightTextColor,)
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
      children: [
        Center(
          child:  AppText(title: "Additional Details",fontFamily: AppFontfamily.poppinsSemibold,),
        ),
         const SizedBox(height: 14,),
           DealTypeWidget(),
           const SizedBox(height: 14,),
           _ProductTrial()
      ],
    );
  }
}

class _ProductTrial extends StatefulWidget {
  const _ProductTrial();

  @override
  State<_ProductTrial> createState() => _ProductTrialState();
}

class _ProductTrialState extends State<_ProductTrial> {

  int selectedType = 0;
  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
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
              Text.rich(TextSpan(
            text: "Product Trial",
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
           Row(
          children: [
            customRadioButton(isSelected: selectedType==0? true:false, title: 'Yes',
            onTap: (){
              selectedType=0;
              setState(() {
                
              });
            }),
            const Spacer(),
            customRadioButton(isSelected:selectedType==1?true: false, title: 'No',
            onTap: (){
              selectedType=1;
              setState(() {
              });
            }),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 20,),
        AppTextButton(title: "Book Trial",height: 40,color: AppColors.arcticBreeze,
        onTap: (){
          AppRouter.pushCupertinoNavigation(const BookTrialScreen());
        },
        )
        ],
      ),
    );
  }
}
class _CaptureImage extends StatelessWidget {
  const _CaptureImage();

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
         GestureDetector(
          onTap: (){
            AppRouter.pushCupertinoNavigation(const CaptureImageScreen());
          },
           child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.e2Color)
            ),
            alignment: Alignment.center,
            child:SvgPicture.asset(AppAssetPaths.galleryIcon),
           ),
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
