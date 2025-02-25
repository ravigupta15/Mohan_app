import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/view_journey_plan_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/riverpod/journey_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/collaterals_request_model.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class JourneyState {
  final bool isLoading;
  int tabBarIndex;
  CollateralsRequestModel? collateralsReqestModel;
  ViewJounreyPlanModel? viewJounreyPlanModel;
  StateModel?stateModel;
  DistrictModel? districtModel;
  int page;
  bool isLoadingMore;
  JourneyState({required this.isLoading, this.collateralsReqestModel, required this.tabBarIndex,this.viewJounreyPlanModel,
  this.stateModel, this.districtModel, this.page =1,this.isLoadingMore=false
  });

  JourneyState copyWith({  bool? isLoading,int?tabBarIndex, CollateralsRequestModel? collateralsReqestModel,
  ViewJounreyPlanModel?viewJounreyPlanModel, StateModel?stateModel, DistrictModel? districtModel,int?page,
  bool?isLoadingMore
  }) {
    return JourneyState(
      isLoading: isLoading??this.isLoading,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      collateralsReqestModel: collateralsReqestModel??this.collateralsReqestModel,
      viewJounreyPlanModel: viewJounreyPlanModel??this.viewJounreyPlanModel,
      stateModel: stateModel??this.stateModel,
      districtModel: districtModel??this.districtModel,
      page: page??this.page,
      isLoadingMore: isLoadingMore??this.isLoadingMore
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final journeyProvider  =StateNotifierProvider<JourneyNotifier,JourneyState>((ref)=>JourneyNotifier());
