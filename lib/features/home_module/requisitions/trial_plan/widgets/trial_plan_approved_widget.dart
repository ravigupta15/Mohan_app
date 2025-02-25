import 'package:flutter/material.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/widgets/journey_plan_items_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/presentation/view_sample_requisitions_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/res/shimmer/list_shimmer.dart';

class SampleApprovedWidget extends StatelessWidget {
   final TrialPlanState  refState;
  final TrialPlanNotifier refNotifier;
  const SampleApprovedWidget({required this.refState, required this.refNotifier});

  @override
  Widget build(BuildContext context) {
    return refState.isLoading?
    CustomerVisitShimmer(isKyc: true,isShimmer: refState.isLoading):
    (refState.jounreyPlanModel?.data?[0].records?.length??0)>0?
    ListView.separated(
      separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: (refState.jounreyPlanModel?.data?[0].records?.length??0),
      padding: EdgeInsets.only(top: 10,bottom: 20,left: 17,right: 17),
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        var model = refState.jounreyPlanModel?.data?[0].records?[index];
        return GestureDetector(
          onTap: (){
            AppRouter.pushCupertinoNavigation( ViewSampleRequisitionsScreen(id: model?.name??'',)).then((val){
              refNotifier.trialPlanListApiFunction();
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  color: AppColors.black.withValues(alpha: .2),
                  blurRadius: 3
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child:JourneyPlanItemsWidget(
                     title:"Ticket #${model?.name??''}",
                    status: "Approved",
                    statusDes: model?.approvedDate??'',
                    ),
            ),
          ),
        );
    }): NoDataFound(title: "No apporved trial plan found");
  }

}