import 'package:mohan_impex/features/home_module/kyc/model/kyc_model.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class KycState {
  final bool isLoading;
  final bool isSameBillingAddress;
  final int selectedBusinessType;
  final int tabBarIndex;
  KYCModel? kycModel;
  List cdImageList;
  List clImageList;
  KycState({required this.isLoading, this.kycModel,required this.isSameBillingAddress, required this.selectedBusinessType, required this.tabBarIndex, required this.cdImageList,required this.clImageList});

  KycState copyWith({  bool? isLoading, bool?isSameBillingAddress, int?selectedBusinessType, int? tabBarIndex,KYCModel? kycModel,List?cdImageList, List? clImageList}) {
    return KycState(
      isLoading: isLoading??this.isLoading,
      isSameBillingAddress: isSameBillingAddress??this.isSameBillingAddress,
      selectedBusinessType: selectedBusinessType??this.selectedBusinessType,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      kycModel: kycModel??this.kycModel,
      cdImageList: cdImageList??this.cdImageList,
      clImageList:clImageList??this.clImageList 
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final kycProvider  =StateNotifierProvider<KycNotifier,KycState>((ref)=>KycNotifier());
