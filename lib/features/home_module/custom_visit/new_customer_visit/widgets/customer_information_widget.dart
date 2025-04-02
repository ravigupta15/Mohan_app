import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/empty_widget.dart';

import '../../../../../res/app_fontfamily.dart';
import '../riverpod/new_customer_visit_state.dart';

// ignore: must_be_immutable
class CustomerVisitInfoWidget extends StatelessWidget {
  NewCustomerVisitNotifier refNotifier;
  NewCustomerVisitState refState;
   CustomerVisitInfoWidget({
    required this.refNotifier,
    required this.refState
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: false,
      collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false));
  }

Widget collapsedWidget({required bool isExpanded}){
  return Container(
      padding:isExpanded? EdgeInsets.symmetric(horizontal: 10,vertical: 12):EdgeInsets.zero,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(title: "Customer Information",fontFamily:AppFontfamily.poppinsSemibold,),
          Icon(!isExpanded? Icons.expand_less:Icons.expand_more,color: AppColors.light92Color,),
      ],
    ),
  );
}

Widget expandedWidget({required bool isExpanded}){
  return  Container(
       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          // BoxShadow(
          //   offset: Offset(0, 0),
          //   color: AppColors.black.withValues(alpha: .2),
          //   blurRadius: 10
          // )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       collapsedWidget(isExpanded: isExpanded),
            const SizedBox(height: 10,),
            itemsWidget("Vendor Name", refNotifier.customerNameController.text),
            const SizedBox(height: 10,),
            itemsWidget("Shop Name", refNotifier.shopNameController.text),
            refNotifier.channelPartnerController.text.isEmpty ? EmptyWidget():
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: itemsWidget("Channel Partner", refNotifier.channelPartnerController.text),
            ),
            const SizedBox(height: 10,),
            itemsWidget("Contact", (refState.contactNumberList).isEmpty ? refNotifier.numberController.text :
            refState.contactNumberList.join(', ')
            ),
            const SizedBox(height: 10,),
            itemsWidget("Location", LocalSharePreference.currentAddress),
            const SizedBox(height: 10,),
            itemsWidget("Address Type", "BILLING"),
            const SizedBox(height: 10,),
            itemsWidget("Address-1", refNotifier.address1Controller.text),
            refNotifier.address2Controller.text.isEmpty ?EmptyWidget():
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: itemsWidget("Address-2", refNotifier.address2Controller.text),
            ),
            const SizedBox(height: 10,),
            itemsWidget("District", refNotifier.districtController.text),
            const SizedBox(height: 10,),
            itemsWidget("State", refNotifier.stateController.text),
            const SizedBox(height: 10,),
            itemsWidget("Pincode", refNotifier.pincodeController.text),
            const SizedBox(height: 10,),
            itemsWidget("Details edit needed", refNotifier.isEditDetails == true? "Yes":"No"),
        ],
      ),
    );
}


  Widget itemsWidget(String title, String subTitle){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        Expanded(
          child: AppText(title: subTitle,
          fontsize: 13,
          fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
        ),
      ],
    );
  }
}
