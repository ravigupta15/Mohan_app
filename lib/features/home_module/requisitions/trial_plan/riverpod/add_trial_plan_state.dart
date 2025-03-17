import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/unv_customer_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/collaterals_request_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/model/view_sample_requisitions_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/add_trial_plan_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class AddTrialPlanState {
  final bool isLoading;
  int tabBarIndex;
  int selectedConductType;
  CollateralsRequestModel? jounreyPlanModel;
  ViewSampleRequisitionsModel? viewSampleRequisitionsModel;
  ItemModel? itemModel;
  int currentPage;
  bool isLoadingMore;
  CustomerInfoModel? customerInfoModel;
  UNVCustomerModel? unvCustomerModel;
  StateModel? stateModel;
  DistrictModel? districtModel;
  String verifiedCustomerLocation;
  String unvName;
  String selectedExistingCustomer;
  AddTrialPlanState({required this.isLoading, this.jounreyPlanModel, required this.tabBarIndex,this.viewSampleRequisitionsModel, this.itemModel, this.selectedConductType=0,this.currentPage = 1,this.isLoadingMore =false, this.customerInfoModel, this.unvCustomerModel, this.stateModel, this.districtModel,
  this.verifiedCustomerLocation = '', this.unvName = '', this.selectedExistingCustomer = ''
  });

  AddTrialPlanState copyWith({  bool? isLoading,int?tabBarIndex, CollateralsRequestModel? jounreyPlanModel,
  ViewSampleRequisitionsModel? viewSampleRequisitionsModel,ItemModel? itemModel, int?selectedConductType,
  int? currentPage,
  bool? isLoadingMore,
  CustomerInfoModel? customerInfoModel,
  UNVCustomerModel? unvCustomerModel,
  StateModel? stateModel,
  DistrictModel? districtModel,
  String? verifiedCustomerLocation,
  String? unvName,
  String? selectedExistingCustomer,
  }) {
    return AddTrialPlanState(
      isLoading: isLoading??this.isLoading,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      jounreyPlanModel: jounreyPlanModel??this.jounreyPlanModel,
      viewSampleRequisitionsModel: viewSampleRequisitionsModel??this.viewSampleRequisitionsModel,
      itemModel: itemModel??this.itemModel,
      selectedConductType:selectedConductType??this.selectedConductType,
      currentPage: currentPage??this.currentPage,
      isLoadingMore: isLoadingMore??this.isLoadingMore,
      customerInfoModel: customerInfoModel ?? this.customerInfoModel,
      unvCustomerModel: unvCustomerModel ?? this.unvCustomerModel,
      stateModel: stateModel ?? this.stateModel,
      districtModel: districtModel ?? this.districtModel,
      selectedExistingCustomer: selectedExistingCustomer ?? this.selectedExistingCustomer,
      unvName: unvName ?? this.unvName,
      verifiedCustomerLocation: verifiedCustomerLocation ?? this.verifiedCustomerLocation  
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final addTrialPlanProvider  =StateNotifierProvider<AddTrialPlanNotifier,AddTrialPlanState>((ref)=>AddTrialPlanNotifier());
