
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/core/services/internet_connectivity.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/kyc/model/kyc_model.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_state.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/logout_helper.dart';
import 'package:mohan_impex/utils/message_helper.dart';

class KycNotifier extends StateNotifier<KycState> {
  KycNotifier() : super(KycState(isLoading: false,isSameBillingAddress: false,selectedBusinessType: 0,tabBarIndex: 0,cdImageList: [], clImageList: []));
updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}
String? selectedCustomerTypeValue;
  String? selectedSegmentTypeValue;
 List list = ["New", "Existing"];

  List segemantList = [
    "Segment A",
    "Segment B",
    "Segment C",
  ];
 

final formKey = GlobalKey<FormState>();

final customerNameController = TextEditingController();
final contactNumberController = TextEditingController();
final addressController = TextEditingController();
final emailController = TextEditingController();
final businessNameController = TextEditingController();
final shopNameController = TextEditingController();
final customerTypeController = TextEditingController();
final segmentController = TextEditingController();
final billingAddress1Controller = TextEditingController();
final billingAddress2Controller = TextEditingController();
final billingCityController = TextEditingController();
final billingStateController = TextEditingController();
final billingPincodeController = TextEditingController();

final shippingAddress1Controller = TextEditingController();
final shippingAddress2Controller = TextEditingController();
final shippingCityController = TextEditingController();
final shippingStateController = TextEditingController();
final shippingPincodeController = TextEditingController();

final gstNumberController = TextEditingController();
final creditLimitController = TextEditingController();
final creditStartDaysController = TextEditingController();
final creditEndDaysController = TextEditingController();
final panNumberController = TextEditingController();


resetValues(){
  state = state.copyWith(isLoading: false,isSameBillingAddress: false,selectedBusinessType: 0,tabBarIndex: 0);
 customerNameController.clear();
 contactNumberController.clear();
 addressController.clear();
 emailController.clear();
 shopNameController.clear();
 businessNameController.clear();
 customerTypeController.clear();
 segmentController.clear();
 billingAddress1Controller.clear();
 billingAddress2Controller.clear();
 billingCityController.clear();
 billingStateController.clear();
 billingPincodeController.clear();
 shippingAddress1Controller.clear();
 shippingAddress2Controller.clear();
 shippingCityController.clear();
 shippingStateController.clear();
 shippingPincodeController.clear();
 gstNumberController.clear();
 creditLimitController.clear();
 creditStartDaysController.clear();
 creditEndDaysController.clear();
 panNumberController.clear();

}

onChangedCheckBox(bool value){
state = state.copyWith(isSameBillingAddress: value);
saveBillingAddressIfSelectOption();
}

saveBillingAddressIfSelectOption(){
  if(state.isSameBillingAddress){
    billingAddress1Controller.text = shippingAddress1Controller.text;
  billingAddress2Controller.text = shippingAddress2Controller.text;
  billingCityController.text = shippingCityController.text;
  billingStateController.text = shippingStateController.text;
  billingPincodeController.text = shippingPincodeController.text; 
  }
}

onChangedCustomType(val) {
  selectedCustomerTypeValue = val;
  customerTypeController.text = val;  
  }

  onChangedSegment(val) {
    selectedSegmentTypeValue = val;
  segmentController.text = val;  
  }

  updateBusinessType(int index){
    state = state.copyWith(selectedBusinessType: index);
  }


checkValidation(BuildContext context){
  if(formKey.currentState!.validate()){
    if(creditStartDaysController.text.isEmpty || creditEndDaysController.text.isEmpty){
      MessageHelper.showErrorSnackBar(context, "Select start date and end date");
    }
    else{
      saveBillingAddressIfSelectOption();
    updateTabBarIndex(1);
    }

  }
}

checkDocumentValidation(){
 if(state.cdImageList.isEmpty){
  MessageHelper.showToast("Please upload customer declaration image");
 }
 else if(state.clImageList.isEmpty){
MessageHelper.showToast("Please upload customer license image");
 } 
 else{
  updateTabBarIndex(2);
 }
}


updateTabBarIndex(int val){
  state = state.copyWith(tabBarIndex: val);
}

saveCDImge(value){
  state = state.copyWith(cdImageList: [value]);
}

saveCLImge(value){
  state = state.copyWith(clImageList: [value]);
}



 int calculateCreditDays(){
  Duration difference = DateTime.parse(creditEndDaysController.text) .difference(DateTime.parse(creditStartDaysController.text));
  return difference.inDays;
 }

String businessTypeTitle(index){
  switch (index) {
    case 0:
      return "Registered";
    case 1:
    return "Unregistered"; 
    default:
    return "";
  }
}


imageUploadApiFunction(BuildContext context, File imgFile, {required bool isCLImage})async{
     bool isConnected = await InternetConnectivity.isConnected();
    if(!isConnected){
      MessageHelper.showInternetSnackBar();
      return null;
    }
    ShowLoader.loader(context);
    Map<String, String> headers = {"Authorization": "Bearer ${LocalSharePreference.token}"};
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrls.uploadKycAttachementUrl));
    request.headers.addAll(headers);
      final file = await http.MultipartFile.fromPath(
        'attachement_1',
        imgFile.path,
      );
      request.files.add(file);
    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    ShowLoader.hideLoader();
    log(vb.body);
    if (vb.statusCode == 200) {
      var dataAll = json.decode(vb.body);
      if(isCLImage){
        saveCLImge(dataAll['data'][0]);
      }
      else{
        saveCDImge(dataAll['data'][0]);
      }
      
    } else if (vb.statusCode == 401) {
      LogoutHelper.logout();
    } else {
      var dataAll = json.decode(vb.body);
      MessageHelper.showErrorSnackBar(context, dataAll['message']??'');
    }
  }


kyclistApiFunction(BuildContext context)async{
  updateLoading(true);
  state = state.copyWith(kycModel: null);
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.kycList, method: ApiMethod.get.name);
   updateLoading(false);
   if(response!=null){
    state = state.copyWith(kycModel: KYCModel.fromJson(response.data));
   }
 } 

createKycApiFunction()async{
  var body = {
     "customer_name": customerNameController.text,
    "customer_type": customerTypeController.text,
    "business_type": businessTypeTitle(state.selectedBusinessType),
    "contact": contactNumberController.text,
    "shop": businessNameController.text,
    "segment": segmentController.text,
    "address": addressController.text,
    "shipping_address": {
        "title": "SHIPPING ADDRESS",
        "address_line1": shippingAddress1Controller.text,
        "address_line2": shippingAddress2Controller.text,
        "city": shippingCityController.text,
        "state": shippingStateController.text,
        "pincode": shippingPincodeController.text
    },
    "billing_address": {
        "title":"BILLING ADDRESS",
        "address_line1": billingAddress2Controller.text,
        "address_line2": billingAddress2Controller.text,
        "city": billingCityController.text,
        "state": billingStateController.text,
        "pincode":billingPincodeController.text
    },
    "email_id": emailController.text,
    "credit_days": calculateCreditDays(),
    "credit_limit": creditLimitController.text,
    "gst_no": state.selectedBusinessType==0? gstNumberController.text :"",
    "pan": state.selectedBusinessType==1? panNumberController.text :"",
    "cust_decl": state.cdImageList,
    "cust_license": state.clImageList
  };

  final response = await ApiService().makeRequest(apiUrl: ApiUrls.createKycUrl, method: ApiMethod.post.name,data: body);
   ShowLoader.hideLoader();
   if(response!=null){
    // state = state.copyWith(priceListModel: PriceListModel.fromJson(response.data));
   }
}

}

