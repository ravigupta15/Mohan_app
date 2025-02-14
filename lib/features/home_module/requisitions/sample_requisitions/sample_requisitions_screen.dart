import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/widgets/journey_approved_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/widgets/journey_pending_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/add_sample_requisitions_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/view_sample_requisitions_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';

import '../../../../res/app_router.dart';

class SampleRequisitionsScreen extends StatefulWidget {
  const SampleRequisitionsScreen({super.key});

  @override
  State<SampleRequisitionsScreen> createState() => _SampleRequisitionsScreenState();
}

class _SampleRequisitionsScreenState extends State<SampleRequisitionsScreen> {
  int tabBarIndex=0;
  int selectedRadio = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: customAppBar(title: "Sample Requisitions",),
       body: Padding(
         padding: const EdgeInsets.only(top: 14),
         child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: AppSearchBar(
                  hintText: "Search by name or status",
                  suffixWidget: Container(
                    alignment: Alignment.center,
                    width:  60,
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssetPaths.searchIcon),
                            Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          height: 20,width: 1,color: AppColors.lightBlue62Color.withValues(alpha: .3),
                        ),
                         InkWell(
                          onTap: (){
                            // filterBottomSheet(context);
                          },
                          child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                       
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
               Padding(
               padding: const EdgeInsets.symmetric(horizontal: 25),
               child: CustomTabbar(
                currentIndex: tabBarIndex,
                title1: "Approved",
                title2: "Pending",
                onClicked1: (){
                  tabBarIndex=0;
                  setState(() {
                  });
                },
                onClicked2: (){
                  tabBarIndex=1;
                  setState(() {
                  });
                },
                ),
             ),
              const SizedBox(height: 10,),
               Expanded(child: tabBarIndex==0?
            JourneyApprovedWidget(title: "Sample #123",):JourneyPendingWidget(
              title: 'Sample #123',
              onTap: (){
              AppRouter.pushCupertinoNavigation(const ViewSampleRequisitionsScreen());
            },)
            ) 
          ],
         ),
       ),
       floatingActionButton: floatingActionButtonWidget(onTap: (){
        AppRouter.pushCupertinoNavigation(const AddSampleRequisitionsScreen());
      }),
    );
  }
}