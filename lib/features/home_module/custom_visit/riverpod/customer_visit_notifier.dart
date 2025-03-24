// Define a StateNotifier to manage the state
import 'package:flutter/cupertino.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/customer_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/view_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/riverpod/customer_visit_state.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:riverpod/riverpod.dart';


class CustomerVisitNotifier extends StateNotifier<CustomerVisitState> {
  CustomerVisitNotifier() : super(CustomerVisitState(isLoading: false));
 
 updateLoading(bool isLoading){
  state = state.copyWith(isLoading: isLoading);
}

  List customerTypeList = ["New", "Existing"];
  List visitTypeList = ['Primary', 'Secondary'];
  List kycStatusList = ["Pending", "Completed"];
  List productTrialList = ["Yes","No"];

  String customerTypeFilter = '';
  String visitTypFilter = '';
  String kycStatusFilter = '';
  String hasProductTrialFilter = '';
  String searchText = '';


String selectedTabbar = "Submitted";

resetValues(){
  state = state.copyWith(isLoadingMore: false,tabBarIndex: 0);
  resetPageCount();
  resetFilter();
}

  resetFilter(){
  customerTypeFilter = '';
 visitTypFilter = '';
 kycStatusFilter = '';
 hasProductTrialFilter = '';
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
      resetPageCount();
      customVisitApiFunction();
    }
    state = state.copyWith(tabBarIndex: val);
    // state = state.copyWith(currentPage: 1);
    selectedTabbar = val==0?"Submitted":"Draft";
    
  }


increasePageCount(){
  state = state.copyWith(currentPage: state.currentPage+1);
  print("dfgh....${state.currentPage}");
  }


updateFilterValues({required String customerType, required String visitType, required String kycStatus, required productTrial}){
   customerTypeFilter = customerType;
 visitTypFilter = visitType;
 kycStatusFilter = kycStatus;
 hasProductTrialFilter = productTrial == "Yes"?'1':productTrial=='No'?'0':'';
}

onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
     resetPageCount();
     customVisitApiFunction();
  }
  else{
    searchText = val;
     resetPageCount();
    customVisitApiFunction();
  }
}
customVisitApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
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
    if(isLoadMore){
    increasePageCount();
  }
   
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.customVisitListUrl}?tab=$selectedTabbar&limit=10&current_page=${state.currentPage}&search_text=$searchText&customer_type=$customerTypeFilter&visit_type=$visitTypFilter&kyc_status=$kycStatusFilter&has_trial_plan=$hasProductTrialFilter", method: ApiMethod.get.name);
 updateLoading(false);
   updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
  if (response != null) {
      var newModel = CustomerVisitModel.fromJson(response.data);
      if (isLoadMore) {
         List<CustomerVisitRecords> updatedData = [
            ...(state.customerVisitModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.customerVisitModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(customerVisitModel: newModel);
      }
      // if (newModel.data!.isEmpty || newModel.data!.length < state.currentPage) {
      // } else {
      //   // if(isLoadMore){
      //     increasePageCount();
      //   // }
      // }
      }
  
 } 

 viewCustomerVisitApiFunction(BuildContext context, String id)async{
  state = state.copyWith(visitModel: ViewVisitModel.fromJson({}));
  ShowLoader.loader(context);
  final resonse = await ApiService().makeRequest(apiUrl: "${ApiUrls.viewCustomerVisitUrl}?name=$id", method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(resonse!=null){
  state = state.copyWith(visitModel: ViewVisitModel.fromJson(resonse.data));
  }
  else{
    state = state.copyWith(visitModel:null);
  }
 }
}
