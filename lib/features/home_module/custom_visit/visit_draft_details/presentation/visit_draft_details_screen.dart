import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/additional_details.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/product_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/visit_draft_details_tabbar.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class VisitDraftDetailsScreen extends StatefulWidget {
  const VisitDraftDetailsScreen({super.key});

  @override
  State<VisitDraftDetailsScreen> createState() => _VisitDraftDetailsScreenState();
}

class _VisitDraftDetailsScreenState extends State<VisitDraftDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Visit Draft",
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
          decoration: ShapeDecoration(
            color: AppColors.edColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )),
            child: AppText(title: "1:30:22",color: AppColors.greenColor,fontFamily: AppFontfamily.poppinsMedium,),
        )
      ]
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 12,left: 17,right: 18,bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedTabBarWidget(),
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: AppText(title: 'Overview',fontFamily: AppFontfamily.poppinsSemibold,)),
            Align(
              alignment: Alignment.centerRight,
              child: AppText(title: 'Add Products',
              fontsize: 12,color: AppColors.oliveGray,
              fontFamily: AppFontfamily.poppinsSemibold,),
            ),
            const SizedBox(height: 4,),
            ProductWidget(),
            const SizedBox(height: 19,),
            AdditionalDetails(),
            const SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: AppTextButton(title: "Resume",color: AppColors.arcticBreeze,
              width: 180,height: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
  
}