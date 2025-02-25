import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/model/view_sample_requisitions_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_state.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/message_helper.dart';

class TrialPlanNotifier extends StateNotifier<TrialPlanState> {
  TrialPlanNotifier() : super(TrialPlanState(isLoading: false,tabBarIndex: 0));
  updateLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

List visitTypeList = ["Primary","Secondary"];
List trailTypeList = ['Product','Item'];

List<Items> selectedItem = [];

  final formKey = GlobalKey<FormState>();

  final remarksController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final trialLocationController = TextEditingController();
  final trailTypeController = TextEditingController();
  final visitTypeController = TextEditingController();
  final customerNameController = TextEditingController();
  final businessNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final locationController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  

resetValues(){
 state = state.copyWith(tabBarIndex: 0);
}

  resetAddTrialValues() {
    state =state.copyWith(selectedTrialPlan: 0);
    selectedItem.clear(); 
    remarksController.clear();
  dateController.clear();
  timeController.clear();
   trialLocationController.clear();
   trailTypeController.clear();
   visitTypeController.clear();
   customerNameController.clear();
   businessNameController.clear();
   contactNumberController.clear();
   locationController.clear();
   address1Controller.clear();
   address2Controller.clear();
  cityController.clear();
   stateController.clear();
   pincodeController.clear();
  
  }

  onChangedVisitType(val){
    visitTypeController.text = val;
    print(visitTypeController.text);
  }

  onChangedTrailType(val){
    trailTypeController.text = val;
  }



  List<DropdownMenuItem<String>> dropDownMenuItems(List list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item,
            child: Text(
              item,
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

  checkvalidation(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if(dateController.text.isEmpty){
        MessageHelper.showToast("Please select date");
      }
      else if(timeController.text.isEmpty){
        MessageHelper.showToast("Please select time");
      }
      else if(selectedItem.isEmpty){
        MessageHelper.showToast("Please add items");
      }
      else{
      createSampleApiFunction(context);
      }
    }
  }


  createSampleApiFunction(
    BuildContext context,
  ) async {
    var data = {
      // "reqd_date": sampleDateController.text,
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

  trialPlanListApiFunction()async{
    // state = state.copyWith(jounreyPlanModel: null);
    updateLoading(true);
    final response = await ApiService().makeRequest(apiUrl: ApiUrls.trialPlanUrl, method: ApiMethod.get.name);
   updateLoading(false);
    if(response!=null){
      // state = state.copyWith(jounreyPlanModel: JounreyPlanModel.fromJson(response.data));
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
