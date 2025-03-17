import 'package:mohan_impex/features/home_module/requisitions/trial_plan/model/trial_plan_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/model/view_trial_plan_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class TrialPlanState {
  final bool isLoading;
  int tabBarIndex;
  int selectedConductType;
  TrialPlanModel? trialPlanModel;
  ViewTrialPlanModel? viewTrialPlanModel;
  int currentPage;
  bool isLoadingMore;
  TrialPlanState({required this.isLoading, this.trialPlanModel, required this.tabBarIndex,this.viewTrialPlanModel, this.selectedConductType=0,this.currentPage = 1,this.isLoadingMore =false, 
  });

  TrialPlanState copyWith({  bool? isLoading,int?tabBarIndex, TrialPlanModel? trialPlanModel,
  ViewTrialPlanModel? viewTrialPlanModel, int?selectedConductType,
  int? currentPage,
  bool? isLoadingMore,
  }) {
    return TrialPlanState(
      isLoading: isLoading??this.isLoading,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      trialPlanModel: trialPlanModel??this.trialPlanModel,
      viewTrialPlanModel: viewTrialPlanModel??this.viewTrialPlanModel,
      selectedConductType:selectedConductType??this.selectedConductType,
      currentPage: currentPage??this.currentPage,
      isLoadingMore: isLoadingMore??this.isLoadingMore,
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final trialPlanProvider  =StateNotifierProvider<TrialPlanNotifier,TrialPlanState>((ref)=>TrialPlanNotifier());
