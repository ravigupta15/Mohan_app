import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/kyc_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/additional_details.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/product_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

class VisitDetailsScreen extends StatefulWidget {
  const VisitDetailsScreen({super.key});

  @override
  State<VisitDetailsScreen> createState() => _VisitDetailsScreenState();
}

class _VisitDetailsScreenState extends State<VisitDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: "Visit",
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
            const SizedBox(height: 19,),
            AdditionalDetails(),
            const SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: AppTextButton(title: "Complete KYC",color: AppColors.arcticBreeze,
              width: 180,height: 40,
              onTap: (){
                AppRouter.pushCupertinoNavigation(KycScreen());
              },
              ),
            )
          ],
        ),
      ),
    );
  }
}
