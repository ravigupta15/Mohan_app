
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

String searchText = '';
List schemeType = ["All","Spot"];
String filterSchemeType = '';


updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }
resetValues(){
  searchText = '';
  resetPageCount();
  resetFilter();
}

  resetFilter(){
    filterSchemeType = '';
 }



updateFilterValues({required String type}){
  filterSchemeType = type;
  resetPageCount();
}


onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
     resetPageCount();
    callApiFunction();
  }
  else{
    searchText = val;
     resetPageCount();
    callApiFunction();
  }
}



resetPageCount(){
  state = state.copyWith(currentPage: 1);
}
increasePageCount(){
  state = state.copyWith(currentPage: state.currentPage+1);}



callApiFunction({bool isLoadMore =false, bool isShowLoading = true})async{
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
   
  state = state.copyWith(schemeModel: null);
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.schemeListUrl}?limit=10&current_page=${state.currentPage}&search_text=$searchText&scheme_type=$filterSchemeType", method: ApiMethod.get.name);
  updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
  if (response != null) {
      var newModel = SchemeModel.fromJson(response.data);
      if (isLoadMore) {
         List<SchemeRecord> updatedData = [
            ...(state.schemeModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.schemeModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(schemeModel: newModel);
      }
      if (newModel.data!.isEmpty || newModel.data!.length < state.currentPage) {
      } else {
        if(isLoadMore){
          increasePageCount();
        }
      }
      }
} 

}

