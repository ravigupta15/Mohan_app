import 'package:mohan_impex/features/home_module/custom_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/collaterals_request_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/model/view_sample_requisitions_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class TrialPlanState {
  final bool isLoading;
  int tabBarIndex;
  int selectedTrialPlan;
  CollateralsRequestModel? jounreyPlanModel;
  ViewSampleRequisitionsModel? viewSampleRequisitionsModel;
  ItemModel? itemModel;
  TrialPlanState({required this.isLoading, this.jounreyPlanModel, required this.tabBarIndex,this.viewSampleRequisitionsModel, this.itemModel, this.selectedTrialPlan=0});

  TrialPlanState copyWith({  bool? isLoading,int?tabBarIndex, CollateralsRequestModel? jounreyPlanModel,
  ViewSampleRequisitionsModel? viewSampleRequisitionsModel,ItemModel? itemModel, int?selectedTrialPlan
  }) {
    return TrialPlanState(
      isLoading: isLoading??this.isLoading,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      jounreyPlanModel: jounreyPlanModel??this.jounreyPlanModel,
      viewSampleRequisitionsModel: viewSampleRequisitionsModel??this.viewSampleRequisitionsModel,
      itemModel: itemModel??this.itemModel,
      selectedTrialPlan:selectedTrialPlan??this.selectedTrialPlan
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final trialPlanProvider  =StateNotifierProvider<TrialPlanNotifier,TrialPlanState>((ref)=>TrialPlanNotifier());
