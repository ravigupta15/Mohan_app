
import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_notifier.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';

import '../../../../core/widget/expandable_widget.dart';

class CustomInfoWidget extends StatelessWidget {
  final AddSalesOrderNotifier refNotifier;
 final AddSalesOrderState refState;
  CustomInfoWidget({required this.refNotifier, required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
        initExpanded: false,
        collapsedWidget: collapsedWidget(isExpanded: true),
        expandedWidget: expandedWidget(isExpanded: false));
  }

  collapsedWidget({required bool isExpanded}) {
    return Container(
      padding: !isExpanded
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
         ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: 'Customer Information',
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
          Icon(
            !isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.light92Color,
          ),
        ],
      ),
    );
  }

  Widget expandedWidget({required bool isExpanded}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
         ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(
            height: 10,
          ),
          itemsWidget("Vendor Name", refNotifier.customerNameController.text),
          const SizedBox(
            height: 10,
          ),
          itemsWidget("Shop Name", refNotifier.shopNameController.text),
          refState.selectedVisitType == 1
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: itemsWidget("Channel Parnter",
                      refNotifier.channelPartnerController.text),
                )
              : EmptyWidget(),
          const SizedBox(
            height: 10,
          ),
          itemsWidget(
              "Contact",
              (refState.contactNumberList).isEmpty
                  ? refNotifier.numberController.text
                  : refState.contactNumberList.join(', ')),
          const SizedBox(
            height: 10,
          ),
          itemsWidget("Delivery Date", refNotifier.deliveryDateController.text),
          const SizedBox(
            height: 10,
          ),
           itemsWidget("Details edit needed", refNotifier.isEditDetails == true? "Yes":"No"),
        ],
      ),
    );
  }

  Widget itemsWidget(String title, String subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: "$title : ",
          fontFamily: AppFontfamily.poppinsRegular,
        ),
        Expanded(
          child: AppText(
            title: subTitle,
            fontsize: 13,
            fontFamily: AppFontfamily.poppinsRegular,
            color: AppColors.lightTextColor,
          ),
        ),
      ],
    );
  }
}
