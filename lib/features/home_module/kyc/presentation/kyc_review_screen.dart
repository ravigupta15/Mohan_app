import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/kyc_page_number.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/kyc_complate_screen.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/app_text.dart';
import '../../../../core/widget/expandable_widget.dart';
import '../../../../core/widget/app_text_field/label_text_textfield.dart';
import '../../../../res/app_fontfamily.dart';

class KycReviewScreen extends StatefulWidget {
  const KycReviewScreen({super.key});

  @override
  State<KycReviewScreen> createState() => _KycReviewScreenState();
}

class _KycReviewScreenState extends State<KycReviewScreen> {
  int tabBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'KYC'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDividerWidget(
              number: '3',
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: AppText(
                title: "Review",
                fontFamily: AppFontfamily.poppinsSemibold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            _CustomInfoWidget(),
            const SizedBox(
              height: 24,
            ),
            _DocumentCheckListWidget(),
            const SizedBox(
              height: 24,
            ),
            RemarksWidget(),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2, // Add a flex value to control how space is distributed
                  child: AppButton(
                    height: 40,
                    color: Colors.black,
                    onPressed: () {
                      // AppRouter.pushReplacementNavigation(const KycScreen());
                    },
                    title: "Back",
                  ),
                ),
                Spacer(),

                Flexible(
                  flex: 2, // Add a flex value to the submit button too
                  child: AppButton(
                    color: Colors.black,
                    onPressed: () {
                      AppRouter.pushCupertinoNavigation(kycComplate());
                    },
                    height: 40,
                    title: "Submit",
                  ),
                ),
              ],
            )

          ],
        ),
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
        collapsedWidget: collapsedWidget(isExpanded: true,),
        expandedWidget: expandedWidget(isExpanded: false));
  }

  Widget collapsedWidget({required bool isExpanded}) {
    return Container(
      padding: isExpanded
          ? EdgeInsets.symmetric(horizontal: 10, vertical: 12)
          : EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                  title: "Customer Information",
                  fontFamily: AppFontfamily.poppinsSemibold),
              Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.light92Color),
            ],
          ),
          SizedBox(height: 5,),
          !isExpanded ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(34, (index) {
              return Container(
                width: 8.5,
                // Width of each dash
                height: 2,
                // Line thickness
                color: index % 2 == 0 ?AppColors.edColor : Colors.transparent,
                // Alternating between black and transparent
                margin: EdgeInsets.symmetric(
                    horizontal: 0), // Spacing between dashes
              );
            }),
          ):SizedBox()
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
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withOpacity(0.2),
                blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 10),
          itemsWidget("Vendor Name", "Ramesh"),
          const SizedBox(height: 10),
          itemsWidget("Shop Name", "Ammas"),
          const SizedBox(height: 10),
          itemsWidget("Contact", "7049234489"),
          const SizedBox(height: 10),
          itemsWidget("Location", "123, Market Street"),
          const SizedBox(height: 10),
          Center(
            child: AppText(
                title: "Other details",
                fontsize: 14,
                fontFamily: AppFontfamily.poppinsRegular,
                color: AppColors.redColor),
          ),
        ],
      ),
    );
  }

  Widget itemsWidget(String title, String subTitle) {
    return Row(
      children: [
        AppText(title: "$title : ", fontFamily: AppFontfamily.poppinsRegular,fontsize: 14,color: Colors.black,),
        AppText(
            title: subTitle,
            fontsize: 14,
            fontFamily: AppFontfamily.poppinsRegular,
            color: AppColors.lightTextColor),
      ],
    );
  }
}

class _DocumentCheckListWidget extends StatelessWidget {
  const _DocumentCheckListWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
        initExpanded: false,
        collapsedWidget: collapsedWidget(isExpanded: true,),
        expandedWidget: expandedWidget(isExpanded: false));
  }

  Widget collapsedWidget({required bool isExpanded})  {
    return Container(
      padding: isExpanded
          ? EdgeInsets.symmetric(horizontal: 10, vertical: 12)
          : EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                  title: "Documents Checklist",
                  fontFamily: AppFontfamily.poppinsSemibold),
              Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.light92Color),
            ],
          ),
          SizedBox(height: 5,),
          !isExpanded ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(34, (index) {
              return Container(
                width: 8.5,
                // Width of each dash
                height: 2,
                // Line thickness
                color: index % 2 == 0 ?AppColors.edColor : Colors.transparent,
                // Alternating between black and transparent
                margin: EdgeInsets.symmetric(
                    horizontal: 0), // Spacing between dashes
              );
            }),
          ):SizedBox()
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
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withOpacity(0.2),
                blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          SizedBox(height: 10,),
          LabelTextTextfield(title: "Customer Declaration (CD)", isRequiredStar: true),
        ],
      ),
    );
  }
}
