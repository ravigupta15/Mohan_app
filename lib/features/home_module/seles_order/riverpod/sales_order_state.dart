import 'package:mohan_impex/features/home_module/seles_order/model/sales_order_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/view_sales_order_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/sales_order_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class SalesOrderState {
  final bool isLoading;
  SalesOrderModel? salesOrderModel;
  ViewSalesOrderModel? viewSalesOrderModel;
  int currentPage;
  bool isLoadingMore;
  int tabBarIndex;
  SalesOrderState({required this.isLoading, this.salesOrderModel, this.currentPage=1,this.isLoadingMore=false,
  this.tabBarIndex = 0,this.viewSalesOrderModel
  });

  SalesOrderState copyWith({  bool? isLoading, SalesOrderModel? salesOrderModel, int?currentPage,
  bool? isLoadingMore, int?tabBarIndex,ViewSalesOrderModel? viewSalesOrderModel
  }) {
    return SalesOrderState(
      isLoading: isLoading??this.isLoading,
      salesOrderModel: salesOrderModel??this.salesOrderModel,
      currentPage: currentPage??this.currentPage,
      isLoadingMore: isLoadingMore??this.isLoadingMore,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      viewSalesOrderModel: viewSalesOrderModel?? this.viewSalesOrderModel
    );
  }
}

final salesOrderProvider  =StateNotifierProvider<SalesOrderNotifier,SalesOrderState>((ref)=>SalesOrderNotifier());
