
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/product_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/model/trial_plan_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/model/view_trial_plan_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_state.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';

class TrialPlanNotifier extends StateNotifier<TrialPlanState> {
  TrialPlanNotifier() : super(TrialPlanState(isLoading: false,tabBarIndex: 0));
  updateLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }
  final searchController = TextEditingController();
String? selectedStateValue;
String? selectedDistrictValue;

String searchText = '';
String fromDateFilter = '';
String toDateFilter = '';
String visitTypeFilter = '';
String trailTypeFilter ='';
String conductByTypeFilter ='';
String trialLocTypeFilter ='';

List<Items> selectedItem = [];
List<ProductItems> selectedProduct = [];

  final formKey = GlobalKey<FormState>();
  List contactNumberList = [];

String customer = '';
String verifiedCustomerLocation = '';
  String selectedTabbar = "Approved";

  resetFilter(){
   fromDateFilter = '';
 toDateFilter = '';
 visitTypeFilter = '';
 trailTypeFilter ='';
 conductByTypeFilter ='';
 trialLocTypeFilter ='';
 }


resetValues(){
 state = state.copyWith(tabBarIndex: 0,currentPage: 1,selectedConductType: 0,);
 searchText = '';
 searchController.clear();
}

updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }

resetPageCount(){
  state = state.copyWith(currentPage: 1);
}

  updateTabBarIndex(val){
    selectedTabbar = val==0?"Approved":"Pending";
    if(state.tabBarIndex !=val){
      resetFilter();
      resetPageCount();
      searchText = '';
      searchController.clear();
      trialPlanListApiFunction();
    }
    state = state.copyWith(tabBarIndex: val);
    // state = state.copyWith(currentPage: 1);
    selectedTabbar = val==0?"Approved":"Pending";
    
  }
increasePageCount(){
  state = state.copyWith(currentPage: state.currentPage+1);}


updateFilterValues({required String visitType, required String trialType, required String fromDate, required toDate, required String conductType,required String trialLocType}){
    fromDateFilter = fromDate;
 toDateFilter = toDate;
 visitTypeFilter = visitType;
 trailTypeFilter = trialType;
 conductByTypeFilter =conductType;
 trialLocTypeFilter =trialLocType;
}

onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
     resetPageCount();
     trialPlanListApiFunction();
  }
  else{
    print('sdfd..$val');
    searchText = val;
     resetPageCount();
    trialPlanListApiFunction();
  }
}
  trialPlanListApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
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
   
    updateLoading(true);
    final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.trialPlanUrl}?tab=$selectedTabbar&limit=10&current_page=${state.currentPage}&search_text=$searchText&conduct_by=$conductByTypeFilter&trial_loc=$trialLocTypeFilter&trial_type=$trailTypeFilter&customer_level=$visitTypeFilter&from_date=$fromDateFilter&to_date=$toDateFilter", method: ApiMethod.get.name);
  updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
  if (response != null) {
      var newModel = TrialPlanModel.fromJson(response.data);
      if (isLoadMore) {
         List<TrialRecords> updatedData = [
            ...(state.trialPlanModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.trialPlanModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(trialPlanModel: newModel);
      }
      // if (newModel.data!.isEmpty || newModel.data!.length < state.currentPage) {
      // } else {
      //   // if(isLoadMore){
      //     increasePageCount();
      //   // }
      // }
      }
  }

  viewTrialPlanApiFunction(BuildContext context,{required String id})async{
    ShowLoader.loader(context);
    state = state.copyWith(viewTrialPlanModel: null);
    final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.viewTrailPlanUrl}?name=$id", method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
      state = state.copyWith(viewTrialPlanModel: ViewTrialPlanModel.fromJson(response.data));

    }
  }



}
