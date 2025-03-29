// Define a StateNotifier to manage the state
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/item_template_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/view_sales_order_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_state.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/logout_helper.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;


class AddSalesOrderNotifier extends StateNotifier<AddSalesOrderState> {
  AddSalesOrderNotifier() : super(AddSalesOrderState(isLoading: false,tabBarIndex: 0, currentTimer: 0,
  selectedCustomerType: 0,selectedVisitType: 0,customerName: '',shopName: '',addQuantity: 0, captureImageList: [1],
  uploadedImageList: [],channelList: [],selectedProductList: [],contactNumberList: [] ));



  String selectedUNVCustomer = '';
  String selectedVerificationType = '';
  String selectedshop = '';
  String selectedExistingCustomer = '';
  bool isEditDetails = false;
  bool isReadOnlyFields = false;
  int isUpdate = 0;
  String soId = '';

 
  int selectedProductCategoryIndex= 0;

final customerNameController = TextEditingController();
final shopNameController = TextEditingController();
final numberController = TextEditingController();
final channelPartnerController = TextEditingController();
final remarksController  = TextEditingController();
 final searchController = TextEditingController();
 final bookAppointmentController = TextEditingController();
 final verfiyTypeController = TextEditingController();
 final deliveryDateController = TextEditingController();

 String verifiedCustomerLocation = '';



final formKey = GlobalKey<FormState>();


updateLoading(bool isLoading){
  state = state.copyWith(isLoading: isLoading);
}

 resetValues(){
  state = state.copyWith(selectedCustomerType: 0,selectedVisitType: 0,tabBarIndex: 0,captureImageList: [1],addQuantity: 0,customerName: '',isLoading: false,shopName: '',productTrial: 0,selectedProductList: [],channelList: [],itemTemplateModel: null,
  itemVariantModel: null,
  uploadedImageList: [],contactNumberList: [],channelParterName: ''
  );
  isUpdate =0;
  soId = '';
  isEditDetails = false;
  resetControllers();
  selectedUNVCustomer = '';
  verifiedCustomerLocation = '';
 selectedExistingCustomer = '';
 }

 resetControllers(){
  state = state.copyWith(customerInfoModel: null);
  verifiedCustomerLocation = '';
  customerNameController.clear();
  shopNameController.clear();
  numberController.clear();
  searchController.clear();
  channelPartnerController.clear();
  bookAppointmentController.clear();
  verfiyTypeController.clear();
  remarksController.clear();
  deliveryDateController.clear();
 }

 resetControllersWhenSwitchCustomType(){
  state = state.copyWith(customerInfoModel: null,contactNumberList: [],);
  selectedProductCategoryIndex = 0;
  selectedshop = '';
  selectedVerificationType = '';
  customerNameController.clear();
  shopNameController.clear();
  numberController.clear();
  searchController.clear();
  channelPartnerController.clear();
 }


 updateVisitType(int index){
  if(state.tabBarIndex !=index){
resetControllersWhenSwitchCustomType();
  }  
  state = state.copyWith(selectedVisitType: index);
 }



increaseTabBarIndex(int index){
    state = state.copyWith(tabBarIndex: index);    
  }

  deceraseTabBarIndex(){
    state = state.copyWith(tabBarIndex: state.tabBarIndex-1);    
  }


  onChangedVerificationType(val){ 
    verfiyTypeController.text = val;
    selectedVerificationType = val;
    resetControllersWhenSwitchCustomType();
    if(val.toString().toLowerCase()=="verified"){
    }
    else{
    }
  }


checkRegistrationValidation(){
  if(formKey.currentState!.validate()){
    increaseTabBarIndex(1);
  }
}

convertInSelectproductedListFromResume(ViewSalesItem model){
  List<SalesItemVariantSendModel> modelList = model.itemsTemplate!.map((e) {
  return SalesItemVariantSendModel(
    itemTemplate: e.itemTemplate ?? '',
    list: e.items!.map((item) {
      return ItemVariant(
       item.itemCode?? '',
       item.itemName ?? '',
       int.parse((double.parse(item.qty.toString()).round()).toString()),
       true,
       item.itemTemplate??'',
       item.competitor ?? '',
       [],
       item.uom ?? '',
       ''
      );
    }).toList(),
  );
}).toList();
return modelList;
}

setResumeData(ViewSalesItem resumeItems){
  state = state.copyWith(
    tabBarIndex: 2,
    dealTypeValue:  int.parse((resumeItems.dealType ?? '0').toString()),
    selectedVisitType: resumeItems.customerLevel.toString().toLowerCase() == "secondary"?1:0,
    selectedProductList: convertInSelectproductedListFromResume(resumeItems)
  );
  deliveryDateController.text = resumeItems.deliveryDate??'';
  customerNameController.text = resumeItems.customerName??'';
  selectedExistingCustomer = resumeItems.customer ?? '';
  numberController.text = resumeItems.contact ?? '';
  channelPartnerController.text = resumeItems.channelPartner ?? '';
  shopNameController.text = resumeItems.shopName ?? '';
  isEditDetails = (resumeItems.custEditNeeded??'').toString() == '1'?true: false;
  isUpdate = 1;
  soId = resumeItems.name ?? '';
}


checkSalesPitchValidation(BuildContext context){
  if(state.selectedProductList.isEmpty){
    MessageHelper.showErrorSnackBar(context, "Please add your products");
  }
  else{
    increaseTabBarIndex(2);
  }
}

checkOverViewValidation(BuildContext context,{required String actionType, required String route}){
    if(state.selectedProductList.isEmpty){
    MessageHelper.showErrorSnackBar(context,"Please add your product");
  }
  else{
     bool value = state.selectedProductList.any((val) => val.list.any((items)=>items.quantity == 0));
      if(value){
        MessageHelper.showErrorSnackBar(context, "Quantity should not be empty");
      }
      else{
    createProductApiFunction(context, actionType: actionType, route: route);
      }
  }
}

/// product trial
selectProductTrialType(int index){
  state = state.copyWith(productTrial: index);
}

/// capture image list
saveCaptureImage(File img){
  state = state.copyWith(captureImageList: [...state.captureImageList, img]);
}

saveUploadedImge(value){
  state = state.copyWith(uploadedImageList: [...state.uploadedImageList, value]);
}


imageUploadApiFunction(BuildContext context, File imgFile)async{
  print(imgFile);
    ShowLoader.loader(context);
    Map<String, String> headers = {"Authorization": "Bearer ${LocalSharePreference.token}"};
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrls.imageUploadUrl));
    request.headers.addAll(headers);
      final file = await http.MultipartFile.fromPath(
        'capture_image',
        imgFile.path,
      );
      request.files.add(file);
    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    print(vb.request);
    ShowLoader.hideLoader();
    log(vb.body);
    if (vb.statusCode == 200) {
      var dataAll = json.decode(vb.body);
      saveCaptureImage(imgFile);
      saveUploadedImge(dataAll['data'][0]);
    } else if (vb.statusCode == 401) {
      LogoutHelper.logout();
    } else {
      var dataAll = json.decode(vb.body);
      MessageHelper.showErrorSnackBar(context, dataAll['message']??'');
    }
  }




channelListApiFunction(String searchText,)async{ 
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.channelPartnerurl}?search_text=$searchText", method: ApiMethod.get.name);
  if(response!=null){
    state = state.copyWith(channelList: response.data['message']);
  }
}


itemTemplateApiFunction(String searchText)async{
  state = state.copyWith(itemTemplateModel: null);
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.itemTemplateUrl}?search_text=$searchText", method:ApiMethod.get.name);
  if(response!=null){
   state = state.copyWith(itemTemplateModel: ItemTemplateModel.fromJson(response.data));
  } 
}


Future itemsVariantApiFunction(BuildContext context, { String searchText = '', String itemCategory = ''})async{ 
  ShowLoader.loader(context);
  state = state.copyWith(itemVariantModel: null);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.salesItemVariantUrl}?item_template=$searchText&item_category=$itemCategory', method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
    state = state.copyWith(itemVariantModel: ItemTemplateModel.fromJson(response.data));
    return response.data;
  }
  else{
    state = state.copyWith(itemVariantModel: null);
  }
  return response?.data;
}


createProductApiFunction(BuildContext context, {required String actionType, required String route})async{
  ShowLoader.loader(context);
  List<Map<String, dynamic>> formattedData = state.selectedProductList.map((e) {
  return e.list.map((items) {
    return {
      "item_template": e.itemTemplate,
            "item_code": items.itemCode,
            "item_name": items.itemName,
            // "item_category": items.itemCategory,
            "qty": items.quantity,
            // "competitor": items.seletedCompetitor
    };
  }).toList(); 
}).expand((x) => x).toList(); 
final body = {
   "action": actionType, //Draft or Submit
    // "customer_type": state.selectedCustomerType ==0 ? "New":"Existing",
    "customer_level": state.selectedVisitType==0? "Primary":"Secondary",
    "channel_partner":state.selectedVisitType==0? '': channelPartnerController.text,
    "customer": selectedExistingCustomer,
    "customer_name": customerNameController.text,
    "deal_type":state.dealTypeValue, //1 to 5
    "shop_name": shopNameController.text,
    "shop": selectedshop,
     "cust_edit_needed": isEditDetails ? 1 : 0,
    "contact": numberController.text,
    "remarksnotes": remarksController.text,
    "items": formattedData,
    "delivery_date": deliveryDateController.text,
    'so_id':soId,
    'isupdate': isUpdate
};
// print(body);
log(json.encode(body));

final response = await ApiService().makeRequest(apiUrl: ApiUrls.createSalesOrderUrl, method: ApiMethod.post.name,data: body);
ShowLoader.hideLoader();
if(response!=null){
  AppRouter.pushCupertinoNavigation( SuccessScreen(title: 
  '', btnTitle: "Home", onTap: (){
    Navigator.pop(context, true);
    Navigator.pop(context, true);
    if(route == 'resume'){
        Navigator.pop(context, true);
    }
  }, des: 'You have successfully ${isUpdate ==0? 'created':'updated' } the sales order'));
  // AppRouter.pushCupertinoNavigation( BookTrialSuccessScreen(id: response.data['data']?[0]?['so_id'],));
}
}

}
