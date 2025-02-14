import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/deal_type_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/product_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

import '../../../../core/widget/app_text.dart';
import '../../../../res/app_colors.dart';

class ViewOrderScreen extends StatefulWidget {
  const ViewOrderScreen({super.key});

  @override
  State<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: "Sales Order",
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.greenColor,width: .5)),
            child: AppText(title: "Complete",fontsize: 9,),
        )
      ]
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 12,left: 17,right: 17,bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             ProductWidget(),
             const SizedBox(height: 15,),
             _AdditionalDetailsWidget()
          ],
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
           _CustomInfoWidget(),
           const SizedBox(height: 14,),
           RemarksWidget(),
           const SizedBox(height: 14,),
           _ActivityWidget()
           
      ],
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

class _ActivityWidget extends StatelessWidget {
  const _ActivityWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandWidget(isExpanded: false));
  }

  Widget collapsedWidget({required bool isExpanded}){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         AppText(title: "Activity",fontFamily:AppFontfamily.poppinsSemibold,),
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
      children: [
        collapsedWidget(isExpanded: isExpanded),
         const SizedBox(height: 8,),
         Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3),
        width: .5
        ),
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 20),
      child: ListView.separated(
        separatorBuilder: (ctx,sp){
          return const SizedBox(height: 15,);
        },
        itemCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(AppAssetPaths.userIcon),
              const SizedBox(width: 6,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(title: "ASM",fontsize: 12,fontFamily: AppFontfamily.poppinsMedium,),
                      const SizedBox(width: 8,),
                      AppText(title: "10:35 AM",fontsize: 12,),
                    ],
                  ),
                      AppText(title: "Please make corrections",fontsize: 11,),
                ],
              )
            ],
          );
        }
      ),
         )
      ],
     ),
    );
  }
}



