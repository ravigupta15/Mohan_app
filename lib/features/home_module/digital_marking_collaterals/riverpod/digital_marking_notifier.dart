
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/digital_marking_collaterals/model/digital_markting_model.dart';
import 'package:mohan_impex/features/home_module/digital_marking_collaterals/riverpod/digital_marking_state.dart';
import 'package:mohan_impex/features/home_module/price_list/model/price_list_model.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';

class DigitalMarkingNotifier extends StateNotifier<DigitalMarkingState> {
  DigitalMarkingNotifier() : super(DigitalMarkingState(isLoading: false));
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

onChangedSearch(val){
  if(val.isEmpty){
    searchText = '';
    digitalMarkingApiFunction();
  }
  else{
    searchText = val;
    digitalMarkingApiFunction();
  }
}




digitalMarkingApiFunction()async{
  updateLoading(true);
  state = state.copyWith(digitalMarkingModel: null);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.digitalMarkingCollateralsUrl}?search_text=$searchText', method: ApiMethod.get.name);
  updateLoading(false);
   if(response!=null){
    state = state.copyWith(digitalMarkingModel: DigitalMarkingModel.fromJson(response.data));
   }
 } 

}

