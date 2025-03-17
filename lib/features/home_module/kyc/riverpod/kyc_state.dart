import 'package:mohan_impex/features/home_module/kyc/model/kyc_model.dart';
import 'package:mohan_impex/features/home_module/kyc/model/view_kyc_model.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class KycState {
  final bool isLoading;
  final int tabBarIndex;
  KycModel? kycModel;
  int currentPage;
  bool isLoadingMore;
  ViewKycModel? viewKycModel;
  KycState({required this.isLoading, this.kycModel, required this.tabBarIndex,
  this.currentPage = 1, this.isLoadingMore = false, this.viewKycModel});

  KycState copyWith({  
    bool? isLoading, 
    int? tabBarIndex,
    KycModel? kycModel,
     int? currentPage,
      bool? isLoadingMore,
      ViewKycModel? viewKycModel,
  }) {
    return KycState(
      isLoading: isLoading??this.isLoading,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      kycModel: kycModel??this.kycModel,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore?? this.isLoadingMore,
      viewKycModel: viewKycModel?? this.viewKycModel
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final kycProvider  =StateNotifierProvider<KycNotifier,KycState>((ref)=>KycNotifier());
