import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/product_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/add_trial_plan_state.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'dart:developer';

class AddTrialPlanNotifier extends StateNotifier<AddTrialPlanState> {
  AddTrialPlanNotifier() : super(AddTrialPlanState(isLoading: false,tabBarIndex: 0));
  updateLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }
  String unvName = '';
String? selectedStateValue;
String? selectedDistrictValue;
String? selectedVisitType;
String? selectedVerifyType;
String channelPartner = '';

bool isEditDetails = false;
List<Items> selectedItem = [];
List<ProductItems> selectedProduct = [];

  final formKey = GlobalKey<FormState>();
  List contactNumberList = [];

String customer = '';
String selectedShop = '';
String verifiedCustomerLocation = '';
  final remarksController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final trialLocationController = TextEditingController();
  final trailTypeController = TextEditingController();
  final visitTypeController = TextEditingController();
  final verifyTypeController = TextEditingController();
  final customerNameController = TextEditingController();
  final businessNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final addressTypeController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final appointmentController = TextEditingController();


  resetAddTrialValues() {
    state =state.copyWith(selectedConductType: 0,verifiedCustomerLocation: '',unvName: '',selectedExistingCustomer: '');
    customer = '';
    unvName = '';
    channelPartner = '';
    selectedShop ='';
    isEditDetails = false;
    selectedItem.clear();
    selectedProduct.clear();
    selectedVisitType = null;
    selectedVerifyType = null;
    verifiedCustomerLocation = '';
    selectedDistrictValue = null;
    selectedStateValue = null;
    selectedItem.clear(); 
    remarksController.clear();
  dateController.clear();
  timeController.clear();
   trialLocationController.clear();
   trailTypeController.clear();
   verifyTypeController.clear();
   visitTypeController.clear();
   customerNameController.clear();
   businessNameController.clear();
   contactNumberController.clear();
   address1Controller.clear();
   address2Controller.clear();
   districtController.clear();
   stateController.clear();
   pincodeController.clear();
   appointmentController.clear();
  }

  resetOnChangedVerifyType(){
    customerNameController.clear();
     state =state.copyWith(verifiedCustomerLocation: '',unvName: '',selectedExistingCustomer: '');
    selectedDistrictValue = null;
    customer = '';
    selectedShop = '';
    selectedStateValue = null;
     businessNameController.clear();
   contactNumberController.clear();
   address1Controller.clear();
   address2Controller.clear();
   districtController.clear();
   stateController.clear();
   pincodeController.clear();
  }

  onChangedVisitType(val){
    visitTypeController.text = val;
    print(visitTypeController.text);
  }

  onChangedTrailType(val){
    trailTypeController.text = val;
    if(val == "product"){
      selectedItem.clear();
    }
    else if(val == "Item"){
      selectedProduct.clear();
    }
  }
  onChangedVerifyType(val){
    verifyTypeController.text = val;
  }



updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }

resetPageCount(){
  state = state.copyWith(currentPage: 1);
}

  
// onChangedStateVal(BuildContext context, String val){
//   districtController.clear();
//   selectedDistrictValue = null;
//   selectedStateValue = val;
//   state = state.copyWith(districtModel: null);
//   districtApiFunction(context, stateText: val).then((val){
//     if(val!=null){
//       state = state.copyWith(districtModel: DistrictModel.fromJson(val));
//     }
//   });
// }


increasePageCount(){
  state = state.copyWith(currentPage: state.currentPage+1);}


  checkvalidation(BuildContext context,String route, Function(List)?detailsBack) {
    if (formKey.currentState!.validate()) {
      if(dateController.text.isEmpty){
        MessageHelper.showToast("Please select date");
      }
      else if(timeController.text.isEmpty){
        MessageHelper.showToast("Please select time");
      }
      else if(selectedItem.isEmpty && selectedProduct.isEmpty){
        MessageHelper.showToast(trailTypeController.text == 'Product'? "Please add porducts" : "Please add items");
      }
      else{
        if(contactNumberList.isEmpty){
          contactNumberList.add(int.parse(contactNumberController.text));
        }
      createTrialPlanApiFunction(context,route, detailsBack);
      }
    }
  }


  Future createTrialPlanApiFunction(
    BuildContext context, String route, 
    Function(List)?detailsBack,) async {
      List itemFormatted = selectedItem.map((e) {
        return {"item_name": e.itemName, "item_code": e.itemCode};
      }).toList();

     List productFormatted  =selectedProduct.map((e) {
        return {"product": e.productName,};
      }).toList();

    var data = {
   "conduct_by": AppConstants.conductByList[state.selectedConductType] ,
      "trial_type": trailTypeController.text,
      "trial_location": trialLocationController.text,
      "verific_type": selectedVerifyType,
      "customer_level": visitTypeController.text,
      "unv_customer_name": selectedVerifyType == 'Unverified'
          ? customerNameController.text
          : "",
        "unv_customer":  selectedVerifyType == 'Unverified'? customer:'',
      "customer": selectedVerifyType == 'Unverified'? '':customer,
      "customer_name":selectedVerifyType == 'Unverified'? "": customerNameController.text,
      "shop_name": businessNameController.text,
      "shop": selectedShop,
      "contact": contactNumberList.map((e) {
        return {"contact": e.toString()};
      }).toList(),
      "channel_partner": channelPartner,
      "location": verifiedCustomerLocation,
      "address_title": addressTypeController.text,
      "address_line1": address1Controller.text,
      "address_line2": address2Controller.text,
      "district": districtController.text,
      "state": stateController.text,
      "pincode": pincodeController.text,
      "appointment_date": appointmentController.text,
      "remarksnotes": remarksController.text,
      "date": dateController.text,
      "time": timeController.text,
      "item_trial_table": itemFormatted,
      "product_trial_table":productFormatted,
      "cust_edit_needed": isEditDetails ? 1 :0
    };
    log(json.encode(data));
    ShowLoader.loader(context);
    final response = await ApiService().makeRequest(
        apiUrl: ApiUrls.createProductTrialUrl,
        method: ApiMethod.post.name,
        data: data);
    ShowLoader.hideLoader();
    if (response != null) {
      AppRouter.pushCupertinoNavigation(SuccessScreen(
          title: '',
          des: "You have successfully Submitted",
          btnTitle: "Track",
          onTap: () {
            print("dfg..$response");
            Navigator.pop(context,true);
            Navigator.pop(context,true);
            ///
            if((route ?? '').isNotEmpty){
        detailsBack!([trailTypeController.text,
            AppConstants.conductByList[state.selectedConductType],
            trailTypeController.text.toString().toLowerCase() == "product"? productFormatted: itemFormatted
            ],);
            }

          }));
    }
  }

Future customerAddressApiFunction(BuildContext context, String searchText, String type)async{
  ShowLoader.loader(context);
   final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.getCustomerAddressUrl}?customer=$searchText&verific_type=$type", method: ApiMethod.get.name);
   ShowLoader.hideLoader();
  if(response!=null){
    return response.data;
  }
}


}
