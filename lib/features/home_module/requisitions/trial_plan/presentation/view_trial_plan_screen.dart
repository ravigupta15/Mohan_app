import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/presentation/trial_product_item_screen.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

import '../../../../../res/app_asset_paths.dart';

class ViewTrialPlanScreen extends StatefulWidget {
  const ViewTrialPlanScreen({super.key});

  @override
  State<ViewTrialPlanScreen> createState() => _ViewTrialPlanScreenState();
}

class _ViewTrialPlanScreenState extends State<ViewTrialPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Trial #125"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 14,left: 19,right: 19,bottom: 20),
        child: Column(
          children: [
            _StatusWidget(),
             const SizedBox(height: 15,),
             _TrialPlanDetailsWidget(),
             const SizedBox(height: 15,),
             _ItemRequestedWidget(),
             const SizedBox(height: 15,),
             RemarksWidget()
          ],
        ),
      ),
    );
  }
}

class _StatusWidget extends StatelessWidget {
  const _StatusWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
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
        boxShadow:!isExpanded?[]:  [
          BoxShadow(offset: Offset(0, 0),color: AppColors.black.withValues(alpha: .2),blurRadius: 10)
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
            headerWidget(img: AppAssetPaths.selectedTimeIcon, title: "ASM Review", date: "03 Jan 2025 10:30 AM"),
            commentWidget(),
            const SizedBox(height: 11,),
            headerWidget(img: AppAssetPaths.unselectedTimeIcon, title: "MNS Review", date: '')
        ],
      ),
  );
 }

 Widget headerWidget({required String img,required String title, required String date}){
  return Row(
    children: [
    SvgPicture.asset(img),
    const SizedBox(width: 7,),
    Expanded(child: AppText(title: title,fontFamily: AppFontfamily.poppinsMedium,)),
    date.isEmpty ? SizedBox.shrink() :
    Row(
      children: [
        SvgPicture.asset(AppAssetPaths.dateIcon),
        const SizedBox(width: 2,),
        AppText(title: date,fontsize: 10,fontWeight: FontWeight.w300,)
      ],
    )
    ],
  );
 }

 Widget commentWidget(){
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
            AppText(title: "John Doe",fontsize: 10,fontFamily:AppFontfamily.poppinsMedium,),
            const SizedBox(width: 6,),
            AppText(title: "10:35 AM",fontsize: 10,fontWeight: FontWeight.w300,),
          ],
        ),
         const SizedBox(height: 12,),
         AppText(title: "Approved",fontsize: 10,fontWeight: FontWeight.w300,)
      ],
    ),
  );
 }
}

class _TrialPlanDetailsWidget extends StatelessWidget {
  const _TrialPlanDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false));
  }
  Widget collapsedWidget({required bool isExpanded}){
    return Container(
        padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 10,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:!isExpanded?[]:  [
          BoxShadow(offset: Offset(0, 0),color: AppColors.black.withValues(alpha: .2),blurRadius: 10)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Trial Plan Details',fontFamily: AppFontfamily.poppinsSemibold,),
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
          collapsedWidget(isExpanded: isExpanded),
            const SizedBox(height: 10,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
            itemsWidget("Trial Type", "Self"),
            const SizedBox(height: 16,),
            itemsWidget("Trial Date :", "11-02-2024"),
            const SizedBox(height: 16,),
            itemsWidget("Trial Time :", "14:23"),
            const SizedBox(height: 16,),
            itemsWidget("Customer Type : ", "Primary"),
            const SizedBox(height: 16,),
            itemsWidget("Type", "Product"),
        ],
      )
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


class _ItemRequestedWidget extends StatelessWidget {
  const _ItemRequestedWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true),
     expandedWidget: expandedWidget(isExpanded: false));
  }

 Widget collapsedWidget({required bool isExpanded}){
   return Container(
    padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 10,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:!isExpanded?[]:  [
          BoxShadow(offset: Offset(0, 0),color: AppColors.black.withValues(alpha: .2),blurRadius: 10)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Trial Products',fontFamily: AppFontfamily.poppinsSemibold,),
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
          collapsedWidget(isExpanded: isExpanded),
           const SizedBox(height: 10,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
            headingWidget(),
            const SizedBox(height: 7,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: GestureDetector(
                onTap: (){
                  AppRouter.pushCupertinoNavigation(TrialProductItemScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: "Item 1",fontWeight: FontWeight.w400,),
                    Container(
                      alignment: Alignment.center,
                      child: AppText(title: "pending",fontsize: 12,color: AppColors.mossGreyColor,),)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: GestureDetector(
                onTap: (){
                  AppRouter.pushCupertinoNavigation(TrialProductItemScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: "Item 2",fontWeight: FontWeight.w400,),
                    Container(
                      alignment: Alignment.center,
                      child: AppText(title: "pending",fontsize: 12,color: AppColors.mossGreyColor,),)
                  ],
                ),
              ),
            ),
        ],
      ),
   );
  }

  headingWidget(){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.edColor,
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.symmetric(horizontal: 19,vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: AppText(title: "Item",fontsize: 12,fontFamily: AppFontfamily.poppinsMedium,color: AppColors.oliveGray,)),
          SizedBox(
            width: 60,
            child: AppText(title: "Report",fontsize: 12,fontFamily: AppFontfamily.poppinsMedium,color: AppColors.oliveGray,),
          ),
        ],
      ),
    );
  }

}
