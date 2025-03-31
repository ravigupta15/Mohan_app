
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
import 'package:mohan_impex/features/home_module/custom_visit/model/view_visit_model.dart';
import 'package:mohan_impex/features/home_module/kyc/model/segment_model.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/kyc_complate_screen.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/add_kyc_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/logout_helper.dart';
import 'package:mohan_impex/utils/message_helper.dart';

class AddKycNotifier extends StateNotifier<AddKycState> {
  AddKycNotifier() : super(AddKycState(isLoading: false,isSameBillingAddress: false,selectedBusinessType: 0,cdImageList: [], clImageList: []));
updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}
String searchText = '';
String selectedShop = '';
String unvCustomerId = '';
String addressTitle = '';
String addressName = '';
String? selectedVisitTypeValue;
  String? selectedSegmentTypeValue;

String? selectedCustomerType;

 String selectedTabbar = "KYC Completed";
 List list = ["Primary", "Secondary"];

List contactList = [];
String? selectedShippingState;
String? selectedBillingState;

String? selectedShippingDistrict;
String? selectedBillingDistrict;

String? selectedState;
String? selectedDistrict;
 

final formKey = GlobalKey<FormState>();

final customerTypeController = TextEditingController();
final customerNameController = TextEditingController();
final contactNumberController = TextEditingController();
final emailController = TextEditingController();
final businessNameController = TextEditingController();
final visitTypeController = TextEditingController();
final segmentController = TextEditingController();

final stateController = TextEditingController();
final districtController = TextEditingController();

final billingAddress1Controller = TextEditingController();
final billingAddress2Controller = TextEditingController();
final billingDistrictController = TextEditingController();
final billingStateController = TextEditingController();
final billingPincodeController = TextEditingController();

final shippingAddressTitleController = TextEditingController();
final shippingAddress1Controller = TextEditingController();
final shippingAddress2Controller = TextEditingController();
final shippingDistrictController = TextEditingController();
final shippingStateController = TextEditingController();
final shippingPincodeController = TextEditingController();

final gstNumberController = TextEditingController();
final creditLimitController = TextEditingController();
final creditStartDaysController = TextEditingController();
final creditEndDaysController = TextEditingController();
final panNumberController = TextEditingController();

final remarksController = TextEditingController();


resetControllers(){
  addressTitle = '';
  addressName = '';
  selectedBillingDistrict = null;
  selectedBillingState = null;
  selectedShippingDistrict = null;
  selectedShippingState = null;
  selectedSegmentTypeValue = null;
  selectedVisitTypeValue = null;
  selectedDistrict = null;
  selectedState = null;
  unvCustomerId = '';
  selectedShop = '';
  contactList.clear();
  selectedCustomerType = null;
  state = state.copyWith(isSameBillingAddress: false,addKycTabBarIndex: 0,billingDistrictModel:  DistrictModel.fromJson({}),
  segmentModel: null,shippingDistrictModel:  DistrictModel.fromJson({}),selectedBusinessType: 0,districtModel: DistrictModel.fromJson({}),
  billingStateModel: StateModel.fromJson({}),stateModel: StateModel.fromJson({}),shippingStateModel: StateModel.fromJson({}), cdImageList: [], clImageList: []
  );
  customerTypeController.clear();
  customerNameController.clear();
 contactNumberController.clear();
 districtController.clear();
 stateController.clear();
 emailController.clear();
 businessNameController.clear();
 visitTypeController.clear();
 segmentController.clear();
 billingAddress1Controller.clear();
 billingAddress2Controller.clear();
 billingDistrictController.clear();
 billingStateController.clear();
 billingPincodeController.clear();
 shippingAddressTitleController.clear();
 shippingAddress1Controller.clear();
 shippingAddress2Controller.clear();
 shippingDistrictController.clear();
 shippingStateController.clear();
 shippingPincodeController.clear();
 gstNumberController.clear();
 creditLimitController.clear();
 creditStartDaysController.clear();
 creditEndDaysController.clear();
 panNumberController.clear();
 remarksController.clear();
}

onChangedCheckBox(BuildContext context, bool value){
state = state.copyWith(isSameBillingAddress: value);
saveBillingAddressIfSelectOption(context);
}

saveBillingAddressIfSelectOption(BuildContext context){
  if(state.isSameBillingAddress){
    shippingAddress1Controller.text = billingAddress1Controller.text;
    shippingAddress2Controller.text = billingAddress2Controller.text;
    shippingDistrictController.text = billingDistrictController.text;
    shippingStateController.text = billingStateController.text;
    shippingPincodeController.text = billingPincodeController.text;
     selectedShippingState = billingStateController.text;
     print("dfgh....$selectedShippingState");
  if(billingStateController.text.isNotEmpty){
    selectedShippingDistrict = null;
    state.shippingDistrictModel =null;
    districtApiFunction(context, stateText: billingStateController.text).then((val){
      if(val !=null){
  Future.delayed(Duration(milliseconds: 300),(){
state = state.copyWith(shippingDistrictModel:  DistrictModel.fromJson(val)); 
selectedShippingDistrict = billingDistrictController.text;
  });
      }
    });
  }
  
  }
}

onChangedVisitType(val) {
  selectedVisitTypeValue = val;
  visitTypeController.text = val;  
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
    addKycTabBarIndex(1);
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
  addKycTabBarIndex(2);
 }
}

updateBillingDistrictModel(val){
  state = state.copyWith(billingDistrictModel: DistrictModel.fromJson(val));
}

onChangedCustomerType(val){
  selectedCustomerType = val;
customerTypeController.text = val;
}

saveCDImge(value){
  state = state.copyWith(cdImageList: [...state.cdImageList, value]);
  print("cdlist...${state.cdImageList}");
}

saveCLImge(value){
  state = state.copyWith(clImageList: [...state.clImageList, value]);
}

onChangedStateVal(BuildContext context, String val){
  districtController.clear();
  selectedDistrict = null;
  selectedState = val;
  state = state.copyWith(districtModel: null);
  districtApiFunction(context, stateText: val).then((val){
    if(val!=null){
      state = state.copyWith(districtModel: DistrictModel.fromJson(val));
    }
  });
}


onChangedShippingStateVal(BuildContext context, String val){
  shippingDistrictController.clear();
  shippingStateController.text = val;
  selectedShippingState = val;
  selectedShippingDistrict = null;
  state = state.copyWith(shippingDistrictModel: null);
  districtApiFunction(context, stateText: val).then((val){
    if(val!=null){
      state = state.copyWith(shippingDistrictModel: DistrictModel.fromJson(val));
    }
  });
}

onChangedBillingStateVal(BuildContext context, String val){
  billingStateController.text = val;
  selectedBillingDistrict = null;
  selectedBillingState = val;
  state = state.copyWith(billingDistrictModel: null);
  districtApiFunction(context, stateText: val).then((val){
    if(val!=null){
      state = state.copyWith(billingDistrictModel: DistrictModel.fromJson(val));
    }
  });
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
    return "UnRegistered"; 
    default:
    return "";
  }
}

  addKycTabBarIndex(val){
    state = state.copyWith(addKycTabBarIndex: val);
  }

 setVisitValues(BuildContext context, VisitItemsModel? visitItemsModel){
 customerNameController.text = visitItemsModel?.unvCustomerName ?? '';
 unvCustomerId = visitItemsModel?.unvCustomer ?? '';
 selectedShop = visitItemsModel?.shop ?? '';
 contactNumberController.text = visitItemsModel?.contact?[0].contact ?? '';
 businessNameController.text  =visitItemsModel?.shopName  ??"";
 visitTypeController.text = visitItemsModel?.customerLevel ??"";
 segmentController.text = '';
billingAddress1Controller.text = visitItemsModel?.addressLine1 ??'';
 billingAddress2Controller.text = visitItemsModel?.addressLine2 ?? '';
 billingDistrictController.text = visitItemsModel?.district ?? '';
 billingStateController.text = visitItemsModel?.state ?? '';
 billingPincodeController.text = visitItemsModel?.pincode ?? '';
 addressTitle = visitItemsModel?.addressTitle ?? '';
 addressName = visitItemsModel?.location?? '';
 remarksController.text = visitItemsModel?.remarksnotes?? '';
 if((visitItemsModel?.state??'').isNotEmpty){
  stateApiFunction(context).then((val){
    state = state.copyWith(billingStateModel: StateModel.fromJson(val));
    selectedBillingState = visitItemsModel?.state;
    print("asdgfgh...$selectedBillingState");
  });
  districtApiFunction(context, stateText: visitItemsModel?.state).then((val){
    if(val!=null){
      state = state.copyWith(billingDistrictModel: DistrictModel.fromJson(val));
      selectedBillingDistrict = visitItemsModel?.district;
    }
  });
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

createKycApiFunction(BuildContext context)async{
  ShowLoader.loader(context);
  var body = {
    "unv_customer": unvCustomerId,
     "customer_name": customerNameController.text,
    "customer_level": visitTypeController.text.isEmpty?"Primary":visitTypeController.text,
    "business_type": businessTypeTitle(state.selectedBusinessType),
    "contact": contactNumberController.text,
    "shop": selectedShop,
    "shop_name":businessNameController.text,
    "segment": segmentController.text,
    "district": billingDistrictController.text,
    "state": billingStateController.text,
    "shipping_address": {
        "title": shippingAddressTitleController.text,
        "address_line1": shippingAddress1Controller.text,
        "address_line2": shippingAddress2Controller.text,
       "city": shippingDistrictController.text,
        "state": shippingStateController.text,
        "pincode": shippingPincodeController.text
    },
    "billing_address": {
         "title": addressTitle,
        "address":addressName,
        "address_line1": billingAddress1Controller.text,
        "address_line2": billingAddress2Controller.text,
       "city": billingDistrictController.text,
        "state": billingStateController.text,
        "pincode": billingPincodeController.text
    },
    "email_id": emailController.text,
    "credit_days": calculateCreditDays(),
    "credit_limit": creditLimitController.text,
    "gst_no": state.selectedBusinessType==0? gstNumberController.text :"",
    "pan": state.selectedBusinessType==1? panNumberController.text :"",
    "cust_decl": state.cdImageList,
    "cust_license": state.clImageList,
    "remarks":remarksController.text,
    "customer_type": customerTypeController.text
  };
log(json.encode(body));
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.createKycUrl, method: ApiMethod.post.name,data: body);
   ShowLoader.hideLoader();
   if(response!=null){
    // MessageHelper.showSuccessSnackBar(context, response.data['message']??'');
    // Navigator.pop(context,true);
    AppRouter.pushCupertinoNavigation( kycComplate(id:response.data['data']?[0]['kyc']??''));
   }
}


  segementApiFunction(BuildContext context)async{
  state = state.copyWith(segmentModel: null);
    ShowLoader.loader(context);
    final response =await ApiService().makeRequest(apiUrl: ApiUrls.segementUrl, method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
    state = state.copyWith(segmentModel:SegmentModel.fromJson(response.data));
    }
  }



  Future stateApiFunction(BuildContext context, { String searchText =''})async{
  state = state.copyWith(stateModel: null, billingStateModel: null);
    final response =await ApiService().makeRequest(apiUrl: '${ApiUrls.stateUrl}/?filters=[["state", "like", "%$searchText%"]]&limit=100', method: ApiMethod.get.name);
    if(response!=null){
      var model =  StateModel.fromJson(response.data);
    state = state.copyWith(stateModel:model, shippingStateModel: model, billingStateModel: model);
    return response.data;
    }
  }

 Future districtApiFunction(BuildContext context,{required String stateText})async{
  ShowLoader.loader(context);
    final response =await ApiService().makeRequest(apiUrl: '${ApiUrls.districtUrl}/?fields=["district", "state"]&filters=[["district", "like", "%%"], ["state", "=", "$stateText"]]&limit=100', method: ApiMethod.get.name);
    ShowLoader.hideLoader();
    if(response!=null){
    return response.data;
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

  Future kycExistValidationApiFunction(BuildContext context, String id)async{
  // state = state.copyWith(segmentModel: null);
    ShowLoader.loader(context);
    final response =await ApiService().makeRequest(apiUrl: "${ApiUrls.kycExistsValidationUrl}?unv_customer=$id", method: ApiMethod.get.name);
    ShowLoader.hideLoader();

    if(response!=null){
      // MessageHelper.showToast(response.data['message']??'');
      return response;
    // state = state.copyWith(segmentModel:SegmentModel.fromJson(response.data));
    }
  }


}

