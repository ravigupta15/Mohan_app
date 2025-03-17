import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/view_journey_plan_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/riverpod/journey_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/model/collaterals_request_model.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/message_helper.dart';

class JourneyNotifier extends StateNotifier<JourneyState> {
  JourneyNotifier() : super(JourneyState(isLoading: false,tabBarIndex: 0));
  updateLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

final searchController = TextEditingController();
String filterNatureOfTravelValue = '';
String filterDateValue = '';
String searchText = '';

  List naturalTravelList = ['HQ', "EX-HQ", "Night Out"];
  List modelTravelList = ["Air", "Bus", "Train"];

String selectedTabbar = "Approved";
  final formKey = GlobalKey<FormState>();
  final naturalOfTravelController = TextEditingController();
  final naturalOutLocationController = TextEditingController();
  final travelToStateController = TextEditingController();
  final travelToDistrictController = TextEditingController();
  final modeOfTravelController = TextEditingController();
  final remarksController = TextEditingController();
  final fromDateController = TextEditingController();
  final toController = TextEditingController();

List<DistrictItem> districtList = [];
  resetAddValues() {
    state = state.copyWith(districtModel: null,stateModel: null);
    naturalOfTravelController.clear();
    naturalOutLocationController.clear();
    remarksController.clear();
    modeOfTravelController.clear();
    travelToDistrictController.clear();
    travelToStateController.clear();
    fromDateController.clear();
    toController.clear();
  }


resetValues(){
  state = state.copyWith(tabBarIndex: 0,districtModel: null,stateModel: null,page: 1);
  selectedTabbar = "Approved";
  searchText  ='';
  searchController.clear();
}

  onChangedNaturalTravl(val) {
    naturalOfTravelController.text = val;
  }

  onChangedState(BuildContext context, val) {
    travelToStateController.text = val;
    // travelToDistrictController.clear();
    districtApiFunction(context, stateText: val);
  }

  onChangedDistrict(val) {
    travelToDistrictController.text = val;
  }

  onChangedModeTravel(val) {
    modeOfTravelController.text = val;
  }

  checkvalidation(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (fromDateController.text.isEmpty || toController.text.isEmpty) {
        MessageHelper.showToast("Please select visit date");
      } else {
        createJourneyApiFunction(context);
      }
    }
  }

  resetFilter(){
    filterDateValue='';
    filterNatureOfTravelValue='';
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
      searchController.clear();
      searchText = '';
      journeyPlanListApiFunction();
    }
    state = state.copyWith(tabBarIndex: val);
    state = state.copyWith(page: 1);
    selectedTabbar = val==0?"Approved":"Pending";

  }


increasePageCount(){
  print('object');
  state = state.copyWith(page: state.page+1);}


updateFilterValues({required String date, required String type}){
  resetPageCount();
  filterNatureOfTravelValue = type;
  filterDateValue=date;
}

onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
     resetPageCount();
    journeyPlanListApiFunction();
  }
  else{
    searchText = val;
     resetPageCount();
    journeyPlanListApiFunction();
  }
}

  createJourneyApiFunction(
    BuildContext context,
  ) async {
    var data = {
      "visit_from_date": fromDateController.text,
      "nature_of_travel": naturalOfTravelController.text,
      "mode_of_travel": modeOfTravelController.text,
      "visit_to_date": toController.text,
      "night_out_location":naturalOfTravelController.text.toLowerCase() == 'night out'? naturalOutLocationController.text : '',
      "travel_to_district": travelToDistrictController.text,
      "travel_to_state": travelToStateController.text,
      "remarks": remarksController.text
    };
    print(data);
    ShowLoader.loader(context);
    final response = await ApiService().makeRequest(
        apiUrl: ApiUrls.createJourneyUrl,
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
            Navigator.pop(context,true);
          }));
    }
  }

  journeyPlanListApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
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
  
    final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.journeyPlanListUrl}?nature_of_travel=$filterNatureOfTravelValue&date=$filterDateValue&search_text=$searchText&tab=$selectedTabbar&limit=5&current_page=${state.page}", method: ApiMethod.get.name);
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

  viewJourneyPlanApiFunction(BuildContext context,{required String id})async{
    ShowLoader.loader(context);
    state = state.copyWith(viewJounreyPlanModel: null);
    final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.viewJourneyPlanUrl}?name=$id", method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
      state = state.copyWith(viewJounreyPlanModel: ViewJounreyPlanModel.fromJson(response.data));

    }
  }

  stateApiFunction(BuildContext context, { String searchText =''})async{
  state = state.copyWith(stateModel: null);
    ShowLoader.loader(context);
    final response =await ApiService().makeRequest(apiUrl: '${ApiUrls.stateUrl}/?filters=[["state", "like", "%$searchText%"]]&limit=100', method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
      var model =  StateModel.fromJson(response.data);
    state = state.copyWith(stateModel:model);
    }
  }

  districtApiFunction(BuildContext context,{required String stateText})async{
    state = state.copyWith(districtModel: null);
  ShowLoader.loader(context);
    final response =await ApiService().makeRequest(apiUrl: '${ApiUrls.districtUrl}/?fields=["district", "state"]&filters=[["district", "like", "%%"], ["state", "=", "$stateText"]]&limit=100', method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
     state = state.copyWith(districtModel: DistrictModel.fromJson(response.data));
    }
    
  }
}
