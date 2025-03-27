
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/digital_marking_collaterals/model/digital_markting_model.dart';
import 'package:mohan_impex/features/home_module/digital_marking_collaterals/riverpod/digital_marking_state.dart';

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

resetValues(){
  searchText = '';
  filerValue = '';
  resetPageCount();
  resetFilter();
  state = state.copyWith(isLoadingMore: false);
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



updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }

resetPageCount(){
  state = state.copyWith(currentPage: 1);
}

increasePageCount(){
  state = state.copyWith(currentPage: state.currentPage+1);}



digitalMarkingApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
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
  state = state.copyWith(digitalMarkingModel: null);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.digitalMarkingCollateralsUrl}?limit=10&current_page=1&search_text=$searchText', method: ApiMethod.get.name);
  updateLoading(false);
   
   updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
    
  if (response != null) {
      var newModel = DigitalMarkingModel.fromJson(response.data);
      if (isLoadMore) {
         List<DigitalRecords> updatedData = [
            ...(state.digitalMarkingModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.digitalMarkingModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(digitalMarkingModel: newModel);
      }
      }
  
 } 

}

