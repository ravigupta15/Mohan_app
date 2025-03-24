
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/price_list/model/price_list_model.dart';
import 'package:mohan_impex/features/home_module/price_list/riverpod/price_list_state.dart';

class PriceListNotifier extends StateNotifier<PriceListState> {
  PriceListNotifier() : super(PriceListState(isLoading: false));
updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}


String filerValue = '';
String searchText = '';

resetValues(){
  state =state.copyWith(currentPage: 1,isLoading: false,isLoadingMore: false,priceListModel: null);
}

 resetFilter(){
  filerValue='';
  resetPageCount();
 }


updateFilterValues({required String type}){
  filerValue =  type=='All'?'':type;
  state = state.copyWith(currentPage: 1);
}

onChangedSearch(BuildContext context, {required String val}){
  if(val.isEmpty){
    searchText = '';
    resetPageCount();
    priceApiFunction(isShowLoading: false);
  }
  else{
    searchText = val;
    resetPageCount();
    priceApiFunction(isShowLoading: false);
  }
}


updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }


resetPageCount(){
  state = state.copyWith(currentPage: 1);
}
increasePageCount(){
  print('object');
  state = state.copyWith(currentPage: state.currentPage+1);}




priceApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
  // ShowLoader.loader(context);
  // state = state.copyWith(priceListModel: null);
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
  
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.priceListUrl}?limit=50&current_page=${state.currentPage}&search_text=$searchText&item_category=$filerValue', method: ApiMethod.get.name);
    updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
    
   if (response != null) {
      var newModel = PriceListModel.fromJson(response.data);
      if (isLoadMore) {
         List<Records> updatedData = [
            ...(state.priceListModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.priceListModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(priceListModel: newModel);
      }
      // if (newModel.data!.isEmpty || newModel.data!.length < state.currentPage) {
      // } else {
      //   // if(isLoadMore){
      //     increasePageCount();
      //   // }
      // }
      }
 
 } 

}

