import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/collaterals_request_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/material_items_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/view_collaterals_request_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/riverpod/collaterals_request_state.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/message_helper.dart';

class CollateralsRequestNotifier extends StateNotifier<CollateralsRequestState> {
  CollateralsRequestNotifier() : super(CollateralsRequestState(isLoading: false,tabBarIndex: 0));
  updateLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  final searchController =TextEditingController();
  
String  selectedValues = '';
String selectedTabbar = "Approved";

String filterStatusValue = '';
String filterDateValue = '';
String searchText = '';

 

List<MaterialItems> selectedItem = [];
  final formKey = GlobalKey<FormState>();
  final remarksController = TextEditingController();

resetValues(){
  searchText='';
  selectedTabbar = "Approved";
  searchController.clear();
 state = state.copyWith(tabBarIndex: 0);
 resetFilter();
}



  resetAddCollateralsValues() {
    selectedItem.clear();
    remarksController.clear();
  }

  checkvalidation(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if(selectedItem.isEmpty){
        MessageHelper.showToast("Please add items");
      }
      else{
        bool value = selectedItem.any((val) => val.quantity == 0);
      if(value){
        MessageHelper.showErrorSnackBar(context, "Quantity should not be empty");
      }
      else{
      createCollateralsRequestApiFunction(context);
      }
      }
    }
  }

resetFilter(){
  resetPageCount();
    filterDateValue='';
    filterStatusValue='';
 }

onChangedMaterial(val){
 state.materialItemsModel?.data?.forEach((value){
  if(val==value.itemCode){
   bool alreadyAdded = selectedItem.any((selected) => selected.itemCode == value.itemCode);

      if (alreadyAdded) {
        MessageHelper.showErrorSnackBar(navigatorKey.currentContext!, "This item is already added");
      } else {
        selectedItem.add(value);
      }

  }
 }); 
}

updateFilterValues({required String date, required String status}){
  resetPageCount();
  filterStatusValue = status;
  filterDateValue=date;
}


  List<DropdownMenuItem<String>> materialDropdownItems(List<MaterialItems> list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item.itemCode,
            child: Text(
              item.itemName,
            ),
          ),
          if (item != list.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }


updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }

resetPageCount(){
  state = state.copyWith(page: 1);
}

  updateTabBarIndex(val){
      selectedTabbar = val==0?"Approved":"Pending";
      if(state.tabBarIndex !=val){
      resetFilter();
      searchText = '';
      searchController.clear();
      resetPageCount();
      collateralListApiFunction();
    }
    state = state.copyWith(tabBarIndex: val);
    // collateralListApiFunction();
  }

  onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
     resetPageCount();
     collateralListApiFunction();
  }
  else{
    print('sdfd..$val');
    searchText = val;
     resetPageCount();
    collateralListApiFunction();
  }
}


increasePageCount(){
  print('object');
  state = state.copyWith(page: state.page+1);}

  collateralListApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
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
    if(isLoadMore){
    increasePageCount();
  }
  final response= await ApiService().makeRequest(apiUrl: "${ApiUrls.collateralRequestListUrl}?tab=$selectedTabbar&limit=10&current_page=${state.page}&search_text=$searchText&created_date=$filterDateValue&status=$filterStatusValue", method: ApiMethod.get.name,);
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
      // if (newModel.data!.isEmpty || newModel.data!.length < state.page) {
      // } else {
      //   // if(isLoadMore){
      //     increasePageCount();
      //   // }
      // }
      }
    }



  createCollateralsRequestApiFunction(
    BuildContext context,
  ) async {
    var data = {
    "remarks":remarksController.text,
    "mktg_coll_item": selectedItem.map((e){
      return {
        "item":e.itemCode??'',
        "qty":e.quantity
      };
    }).toList()
    };
    ShowLoader.loader(context);
    final response = await ApiService().makeRequest(
        apiUrl: ApiUrls.createCollateralRequestUrl,
        method: ApiMethod.post.name,
        data: data);
    ShowLoader.hideLoader();
    if (response != null) {
      AppRouter.pushCupertinoNavigation(SuccessScreen(
          title: '',
          des: "You have successfully submitted the collaterals request",
          btnTitle: "Track",
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          }));
    }
  }


  viewCollateralsApiFunction(BuildContext context,{required String id})async{
    ShowLoader.loader(context);
    state = state.copyWith(viewCollateralsReqestModel: ViewCollateralsReqestModel.fromJson({}));
    final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.viewCollateralUrl}?name=$id", method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
      state = state.copyWith(viewCollateralsReqestModel: ViewCollateralsReqestModel.fromJson(response.data));

    }
  }

  materialListApiFunction(BuildContext context, String text)async{
    ShowLoader.loader(context);
    
   state = state.copyWith(materialItemsModel: null); 
    final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.materialListUrl}?search_text=$text", method: ApiMethod.get.name);
    ShowLoader.hideLoader();
   if(response!=null){
   state = state.copyWith(materialItemsModel: MaterialItemsModel.fromJson(response.data));
   }
  }
}
