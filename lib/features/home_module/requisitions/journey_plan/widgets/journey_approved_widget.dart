import 'package:flutter/material.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/presentation/view_journey_plan_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/riverpod/journey_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/riverpod/journey_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/widgets/journey_plan_items_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/res/shimmer/list_shimmer.dart';

// ignore: must_be_immutable
class JourneyApprovedWidget extends StatelessWidget {
  final JourneyState refState;
  final JourneyNotifier refNotifier;
  ScrollController scrollController;
   JourneyApprovedWidget({required this.refState, required this.refNotifier,required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return refState.isLoading?
    CustomerVisitShimmer(isKyc: true,isShimmer: refState.isLoading):
    (refState.collateralsReqestModel?.data?[0].records?.length??0)>0?
    ListView.separated(
      separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: (refState.collateralsReqestModel?.data?[0].records?.length??0),
      padding: EdgeInsets.only(top: 10,bottom: 20,left: 17,right: 17),
      shrinkWrap: true,
      controller: scrollController,
      itemBuilder: (ctx,index){
        var model = refState.collateralsReqestModel?.data?[0].records?[index];
        return Column(
          children: [
            GestureDetector(
              onTap: (){
                AppRouter.pushCupertinoNavigation( ViewJourneyPlanScreen(id: model?.name??'',)).then((val){
                  // refNotifier.journeyPlanListApiFunction();
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
                         title:model?.name??'',
                        status: model?.status,
                        statusDes: model?.approvedDate??'',
                        ),
                ),
              ),
            ),
             index == (refState.collateralsReqestModel?.data?[0].records?.length??0) - 1 &&
                              refState.isLoadingMore
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              width: 37,
                              height: 37,
                              child: const CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            )
                          : SizedBox.fromSize()
          ],
        );
    }): NoDataFound(title: "No apporved journey plan found");
  }

}