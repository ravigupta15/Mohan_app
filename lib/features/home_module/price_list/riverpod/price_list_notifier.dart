
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/price_list/model/price_list_model.dart';
import 'package:mohan_impex/features/home_module/price_list/riverpod/price_list_state.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';

class PriceListNotifier extends StateNotifier<PriceListState> {
  PriceListNotifier() : super(PriceListState(isLoading: false));
updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}


String filerValue = '';
String searchText = '';

 resetFilter(){
  filerValue='';
 }


updateFilterValues({required String type}){
  filerValue =  type=='All'?'':type;
}

onChangedSearch(BuildContext context, {required String val}){
  if(val.isEmpty){
    searchText = '';
    priceApiFunction(context);
  }
  else{
    searchText = val;
    priceApiFunction(context);
  }
}




priceApiFunction(BuildContext context)async{
  ShowLoader.loader(context);
  state = state.copyWith(priceListModel: null);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.priceListUrl}?search_text=$searchText&item_category=$filerValue', method: ApiMethod.get.name);
   ShowLoader.hideLoader();
   if(response!=null){
    state = state.copyWith(priceListModel: PriceListModel.fromJson(response.data));
   }
 } 

}

