import 'package:mohan_impex/features/home_module/my_customers/model/ledger_model.dart';
import 'package:mohan_impex/features/home_module/my_customers/model/my_customer_modle.dart';
import 'package:mohan_impex/features/home_module/my_customers/model/view_my_custom_model.dart';
import 'package:mohan_impex/features/home_module/my_customers/riverpod/my_customer_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class MyCustomerState {
  final bool isLoading;
  int currentPage;
  bool isLoadingMore;
  int tabBarIndex;
  MyCustomerModel? myCustomerModel;
  ViewMyCustomerModel? viewMyCustomerModel;
  StateModel?stateModel;
  DistrictModel? districtModel;
  LedgerModel? ledgerModel;
  int ledgerPageIndex;
  MyCustomerState({required this.isLoading, this.viewMyCustomerModel, this.currentPage=1,this.isLoadingMore=false,
  this.tabBarIndex = 0, this.myCustomerModel, this.stateModel,this.districtModel, this.ledgerModel, this.ledgerPageIndex =1
  });

  MyCustomerState copyWith({  bool? isLoading,  int?currentPage,
  bool? isLoadingMore, int?tabBarIndex,MyCustomerModel? myCustomerModel,ViewMyCustomerModel? viewMyCustomerModel,
  StateModel?stateModel,
  DistrictModel? districtModel,LedgerModel? ledgerModel, int? ledgerPageIndex,
  }) {
    return MyCustomerState(
      isLoading: isLoading??this.isLoading,
      currentPage: currentPage??this.currentPage,
      isLoadingMore: isLoadingMore??this.isLoadingMore,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      myCustomerModel: myCustomerModel??this.myCustomerModel,
      viewMyCustomerModel: viewMyCustomerModel??this.viewMyCustomerModel,
      stateModel: stateModel??this.stateModel,
      districtModel: districtModel??this.districtModel,
      ledgerModel: ledgerModel ?? this.ledgerModel,
      ledgerPageIndex: ledgerPageIndex ?? this.ledgerPageIndex
    );
  }
}



final myCustomerProvider  =StateNotifierProvider<MyCustomerNotifier,MyCustomerState>((ref)=>MyCustomerNotifier());
