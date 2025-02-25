import 'package:mohan_impex/features/home_module/custom_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/collaterals_request_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/model/view_sample_requisitions_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/riverpod/sample_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class SampleState {
  final bool isLoading;
  int tabBarIndex;
  CollateralsRequestModel? collateralsReqestModel;
  ViewSampleRequisitionsModel? viewSampleRequisitionsModel;
  ItemModel? itemModel;
  int page;
  bool isLoadingMore;
  SampleState({required this.isLoading, this.collateralsReqestModel, required this.tabBarIndex,this.viewSampleRequisitionsModel, this.itemModel,this.page=1,this.isLoadingMore=false});

  SampleState copyWith({  bool? isLoading,int?tabBarIndex, CollateralsRequestModel? collateralsReqestModel,
  ViewSampleRequisitionsModel? viewSampleRequisitionsModel,ItemModel? itemModel, int?page,bool?isLoadingMore
  }) {
    return SampleState(
      isLoading: isLoading??this.isLoading,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      collateralsReqestModel: collateralsReqestModel??this.collateralsReqestModel,
      viewSampleRequisitionsModel: viewSampleRequisitionsModel??this.viewSampleRequisitionsModel,
      itemModel: itemModel??this.itemModel,
      page: page??this.page,
      isLoadingMore:isLoadingMore??this.isLoadingMore
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final sampleProvider  =StateNotifierProvider<SampleNotifier,SampleState>((ref)=>SampleNotifier());
