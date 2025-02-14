import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/presentation/journey_plan_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/presentation/marketing_collaterals_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/sample_requisitions_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/presentation/trial_plan_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

import '../../../../res/app_colors.dart';

class RequisitionsScreen extends StatefulWidget {
  const RequisitionsScreen({super.key});

  @override
  State<RequisitionsScreen> createState() => _RequisitionsScreenState();
}

class _RequisitionsScreenState extends State<RequisitionsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Requisitions'),
      body: Padding(
        padding: const EdgeInsets.only(top: 14,left: 18,right: 18),
        child: Column(
          children: [
            Row(
              children: [
                otherUserCustomContainer(title: "Journey Plan", img: AppAssetPaths.journeyPlanIcon, onTap: (){
                  AppRouter.pushCupertinoNavigation(const JourneyPlanScreen());
                }),
                const SizedBox(width: 15,),
                otherUserCustomContainer(title: "Sample Requisition", img: AppAssetPaths.sampleIcon, onTap: (){
                  AppRouter.pushCupertinoNavigation(const SampleRequisitionsScreen());
                }),
              ],
            ),
            const SizedBox(height: 26,),
             Row(
              children: [
                otherUserCustomContainer(title: "Trial Plan", img: AppAssetPaths.trialPlanIcon, onTap: (){
                  AppRouter.pushCupertinoNavigation(const TrialPlanScreen());
                }),
            const SizedBox(width: 15,),
                otherUserCustomContainer(title: "Marketing Collaterals", img: AppAssetPaths.digitalIcon, onTap: (){
                  AppRouter.pushCupertinoNavigation(const MarketingCollateralsScreen());
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }


  otherUserCustomContainer(
      {required String title,
      bool isBoxShadow = false,
      required String img,
      required Function() onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 70,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.e2Color, width: 2),
              boxShadow:  [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 6)
                    ]),
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                img,
                height: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                  child: AppText(
                title: title,
                fontsize: 13,
                fontFamily: AppFontfamily.poppinsMedium,
              )),
            ],
          ),
        ),
      ),
    );
  }

}