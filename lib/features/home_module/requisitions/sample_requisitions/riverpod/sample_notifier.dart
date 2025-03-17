import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/collaterals_request_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/model/view_sample_requisitions_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/riverpod/sample_state.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/message_helper.dart';

class SampleNotifier extends StateNotifier<SampleState> {
  SampleNotifier() : super(SampleState(isLoading: false,tabBarIndex: 0));
  updateLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  String filterStatusValue = '';
String filterDateValue = '';
String searchText = '';
String selectedTabbar = "Approved";

 List filterStatusList = ["Approved", "Received", "Pending"];

List<Items> selectedItem = [];
  final formKey = GlobalKey<FormState>();
  final remarksController = TextEditingController();
  final sampleDateController = TextEditingController();

resetValues(){
  searchText='';
  selectedTabbar = 'Approved';
 state = state.copyWith(tabBarIndex: 0,page: 1, collateralsReqestModel: null);
}

  resetAddSampleValues() {
    selectedItem.clear();
    sampleDateController.clear();
    remarksController.clear();
  }

  checkvalidation(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if(selectedItem.isEmpty){
        MessageHelper.showToast("Please add items");
      }
      else{
      createSampleApiFunction(context);
      }
    }
  }

resetFilter(){
    filterDateValue='';
    filterStatusValue='';
 }


updateFilterValues({required String date, required String type}){
  resetPageCount();
  filterStatusValue = type;
  filterDateValue=date;
}

onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
    resetPageCount();
    sampleRequisitionsListApiFunction();
  }
  else{
    searchText = val;
    resetPageCount();
    sampleRequisitionsListApiFunction();
  }
}

 updateTabBarIndex(val){
    state = state.copyWith(tabBarIndex: val);
    state = state.copyWith(page: 1);
    selectedTabbar = val==0?"Approved":"Pending";
    sampleRequisitionsListApiFunction();
  }

updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }


resetPageCount(){
  state = state.copyWith(page: 1);
}
increasePageCount(){
  print('object');
  state = state.copyWith(page: state.page+1);}

  createSampleApiFunction(
    BuildContext context,
  ) async {
    var data = {
      "reqd_date": sampleDateController.text,
    "remarks":remarksController.text,
    "samp_req_item": selectedItem.map((e){
      return {
        "item":e.itemName??'',
        "qty":e.quantity
      };
    }).toList()
    };
    ShowLoader.loader(context);
    final response = await ApiService().makeRequest(
        apiUrl: ApiUrls.createSampleRequisitionsUrl,
        method: ApiMethod.post.name,
        data: data);
    ShowLoader.hideLoader();
    if (response != null) {
      AppRouter.pushCupertinoNavigation(SuccessScreen(
          title: '',
          des: "You have successfully Submitted",
          btnTitle: "Track",
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          }));
    }
  }

  sampleRequisitionsListApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
   if (isLoadMore) {
      updateLoadingMore(true);
    }
     else {
      if(isShowLoading){
        updateLoading(isShowLoading);
      }
      else{
        state = state.copyWith(page: 1);
      }
    }
    final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.sampleReuisitionsListUrl}?reqd_date=$filterDateValue&status=$filterStatusValue&search_text=$searchText&tab=$selectedTabbar&limit=10&current_page=${state.page}", method: ApiMethod.get.name);
   updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
  if (response != null) {
      var newModel = CollateralsRequestModel.fromJson(response.data);
      if (isLoadMore) {
         List<CollateralsItems> updatedData = [
            ...(state.collateralsReqestModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.collateralsReqestModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(collateralsReqestModel: newModel);
      }
      if (newModel.data!.isEmpty || newModel.data!.length < state.page) {
      } else {
        if(isLoadMore){
          increasePageCount();
        }
      }
      }
  }

  viewSampleRequiitionsApiFunction(BuildContext context,{required String id})async{
    ShowLoader.loader(context);
    state = state.copyWith(viewSampleRequisitionsModel: null);
    final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.viewSampleRequisitionsUrl}?name=$id", method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
      state = state.copyWith(viewSampleRequisitionsModel: ViewSampleRequisitionsModel.fromJson(response.data));

    }
  }
}
