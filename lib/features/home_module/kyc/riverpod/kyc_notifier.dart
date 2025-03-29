
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/kyc/model/kyc_model.dart';
import 'package:mohan_impex/features/home_module/kyc/model/view_kyc_model.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_state.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';

class KycNotifier extends StateNotifier<KycState> {
  KycNotifier() : super(KycState(isLoading: false,tabBarIndex: 0,));
updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}
String searchText = '';
String selectedTabbar = "KYC Completed";
String customerTypeFilter = '';
String businessTypeFilter = '';
String segmentFilter = '';
String customerCategoryFilter = '';

final searchController = TextEditingController();
resetValues(){
  state = state.copyWith(isLoading: false,tabBarIndex: 0);
  searchText = '';
  selectedTabbar = "KYC Completed";
  searchController.clear();
  resetFilter();
  resetPageCount();
  searchText ='';
}

String businessTypeTitle(index){
  switch (index) {
    case 0:
      return "Registered";
    case 1:
    return "UnRegistered"; 
    default:
    return "";
  }
}



updateFilterValues({required String customerType, required String businessType, required String segmentType, required String categoryType}){
   customerTypeFilter = customerType;
   businessTypeFilter = businessType;
   segmentFilter = segmentType;
   customerCategoryFilter = categoryType;
}



  resetFilter(){
  customerTypeFilter = '';
 businessTypeFilter = '';
 segmentFilter = '';
 customerCategoryFilter = '';
 }

onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
    resetPageCount();
    kyclistApiFunction();
  }
  else{
    searchText = val;
    resetPageCount();
    kyclistApiFunction();
  }
}

 updateTabBarIndex(val){
    selectedTabbar = val==0?"KYC Completed":"KYC Pending";
    if(state.tabBarIndex !=val){
      resetFilter();
      searchController.clear();
      resetPageCount();
      searchText ='';
      kyclistApiFunction();
    }
    state = state.copyWith(tabBarIndex: val);
    // state = state.copyWith(currentPage: 1);
  }
updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }



resetPageCount(){
  state = state.copyWith(currentPage: 1);
}
increasePageCount(){
  state = state.copyWith(currentPage: state.currentPage+1);}


kyclistApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
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
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.kycList}?tab=$selectedTabbar&limit=10&current_page=${state.currentPage}&customer_type=$customerTypeFilter&business_type=$businessTypeFilter&segment=$segmentFilter&customer_category=$customerCategoryFilter&search_text=$searchText", method: ApiMethod.get.name);
  updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
  if (response != null) {
      var newModel = KycModel.fromJson(response.data);
      if (isLoadMore) {
         List<KycRecords> updatedData = [
            ...(state.kycModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.kycModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(kycModel: newModel);
      }
      // if (newModel.data!.isEmpty || newModel.data!.length < state.currentPage) {
      // } else {
      //   // if(isLoadMore){
      //     increasePageCount();
      //   // }
      // }
      }
 } 

  viewKycpiFunction(BuildContext context,{required String id})async{
    state = state.copyWith(viewKycModel: null);
     ShowLoader.loader(context);
    final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.viewKycUrl}?name=$id", method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
      state = state.copyWith(viewKycModel: ViewKycModel.fromJson(response.data));

    }
  }

}

