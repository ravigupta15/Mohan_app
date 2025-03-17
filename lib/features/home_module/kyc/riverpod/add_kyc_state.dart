import 'package:mohan_impex/features/home_module/kyc/model/segment_model.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/add_kyc_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class AddKycState {
  final bool isLoading;
  final bool isSameBillingAddress;
  final int selectedBusinessType;
  List cdImageList;
  List clImageList;
  StateModel?stateModel;
  StateModel?billingStateModel;
  StateModel?shippingStateModel;
  DistrictModel? districtModel;
  DistrictModel? shippingDistrictModel;
  DistrictModel? billingDistrictModel;
  SegmentModel? segmentModel;
  int addKycTabBarIndex;
  AddKycState({required this.isLoading,required this.isSameBillingAddress, required this.selectedBusinessType,  required this.cdImageList,required this.clImageList,
   this.districtModel, this.shippingDistrictModel, this.stateModel,this.segmentModel,this.shippingStateModel,
  this.billingDistrictModel,this.billingStateModel,this.addKycTabBarIndex =0
  });

  AddKycState copyWith({  bool? isLoading, bool?isSameBillingAddress, int?selectedBusinessType,List?cdImageList, List? clImageList, 
  StateModel?stateModel,DistrictModel? districtModel, SegmentModel? segmentModel,DistrictModel? billingDistrictModel,
  StateModel?billingStateModel, int? addKycTabBarIndex, DistrictModel? shippingDistrictModel, StateModel?shippingStateModel
  }) {
    return AddKycState(
      isLoading: isLoading??this.isLoading,
      isSameBillingAddress: isSameBillingAddress??this.isSameBillingAddress,
      selectedBusinessType: selectedBusinessType??this.selectedBusinessType,
      cdImageList: cdImageList??this.cdImageList,
      clImageList:clImageList??this.clImageList,
      districtModel: districtModel?? this.districtModel,
      stateModel: stateModel?? this.stateModel,
      segmentModel: segmentModel??this.segmentModel,
      billingDistrictModel: billingDistrictModel??this.billingDistrictModel,
      billingStateModel: billingStateModel?? this.billingStateModel,
      addKycTabBarIndex: addKycTabBarIndex??this.addKycTabBarIndex,
      shippingDistrictModel: shippingDistrictModel??this.shippingDistrictModel,
      shippingStateModel: shippingStateModel??this.shippingStateModel
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final addKycProvider  =StateNotifierProvider<AddKycNotifier,AddKycState>((ref)=>AddKycNotifier());
