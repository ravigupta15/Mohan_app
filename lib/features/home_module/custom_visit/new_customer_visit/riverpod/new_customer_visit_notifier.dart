// Define a StateNotifier to manage the state
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/competitor_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/product_item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/product_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/logout_helper.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;


class NewCustomerVisitNotifier extends StateNotifier<NewCustomerVisitState> {
  NewCustomerVisitNotifier() : super(NewCustomerVisitState(isLoading: false,tabBarIndex: 0, currentTimer: 0,
  selectedCustomerType: 0,selectedVisitType: 0,customerName: '',shopName: '',addQuantity: 0, captureImageList: [1],
  uploadedImageList: [],channelList: [],selectedProductList: [],contactNumberList: [],selectedExistingCustomer:'' ));

Timer? timer;

final customerNameController = TextEditingController();
final shopNameController = TextEditingController();
final numberController = TextEditingController();
final channelPartnerController = TextEditingController();
final remarksController  = TextEditingController();
 final searchController = TextEditingController();
 final bookAppointmentController = TextEditingController();

final formKey = GlobalKey<FormState>();


updateLoading(bool isLoading){
  state = state.copyWith(isLoading: isLoading);
}

 resetValues(){
  timer?.cancel();
  state = state.copyWith(currentTimer: 0,selectedCustomerType: 0,selectedVisitType: 0,tabBarIndex: 0,captureImageList: [1],addQuantity: 0,customerName: '',isLoading: false,shopName: '',productTrial: 0,selectedProductList: [],channelList: [],competitorModel: null,customerInfoModel: null,itemModel: null,uploadedImageList: [],contactNumberList: [],selectedExistingCustomer:'',channelParterName: '',productModel: null);
  customerNameController.clear();
  shopNameController.clear();
  numberController.clear();
  searchController.clear();
  channelPartnerController.clear();
  bookAppointmentController.clear();

 }

 updateCustomerType(int index){
  state = state.copyWith(selectedCustomerType: index);
 }

 updateVisitType(int index){
  state = state.copyWith(selectedVisitType: index);
 }



increaseTabBarIndex(int index){
    state = state.copyWith(tabBarIndex: index);    
  }

  deceraseTabBarIndex(){
    state = state.copyWith(tabBarIndex: state.tabBarIndex-1);    
  }


startTimer(){
timer = Timer.periodic(Duration(seconds: 1), (val){
    state = state.copyWith(currentTimer:state.currentTimer+1);
  });
}

checkRegistrationValidation(){
  if(formKey.currentState!.validate()){
    if(state.contactNumberList.isEmpty){
      state.contactNumberList.add(numberController.text);
    }
    increaseTabBarIndex(1);
  }
}

checkSalesPitchValidation(BuildContext context){
   if(remarksController.text.isEmpty){
    MessageHelper.showErrorSnackBar(context, "Please add your remarks");
  }
  else{
    increaseTabBarIndex(2);
  }
}

checkOverViewValidation(BuildContext context,{required String actionType}){
  // if(state.selectedProductList.isEmpty){
  //   MessageHelper.showToast("Please add your product");
  // }
   if(bookAppointmentController.text.isEmpty){
    MessageHelper.showToast("Please select appointment date");
  }
  else if(state.uploadedImageList.isEmpty){
    MessageHelper.showToast( "Please upload the image");
  }
  else if(state.productTrial==0){
    MessageHelper.showToast("Please select product trial type");
  }
  else{
    createProductApiFunction(actionType: actionType);
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

customerInfoApiFunction(String searchText)async{ 
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.getCustomerurl}?search_text=$searchText", method: ApiMethod.get.name);
  if(response!=null){
    state = state.copyWith(customerInfoModel: CustomerInfoModel.fromJson(response.data));
  }
}

productApiFunction(String searchText)async{
  // state = state.copyWith(productModel: null);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.productUrl}?fields=["product_name"]&filters=[["product_name", "like", "%$searchText%"]]', method:ApiMethod.get.name);
  if(response!=null){
   state = state.copyWith(productModel: ProductModel.fromJson(response.data));
   print(state.productModel?.data);
  } 
}

productItemApiFunction(BuildContext context, {required String productItem})async{
  state = state.copyWith(productItem: null);
  ShowLoader.loader(context);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.productUrl}?product=$productItem', method:ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
   state = state.copyWith(productItem: ProductItem.fromJson(response.data));
  } 
}

competitorApiFunction(BuildContext context)async{ 
  ShowLoader.loader(context);
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.competitorUrl, method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
    state = state.copyWith(competitorModel: CompetitorModel.fromJson(response.data));
  }
}


Future itemsApiFunction(BuildContext context, String searchText)async{ 
  ShowLoader.loader(context);
  state = state.copyWith(itemModel: null);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.itemListUrl}?fields=["item_code", "item_name","item_category", "competitor"]&filters=[["item_name", "like", "%$searchText%"]]', method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
    print(response.data);
    state = state.copyWith(itemModel: ItemModel.fromJson(response.data));
    return response;
  }
  else{
    state = state.copyWith(itemModel: null);
  }
  return response?.data;
}

// shopApiFunction(BuildContext context)async{ 
//   ShowLoader.loader(context);
//   final response = await ApiService().makeRequest(apiUrl: ApiUrls.shopUrl, method: ApiMethod.get.name);
//   ShowLoader.hideLoader();
//   if(response!=null){
//     // state = state.copyWith(competitorModel: CompetitorModel.fromJson(response.data));
//   }
// }


createProductApiFunction({required String actionType})async{
final body = {
   "action": actionType, //Draft or Submit
    "is_new_customer": state.selectedCustomerType==0? 1: 0,
    "customer_level": state.selectedVisitType==0? "Primary":"Secondary",
    "channel_partner":state.channelParterName,
    "customer": state.selectedExistingCustomer,
    "customer_name": customerNameController.text,
    "deal_type":state.dealTypeValue, //1 to 5
    "lead_priority": "Hot",
    "has_product_trial": state.hasProductTrial, //1 or 0
    "shop_name": shopNameController.text,
    "contact": state.contactNumberList.map((e){
      return {"contact": e.toString()};
    }).toList(),
    "appointment_date": bookAppointmentController.text,
    "latitude":LocalSharePreference.currentLatitude,
    "longitude": LocalSharePreference.currentLongitude,
    "remarksnotes": remarksController.text,
    "visit_start": state.visitStartDate,
    "visit_end": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString(),
    "visit_duration": state.currentTimer,
    "product_trial": [ //if product trial
        {
            "item": "Maggie"
        }
    ],
    "product_pitching": [
        {
            "product": "Bread",
            "item": "Noodles",
            "product_category": "BP",
            "competitor": "",
            "qty": 1
        }
    ],
    // "captured_images": state.captureImageList
};

final response = await ApiService().makeRequest(apiUrl: ApiUrls.createCVMurl, method: ApiMethod.post.name,data: body);
if(response!=null){

}
}

}
