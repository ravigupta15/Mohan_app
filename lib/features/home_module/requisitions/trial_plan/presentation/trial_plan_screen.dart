import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/presentation/add_trial_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

class TrialPlanScreen extends ConsumerStatefulWidget {
  const TrialPlanScreen({super.key});

  @override
  ConsumerState<TrialPlanScreen> createState() => _TrialPlanScreenState();
}

class _TrialPlanScreenState extends ConsumerState<TrialPlanScreen> {

@override
  void initState() {
  Future.microtask((){
    callInitFunction();
  });
    super.initState();
  }

  callInitFunction(){
     ref.read(trialPlanProvider.notifier).resetValues();
    ref.read(trialPlanProvider.notifier).trialPlanListApiFunction();
  }

  @override
  Widget build(BuildContext context) {
      final refNotifer = ref.read(trialPlanProvider.notifier);
    final refState = ref.watch(trialPlanProvider);
    return Scaffold(
      appBar: customAppBar(title: 'Trial Plan'),
      body: Padding(
         padding: const EdgeInsets.only(top: 14),
        child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: AppSearchBar(
                  hintText: "Search by name, status, etc",
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
                currentIndex:refState.tabBarIndex,
                title1: "Approved",
                title2: "Pending",
                onClicked1: (){
                  refState.tabBarIndex=0;
                  setState(() {
                  });
                },
                onClicked2: (){
                  refState.tabBarIndex=1;
                  setState(() {
                  });
                },
                ),
             ),
               const SizedBox(height: 10,),
            // Expanded(child: tabBarIndex==0?
            // JourneyApprovedWidget(title: "Trial of Product #125",):JourneyPendingWidget(
            //   title: 'Trial of Product #125',
            //   onTap: (){
            //   AppRouter.pushCupertinoNavigation(const ViewTrialPlanScreen());
            // },)
            // ) 
          ],
        ),
      ),
      floatingActionButton: floatingActionButtonWidget(onTap: (){
        AppRouter.pushCupertinoNavigation(const AddTrialScreen());
      }),
    );
    
  }
}