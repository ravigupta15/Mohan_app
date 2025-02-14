import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/special_report/sales_target/sales_target.dart';
import 'package:mohan_impex/features/home_module/special_report/trial_target/trial_target.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

import '../../../../res/app_colors.dart';
import 'new_wins/new_wins.dart';

class SpecialReportScreen extends StatefulWidget {
  const SpecialReportScreen({super.key});

  @override
  State<SpecialReportScreen> createState() => _SpecialReportScreenState();
}

class _SpecialReportScreenState extends State<SpecialReportScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Special Report'),
      body: Padding(
        padding: const EdgeInsets.only(top: 14,left: 17,right: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: otherUserCustomContainer(title: "Sales Target", img: AppAssetPaths.journeyPlanIcon, onTap: (){
                  AppRouter.pushCupertinoNavigation(const SalesTarget());
                })),
                const SizedBox(width: 15,),
                Expanded(child: otherUserCustomContainer(title: "Trial Target", img: AppAssetPaths.sampleIcon, onTap: (){
                  AppRouter.pushCupertinoNavigation(const TrialTarget());
                })),
              ],
            ),
            const SizedBox(height: 26,),
            otherUserCustomContainer(title: "New Wins", img: AppAssetPaths.trialPlanIcon, onTap: (){
                  AppRouter.pushCupertinoNavigation(const NewWins());
                }),
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
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width/2.5,
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
    );
  }

}