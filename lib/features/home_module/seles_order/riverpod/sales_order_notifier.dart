// Define a StateNotifier to manage the state
import 'package:flutter/cupertino.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/sales_order_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/view_sales_order_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/sales_order_state.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:riverpod/riverpod.dart';


class SalesOrderNotifier extends StateNotifier<SalesOrderState> {
  SalesOrderNotifier() : super(SalesOrderState(isLoading: false));
 
 updateLoading(bool isLoading){
  state = state.copyWith(isLoading: isLoading);
}
final searchController = TextEditingController();

  List customerTypeList = ["New", "Existing"];
  List visitTypeList = ['Primary', 'Secondary'];
  List kycStatusList = ["Pending", "Completed"];
  List productTrialList = ["Yes","No"];

  String fromDateFilter = '';
  String toDateFilter = '';
  String searchText = '';


String selectedTabbar = "Submitted";


resetValues(){
  searchController.clear();
  selectedTabbar = "Submitted";
  state = state.copyWith(tabBarIndex: 0);
  searchText  = '';
  resetFilter();
  resetPageCount();
}

  resetFilter(){
  fromDateFilter  = '';
  toDateFilter = '';
 }



updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }

resetPageCount(){
  state = state.copyWith(currentPage: 1);
}

  updateTabBarIndex(val){
    selectedTabbar = val==0?"Submitted":"Draft";
    if(state.tabBarIndex !=val){
      resetFilter();
      searchController.clear();
      searchText = '';
      salesOrderApiFunction();
    }
    state = state.copyWith(tabBarIndex: val);
    state = state.copyWith(currentPage: 1);
    selectedTabbar = val==0?"Submitted":"Draft";
    
  }


increasePageCount(){
  state = state.copyWith(currentPage: state.currentPage+1);}


updateFilterValues({required String fromDate, required String toDate,}){
   fromDateFilter = fromDate;
 toDateFilter = toDate;
}

onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
     resetPageCount();
     salesOrderApiFunction();
  }
  else{
    searchText = val;
     resetPageCount();
    salesOrderApiFunction();
  }
}
salesOrderApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
 if (isLoadMore) {
      updateLoadingMore(true);
    }
     else {
      if(isShowLoading){
        updateLoading(isShowLoading);
      }
      else{
        state = state.copyWith(currentPage: 1);
      }
    }
   
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.salesOrderListUrl}?tab=$selectedTabbar&limit=10&current_page=${state.currentPage}&search_text=$searchText&from_date=$fromDateFilter&to_date=$toDateFilter", method: ApiMethod.get.name);
 updateLoading(false);
   updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
  if (response != null) {
      var newModel = SalesOrderModel.fromJson(response.data);
      if (isLoadMore) {
         List<SalesRecords> updatedData = [
            ...(state.salesOrderModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.salesOrderModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(salesOrderModel: newModel);
      }
      if (newModel.data!.isEmpty || newModel.data!.length < state.currentPage) {
      } else {
        if(isLoadMore){
          increasePageCount();
        }
      }
      }
  
 } 

 viewSalesApiFunction(BuildContext context, String id)async{
  state = state.copyWith(viewSalesOrderModel: null);
  ShowLoader.loader(context);
  final resonse = await ApiService().makeRequest(apiUrl: "${ApiUrls.viewSalesOrderUrl}?name=$id", method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(resonse!=null){
  state = state.copyWith(viewSalesOrderModel: ViewSalesOrderModel.fromJson(resonse.data));
  }
  else{
    state = state.copyWith(viewSalesOrderModel:null);
  }
 }
}
