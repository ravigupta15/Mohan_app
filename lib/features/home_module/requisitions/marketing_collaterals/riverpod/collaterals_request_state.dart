import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/collaterals_request_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/material_items_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/view_collaterals_request_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/riverpod/collaterals_request_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class CollateralsRequestState {
  final bool isLoading;
  final bool isLoadingMore;
  int tabBarIndex;
  final int page;
  CollateralsRequestModel? collateralsReqestModel;
  MaterialItemsModel? materialItemsModel;
  ViewCollateralsReqestModel? viewCollateralsReqestModel;
  CollateralsRequestState({required this.isLoading, this.page = 1, this.isLoadingMore=false, this.collateralsReqestModel, required this.tabBarIndex,this.viewCollateralsReqestModel, this.materialItemsModel});

  CollateralsRequestState copyWith({  bool? isLoading,
  bool? isLoadingMore,
  int? page,
  int?tabBarIndex, CollateralsRequestModel? collateralsReqestModel,
  ViewCollateralsReqestModel? viewCollateralsReqestModel,MaterialItemsModel? materialItemsModel
  }) {
    return CollateralsRequestState(
      isLoading: isLoading??this.isLoading,
      isLoadingMore: isLoadingMore??this.isLoadingMore,
      page: page?? this.page,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      collateralsReqestModel: collateralsReqestModel??this.collateralsReqestModel,
      viewCollateralsReqestModel: viewCollateralsReqestModel??this.viewCollateralsReqestModel,
      materialItemsModel: materialItemsModel??this.materialItemsModel
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final collateralRequestProvider  =StateNotifierProvider<CollateralsRequestNotifier,CollateralsRequestState>((ref)=>CollateralsRequestNotifier());
