import 'package:mohan_impex/features/home_module/custom_visit/model/customer_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/view_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/riverpod/customer_visit_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class CustomerVisitState {
  final bool isLoading;
  CustomerVisitModel? customerVisitModel;
  ViewVisitModel? visitModel;
  int currentPage;
  bool isLoadingMore;
  int tabBarIndex;
  CustomerVisitState({required this.isLoading, this.customerVisitModel, this.currentPage=1,this.isLoadingMore=false,
  this.tabBarIndex = 0,this.visitModel
  });

  CustomerVisitState copyWith({  bool? isLoading, CustomerVisitModel? customerVisitModel, int?currentPage,
  bool? isLoadingMore, int?tabBarIndex,ViewVisitModel? visitModel
  }) {
    return CustomerVisitState(
      isLoading: isLoading??this.isLoading,
      customerVisitModel: customerVisitModel??this.customerVisitModel,
      currentPage: currentPage??this.currentPage,
      isLoadingMore: isLoadingMore??this.isLoadingMore,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      visitModel: visitModel?? this.visitModel

    );
  }
}



final customVisitProvider  =StateNotifierProvider<CustomerVisitNotifier,CustomerVisitState>((ref)=>CustomerVisitNotifier());
