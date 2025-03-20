// Define a StateNotifier to manage the state
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/services/internet_connectivity.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/compalint_model.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/view_complaint_model.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/logout_helper.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../api_config/api_service.dart';
import 'add_complaint_state.dart';

class AddComplaintNotifier extends StateNotifier<AddComplaintState> {

  AddComplaintNotifier() : super(
      AddComplaintState(isLoading: false,selectedVisitType: 0, selectedClaimTypeIndex: 0,imgList: [],itemList: [], channerPartnerList:[]));

  updateLoading(bool value){
    state= state.copyWith(isLoading: value);
  }


 List contactNumberList = [];
  final formKey = GlobalKey<FormState>();

final subjectController = TextEditingController();
  final channelPartnerController = TextEditingController();
  final contactPersonNameController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final stateNameController = TextEditingController();
  final townTypeController = TextEditingController();
  final pincodeController = TextEditingController();
  final itemNameController = TextEditingController();
  final shippingAddressController = TextEditingController();
  final complaintItemQuanityController = TextEditingController();
  final goodsController = TextEditingController();
  final batchNoController = TextEditingController();
  final mfdController = TextEditingController();
  final expiryController = TextEditingController();
  final reasonController = TextEditingController();
  final selectedItemNameController = TextEditingController();
  final invoiceNoController = TextEditingController();
  final dateController = TextEditingController();
  final invoiceDateController = TextEditingController();


  void resetValues() {
    state = state.copyWith(isLoading: false,selectedVisitType: 0,channerPartnerList: [],imgList: [],itemList: [],selectedClaimTypeIndex: 0,selectedRadio: 0,);
    channelPartnerController.clear();
    contactPersonNameController.clear();
    addressController.clear();
    contactController.clear();
    stateNameController.clear();
    townTypeController.clear();
    pincodeController.clear();
    itemNameController.clear();
    shippingAddressController.clear();
    complaintItemQuanityController.clear();
    goodsController.clear();
    batchNoController.clear();
    mfdController.clear();
    expiryController.clear();
    reasonController.clear();
    selectedItemNameController.clear();
    invoiceNoController.clear();
    dateController.clear();
    invoiceDateController.clear();
    subjectController.clear();
    contactNumberList =[];
  }


resetOnChangedVerfiyType(){
  contactNumberList = [];
  contactController.clear();
  contactPersonNameController.clear();
  stateNameController.clear();
  townTypeController.clear();
  pincodeController.clear();
}
  onChangedCustomType(val) {
    selectedItemNameController.text = val;
  }
  onChangedChannelPartner(val) {
    channelPartnerController.text = val;
  }

  updateVisitType(int index){
    state = state.copyWith(selectedVisitType: index);
  }

  updateClaimType(int index){
    state = state.copyWith(selectedClaimTypeIndex: index);
  }
saveImge(value){
  state = state.copyWith(imgList: [value]);
}

updateTabBarIndex(int index){
state = state.copyWith(tabBarIndex: index);
complaintListApiFunction();
}

  checkValidation(BuildContext context){
  if(formKey.currentState!.validate()){
    if(state.imgList.isEmpty){
      MessageHelper.showToast("Please uplaod the image");
    }
    else{
      callApiAddComplaint(context);
    }
  }
  else{
    print('elses');
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
    http.MultipartRequest('POST', Uri.parse(ApiUrls.uploadComplaintImageUrl));
    request.headers.addAll(headers);
      final file = await http.MultipartFile.fromPath(
        'file',
        imgFile.path,
      );
      request.files.add(file);
    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    ShowLoader.hideLoader();
    log(vb.body);
    if (vb.statusCode == 200) {
      var dataAll = json.decode(vb.body);
        saveImge(dataAll['data'][0]);      
    } else if (vb.statusCode == 401) {
      LogoutHelper.logout();
    } else {
      var dataAll = json.decode(vb.body);
      MessageHelper.showErrorSnackBar(context, dataAll['message']??'');
    }
  }

String? claimTypeTitle(int index){
  switch (index) {
    case 0:
      return "Transit";
      case 1:
      return "Quality";
    default:
    return "";
  }
}

String? customerTypeTitle(int index){
  switch (index) {
    case 0:
      return "Primary";
      case 1:
      return "Secondary";
    default:
    return "";
  }
}


itemListApiFunction(BuildContext context)async{
  ShowLoader.loader(context);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.salesItemVariantUrl}?item_template=&item_category=', method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
    state = state.copyWith(itemList: response.data['data']);
  }
}

channelPartnerApiFunction()async{
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.channelPartnerurl, method: ApiMethod.get.name);
  if(response!=null){
    state = state.copyWith(channerPartnerList: response.data['message']);
  }
}


complaintListApiFunction()async{
  state = state.copyWith(complaintModel: null);
  updateLoading(true);
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.complaintListUrl, method: ApiMethod.get.name,);
  updateLoading(false);
  if(response!=null){
    state = state.copyWith(complaintModel: ComplaintModel.fromJson(response.data));
  }
}


 callApiAddComplaint(BuildContext context)
 async {
  ShowLoader.loader(context);
   TextfieldUtils.hideKeyboard();
   final data=
       {
         "claim_type": claimTypeTitle(state.selectedClaimTypeIndex), // Transit or Quality
         "customer_type": AppConstants.visitTypeList[state.selectedVisitType],
         "company": channelPartnerController.text,
         "customer": contactPersonNameController.text,
         "contact":contactController.text,
         "state": stateNameController.text,
         "town": townTypeController.text,
         "pincode": pincodeController.text,
         "mfd": mfdController.text,
         "opening_date": dateController.text,
         "item_name": selectedItemNameController.text,
         "invoice_no": invoiceNoController.text,
         "complaint_itm_qty": complaintItemQuanityController.text,
         "value_of_goods": goodsController.text,
         "batch_no": batchNoController.text,
         "expiry": expiryController.text,
         "description": reasonController.text,
         "ref_attachments": state.imgList,
         "subject":subjectController.text
       };
   print(data);
   final response = await ApiService().makeRequest(apiUrl: ApiUrls.createComplaintUrl, method: ApiMethod.post.name,data:data);
   ShowLoader.hideLoader();
   if(response!=null){
    MessageHelper.showSuccessSnackBar(context, response.data['message']);
    Navigator.pop(context, true);
   }
 }


viewComplaintApiFunction(BuildContext context, String ticketId)async{
  state = state.copyWith(viewComplaintModel: null);
  ShowLoader.loader(context);
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.viewComplaintUrl}?name=$ticketId", method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
    state = state.copyWith(viewComplaintModel: ViewComplaintModel.fromJson(response.data));
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
