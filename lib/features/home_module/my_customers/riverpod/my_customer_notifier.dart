// Define a StateNotifier to manage the state
import 'package:flutter/cupertino.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/my_customers/model/ledger_model.dart';
import 'package:mohan_impex/features/home_module/my_customers/model/my_customer_modle.dart';
import 'package:mohan_impex/features/home_module/my_customers/model/view_my_custom_model.dart';
import 'package:mohan_impex/features/home_module/my_customers/riverpod/my_customer_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:riverpod/riverpod.dart';


class MyCustomerNotifier extends StateNotifier<MyCustomerState> {
  MyCustomerNotifier() : super(MyCustomerState(isLoading: false));
 
 updateLoading(bool isLoading){
  state = state.copyWith(isLoading: isLoading);
}

List businessTypeList = ["Registered", "UnRegistered"];
List biilingList = ["Yes","No"];
String stateStringFilter ='';
String districtStringFilter = '';
String fromDateFilter = '';
String toDateFilter = '';
String businessTypeFilter = '';
String zeroBillingFilter ='';


String searchText = '';

String ledgerSearchText = '';
String ledgerFromDate = '';
String ledgerToDate = '';


String selectedTabbar = "Submitted";


  resetFilter(){
   stateStringFilter ='';
 districtStringFilter = '';
 fromDateFilter = '';
 toDateFilter = '';
  businessTypeFilter = '';
 zeroBillingFilter ='';
 }

updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }

resetLedger(){
  state = state.copyWith(ledgerPageIndex: 1, isLoadingMore: false);
  ledgerSearchText = '';
  ledgerFromDate = '';
  ledgerToDate  = '';
}

resetPageCount(){
  state = state.copyWith(currentPage: 1);
}

resetLegerPageCount(){
  state = state.copyWith(ledgerPageIndex: 1);
}

ledgerPageCount(){
  state = state.copyWith(ledgerPageIndex: 1);
}


increaseLedgerPageCount(){
  state = state.copyWith(ledgerPageIndex: state.ledgerPageIndex+1);}

  updateTabBarIndex(val){
    selectedTabbar = val==0?"Submitted":"Draft";
    if(state.tabBarIndex !=val){
      resetFilter();
      customerApiFunction();
    }
    state = state.copyWith(tabBarIndex: val);
    state = state.copyWith(currentPage: 1);
    selectedTabbar = val==0?"Submitted":"Draft";
    
  }


increasePageCount(){
  state = state.copyWith(currentPage: state.currentPage+1);}


updateFilterValues({required String stateType, required String districtType, required String fromDate, required toDate, required String businessType,required String zeroBilling}){
   stateStringFilter =stateType;
 districtStringFilter = districtType;
 fromDateFilter = fromDate;
 toDateFilter = toDate;
 businessTypeFilter = businessType;
 zeroBillingFilter = zeroBilling.toLowerCase() == "yes"?'1': zeroBilling.toLowerCase() == 'no'? '0':
 '';
}

updateLedgerFilterValues({required String fromDate, required String toDate,}){
  ledgerFromDate = fromDate;
  ledgerToDate = toDate;
}

onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
     resetPageCount();
     customerApiFunction();
  }
  else{
    print('sdfd..$val');
    searchText = val;
     resetPageCount();
    customerApiFunction();
  }
}


onChangedLedgerSearch(String val, String id, BuildContext context){
  if(val.isEmpty){
    ledgerSearchText = '';
     resetLegerPageCount();
     ledgerApiFunction(context, id);
  }
  else{
    print('sdfd..$val');
    ledgerSearchText = val;
     resetLegerPageCount();
    ledgerApiFunction(context, id);
  }
}
customerApiFunction({bool isLoadMore = false,bool isShowLoading = true})async{
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
   
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.myCustomerListUrl}?search_text=$searchText&limit=10&current_page=${state.currentPage}&district=$districtStringFilter&state=$stateStringFilter&business_type=$businessTypeFilter&zero_billing=$zeroBillingFilter&from_date=$fromDateFilter&to_date=$toDateFilter", method: ApiMethod.get.name);
 updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
  if (response != null) {
      var newModel = MyCustomerModel.fromJson(response.data);
      if (isLoadMore) {
         List<MyCustomerRecords> updatedData = [
            ...(state.myCustomerModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.myCustomerModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(myCustomerModel: newModel);
      }
      if (newModel.data!.isEmpty || newModel.data!.length < state.currentPage) {
      } else {
        if(isLoadMore){
          increasePageCount();
        }
      }
      }
  
 } 

 viewCustomerApiFunction(BuildContext context, String id)async{
  state = state.copyWith(viewMyCustomerModel: null);
  ShowLoader.loader(context);
  final resonse = await ApiService().makeRequest(apiUrl: "${ApiUrls.viewMyCustomerUrl}?name=$id", method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(resonse!=null){
  state = state.copyWith(viewMyCustomerModel: ViewMyCustomerModel.fromJson(resonse.data));
  }
  else{
    state = state.copyWith(viewMyCustomerModel:null);
  }
 }

 ledgerApiFunction(BuildContext context, String id, {bool isLoadMore = false,bool isShowLoading = true})async{
  ShowLoader.loader(context);
  if (isLoadMore) {
      updateLoadingMore(true);
    }
     else {
      if(isShowLoading){
        updateLoading(isShowLoading);
      }
      else{
        state = state.copyWith(ledgerPageIndex: 1);
      }
    }
   
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.ledgerUrl}?name=$id&search_text=$ledgerSearchText&from_date=$ledgerFromDate&to_date=$ledgerToDate&limit=100&current_page=${state.ledgerPageIndex}", method: ApiMethod.get.name);
  ShowLoader.hideLoader();
 updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
  if (response != null) {
      var newModel = LedgerModel.fromJson(response.data);
      if (isLoadMore) {
         List<LedgerRecords> updatedData = [
            ...(state.ledgerModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.ledgerModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(ledgerModel: newModel);
      }
      if (newModel.data!.isEmpty || newModel.data!.length < state.ledgerPageIndex) {
      } else {
        if(isLoadMore){
          increaseLedgerPageCount();
        }
      }
      }
  }


  stateApiFunction({ String searchText =''})async{
  state = state.copyWith(stateModel: null);
    final response =await ApiService().makeRequest(apiUrl: '${ApiUrls.stateUrl}/?filters=[["state", "like", "%$searchText%"]]&limit=100', method: ApiMethod.get.name);
    if(response!=null){
      var model =  StateModel.fromJson(response.data);
    state = state.copyWith(stateModel:model);
    }
  }

 Future districtApiFunction(BuildContext context,{required String stateText})async{
    state = state.copyWith(districtModel: null);
  ShowLoader.loader(context);
    final response =await ApiService().makeRequest(apiUrl: '${ApiUrls.districtUrl}/?fields=["district", "state"]&filters=[["district", "like", "%%"], ["state", "=", "$stateText"]]&limit=100', method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
     state = state.copyWith(districtModel: DistrictModel.fromJson(response.data));
     return response.data;
    }
    
  }

}
