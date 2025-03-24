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
import 'package:mohan_impex/features/home_module/complaint_claim/model/invoice_items_model.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/invoice_model.dart';
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

  String searchText = '';
String fromDateFilter = '';
String toDateFilter = '';
String visitTypeFilter = '';
String claimTypeFilter ='';
String selectedTabbar = '';
String selectedCustomer = '';
String selectedShop = '';
String? selectedInvoice ;
final searchController = TextEditingController();
List <InvoiceItemRecords> selectedItemsList = [];


 List contactNumberList = [];
  final formKey = GlobalKey<FormState>();

final subjectController = TextEditingController();
  final channelPartnerController = TextEditingController();
  final contactPersonNameController = TextEditingController();
  final shopNameController = TextEditingController();
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
    state = state.copyWith(isLoading: false,selectedVisitType: 0,channerPartnerList: [],imgList: [],itemList: [],selectedClaimTypeIndex: 0,selectedRadio: 0,invoiceItemsModel: InvoiceItemsModel.fromJson({}),invoiceModel: InvoiceModel.fromJson({}));
    selectedCustomer = '';
    selectedShop = '';
    selectedInvoice = null;
    channelPartnerController.clear();
    shopNameController.clear();
    contactPersonNameController.clear();
    addressController.clear();
    contactController.clear();
    selectedItemsList.clear();
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


resetComplaintValues(){
  selectedTabbar = "Active";
  resetFilter();
}

  resetFilter(){
   fromDateFilter = '';
 toDateFilter = '';
 visitTypeFilter = '';
 claimTypeFilter ='';
 searchController.clear();
 }


resetOnChangedVerfiyType(){
  contactNumberList = [];
  contactController.clear();
  shopNameController.clear();
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

onChangedInvoiceNo(BuildContext context, searchVal){
invoiceNoController.text = searchVal ?? '';
updateSelectedItemsList();
state.invoiceModel?.data?.forEach((val){
  if(val.name==searchVal){
    invoiceDateController.text = val.date;
  }
});
invoiceItemListApiFunction(context, searchVal);
}

clearSelectedInvoice(BuildContext context, String name){
  invoiceNoController.clear();
   selectedInvoice = null;
  invoiceDateController.clear();
   updateSelectedItemsList();
  invoiceApiFunction(context, name);
}


updateTabBarIndex(val){
    selectedTabbar = val==0?"Active":"Resolved";
    if(state.tabBarIndex !=val){
      resetFilter();
      resetPageCount();
      searchText = '';
      complaintListApiFunction();
    }
    state = state.copyWith(tabBarIndex: val);
    selectedTabbar = val==0?"Active":"Resolved";
    
  }

  checkValidation(BuildContext context){
  if(formKey.currentState!.validate()){
    if(state.imgList.isEmpty){
      MessageHelper.showErrorSnackBar(context, "Please uplaod the image");
    }
    else{
      if(checkItemsValueIsEmpty()){
    MessageHelper.showErrorSnackBar(context, "Values should not be empty");
      }
      else{
      callApiAddComplaint(context);
      }
    }
  }
  else{
  }
}

bool checkItemsValueIsEmpty(){
   return selectedItemsList.any((val)=> val.batchNoController.text.isEmpty || (val.selectedItemName ??'').isEmpty || val.mfdDateController.text.isEmpty || val.expiryDateController.text.isEmpty || val.valueOfGoodsController.text.isEmpty || val.itemQuantityController.text.isEmpty);

}

updateFilterValues({required String visitType, required String fromDate, required toDate, required String claimType}){
    fromDateFilter = fromDate;
 toDateFilter = toDate;
 visitTypeFilter = visitType;
 claimTypeFilter = claimType;
}

onChangedSearch(String val){
  if(val.isEmpty){
    searchText = '';
     resetPageCount();
     complaintListApiFunction();
  }
  else{
    searchText = val;
     resetPageCount();
    complaintListApiFunction();
  }
}



updateSelectedItemsList(){
  selectedItemsList.clear();
  state = state.copyWith(invoiceItemsModel: InvoiceItemsModel.fromJson({}));
  var model = InvoiceItemRecords();
  selectedItemsList.add(model);
}

increaseSelectedItemsList(){
  var model = InvoiceItemRecords();
  selectedItemsList.add(model);
}

updateLoadingMore(bool value){
  state = state.copyWith(isLoadingMore: value);
  }

resetPageCount(){
  state = state.copyWith(currentPage: 1);
}

increasePageCount(){
  state = state.copyWith(currentPage: state.currentPage+1);}



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


complaintListApiFunction({bool isLoadMore = false, String search = '',bool isShowLoading = true})async{
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
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.complaintListUrl}?tab=$selectedTabbar&limit=10&current_page=${state.currentPage}&search_text=$searchText&customer_level=$visitTypeFilter&claim_type=$claimTypeFilter&from_date=$fromDateFilter&to_date=$toDateFilter", method: ApiMethod.get.name,);
  updateLoading(false);
    if (!isLoadMore) {
    } else {
      updateLoadingMore(false);
    }
    
  if (response != null) {
      var newModel = ComplaintModel.fromJson(response.data);
      if (isLoadMore) {
         List<ComplaintRecords> updatedData = [
            ...(state.complaintModel?.data?[0].records ?? []), 
            ...?newModel.data![0].records,
          ];
          state.complaintModel?.data?[0].records = updatedData;
      } else {
      state =  state.copyWith(complaintModel: newModel);
      }
      // if (newModel.data!.isEmpty || newModel.data!.length < state.currentPage) {
      // } else {
      //   // if(isLoadMore){
      //     increasePageCount();
      //   // }
      // }
      }
  
}


 callApiAddComplaint(BuildContext context)async {
   List<Map<String, dynamic>> formattedData = selectedItemsList.map((e) {
  return {
       "item_code": e.selectedItemCode,
        "item_name": e.selectedItemName,
        "complaint_itm_qty": e.itemQuantityController.text,
        "value_of_goods": e.valueOfGoodsController.text,
        "batch_no": e.batchNoController.text,
        "expiry": e.expiryDateController.text,
         "mfd": e.mfdDateController.text
    };
  }).toList();  
  print(formattedData);

  ShowLoader.loader(context);
   TextfieldUtils.hideKeyboard();
   final data=
        {
    "subject": subjectController.text,
    "claim_type": claimTypeTitle(state.selectedClaimTypeIndex), // Transit or Quality
    "customer_level":AppConstants.visitTypeList[state.selectedVisitType],
    "shop": selectedShop,
    "shop_name": shopNameController.text,
    "customer": selectedCustomer,
    "contact_name": contactPersonNameController.text,
    "contact": contactController.text,
    "state": stateNameController.text,
    "district": townTypeController.text,
    "pincode": pincodeController.text,
    "opening_date": dateController.text, //date
    "invoice_no": invoiceNoController.text,
    "invoice_date": invoiceDateController.text,
    "complaint_item": formattedData,
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


invoiceApiFunction(BuildContext context,String id)async{
  state = state.copyWith(invoiceModel: InvoiceModel.fromJson({}));
  ShowLoader.loader(context);
   final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.invoiceUrl}?customer=$id", method: ApiMethod.get.name);
   ShowLoader.hideLoader();
   if(response!=null){
    state = state.copyWith(invoiceModel: InvoiceModel.fromJson(response.data));
   }
}


invoiceItemListApiFunction(BuildContext context, String invoiceId)async{
  ShowLoader.loader(context);
  state = state.copyWith(invoiceItemsModel: InvoiceItemsModel.fromJson({}));
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.getInvoiceItems}?sales_invoice=$invoiceId', method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
    state = state.copyWith(invoiceItemsModel: InvoiceItemsModel.fromJson(response.data));
  }
}


}
