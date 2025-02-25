
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/schemes_management/model/scheme_model.dart';
import 'package:mohan_impex/features/home_module/schemes_management/riverpod/schemes_state.dart';

class SchemesNotifier extends StateNotifier<SchemesState> {
  SchemesNotifier() : super(SchemesState(isLoading: false));
updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}



callApiFunction(BuildContext context)async{
  updateLoading(true);
  state = state.copyWith(schemeModel: null);
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.schemeListUrl}?limit=10&offset=0", method: ApiMethod.get.name);
   updateLoading(false);
   if(response!=null){
    state = state.copyWith(schemeModel: SchemeModel.fromJson(response.data));
   }
 } 

}

