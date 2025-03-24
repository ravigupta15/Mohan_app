// Define a StateNotifier to manage the state
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/core/services/location_service.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/view_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/api_response_model/create_order_response_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/competitor_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/product_item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/product_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/unv_customer_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/book_trial_success_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/logout_helper.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;


class NewCustomerVisitNotifier extends StateNotifier<NewCustomerVisitState> {
  NewCustomerVisitNotifier() : super(NewCustomerVisitState(isLoading: false,tabBarIndex: 0, currentTimer: 0,
  selectedCustomerType: 0,selectedVisitType: 0,customerName: '',shopName: '',addQuantity: 0, captureImageList: [1],
  uploadedImageList: [],channelList: [],selectedProductList: [],contactNumberList: [] ));

/// trial product
String trialType = '';
String trialConductType = '';
List trailItems = [];


Timer? timer;
 String? selectedDistrictValue;
  String? selectedStateValue;
  String selectedVerificationType = '';
  String selectedExistingCustomer = '';
  String selectedshop = '';
 bool isReadOnlyFields = false;
 bool isEditDetails = false;
 
  int selectedProductCategoryIndex= 0;

final customerNameController = TextEditingController();
final shopNameController = TextEditingController();
final numberController = TextEditingController();
final channelPartnerController = TextEditingController();
final remarksController  = TextEditingController();
 final searchController = TextEditingController();
 final bookAppointmentController = TextEditingController();
//  final verfiyTypeController = TextEditingController();

 String verifiedCustomerLocation = '';

 ///
//  String unvName = '';   
 final addressTypeController = TextEditingController();
 final address1Controller = TextEditingController();
 final address2Controller = TextEditingController();
 final districtController = TextEditingController();
 final stateController = TextEditingController();
 final pincodeController = TextEditingController();


final formKey = GlobalKey<FormState>();


updateLoading(bool isLoading){
  state = state.copyWith(isLoading: isLoading);
}

 resetValues(){
  timer?.cancel();
  state = state.copyWith(currentTimer: 0,selectedCustomerType: 0,selectedVisitType: 0,tabBarIndex: 0,captureImageList: [1],addQuantity: 0,customerName: '',isLoading: false,shopName: '',productTrial: 0,selectedProductList: [],channelList: [],competitorModel: null,customerInfoModel: null,itemModel: null,uploadedImageList: [],contactNumberList: [],channelParterName: '',productModel: null,
  visitEndLatitude: '',visitEndLetitude: '',visitStartLatitude: '',visitStartLetitude: '',
  dealTypeValue: 1
  
  );
  isEditDetails = false;
  resetControllers();
  selectedDistrictValue =null;
  selectedStateValue= null;
  isReadOnlyFields=false;
  selectedshop = '';
  // selectedUNVCustomer = '';
  verifiedCustomerLocation = '';
 selectedExistingCustomer = '';
 trailItems = [];
 trialConductType = '';
 trialType = '';
 }

 resetControllers(){
  state = state.copyWith(customerInfoModel: null,unvCustomerModel: null);
  verifiedCustomerLocation = '';
  selectedshop ='';
  selectedVerificationType = '';
  customerNameController.clear();
  shopNameController.clear();
  numberController.clear();
  // verfiyTypeController.clear();
  searchController.clear();
  channelPartnerController.clear();
  bookAppointmentController.clear();
  address1Controller.clear();
  address2Controller.clear();
  districtController.clear();
  stateController.clear();
  addressTypeController.clear();
  pincodeController.clear();
  addressTypeController.clear();
  // verfiyTypeController.clear();
  remarksController.clear();
 }

 resetControllersWhenSwitchCustomType({bool isResetChannel = true}){
  state = state.copyWith(customerInfoModel: null,unvCustomerModel: null,contactNumberList: [],);
  selectedProductCategoryIndex = 0;
  customerNameController.clear();
  shopNameController.clear();
  numberController.clear();
  searchController.clear();
  if(isResetChannel){
channelPartnerController.clear();
  }
  bookAppointmentController.clear();
  address1Controller.clear();
  address2Controller.clear();
  districtController.clear();
  stateController.clear();
  addressTypeController.clear();
  pincodeController.clear();
  addressTypeController.clear();
  selectedDistrictValue = null;
  selectedStateValue = null;
 }

 updateCustomerType(int index){
    if(state.selectedCustomerType != index){
    resetControllersWhenSwitchCustomType();
  }
  state = state.copyWith(selectedCustomerType: index); 
 }

 updateVisitType(int index){
  if(state.selectedVisitType != index){
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


startTimer(){
timer = Timer.periodic(Duration(seconds: 1), (val){
    state = state.copyWith(currentTimer:state.currentTimer+1);
  });
}

  onChangedState(BuildContext context, val) {
    stateController.text = val;
    districtApiFunction(context, stateText: val);
  }

  onChangedDistrict(val) {
    districtController.text = val;
  }

  onChangedVerificationType(val){ 
    selectedVerificationType = val;
    resetControllersWhenSwitchCustomType();
    if(val.toString().toLowerCase()=="verified"){
    }
    else{
    }
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
  if(state.selectedProductList.isEmpty){
    MessageHelper.showErrorSnackBar(context, "Please add your products");
  }
   else if(remarksController.text.isEmpty){
    MessageHelper.showErrorSnackBar(context, "Please add your remarks");
  }
  else{
    increaseTabBarIndex(2);
  }
}

checkOverViewValidation(BuildContext context,{required String actionType, required String route}){
  LocationService().startLocationUpdates().then((val){
    state = state.copyWith(visitEndLatitude: val.latitude.toString(),visitEndLetitude: val.longitude.toString());
  });
  if(state.selectedProductList.isEmpty){
    MessageHelper.showErrorSnackBar(context,"Please add your product");
  }
  else if(state.uploadedImageList.isEmpty){
    MessageHelper.showErrorSnackBar(context, "Please upload the image");
  }
  else if(state.productTrial==0){
    MessageHelper.showErrorSnackBar(context,"Please select product trial type");
  }
  else{
     bool value = state.selectedProductList.any((val) => val.list.any((items)=>items.quantity == 0));
      if(value){
        MessageHelper.showErrorSnackBar(context, "Quantity should not be empty");
      }
      else{
    createProductApiFunction(context, actionType: actionType,route:  route);
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


convertInSelectproductedListFromResume(VisitItemsModel model){
  List<ProductSendModel> modelList = model.productPitching!.map((e) {
  return ProductSendModel(
    productType: e.product,
    list: e.item!.map((item) {
      return ProductItem(
        item.competitor ??'',
        item.qty,
        true,
        item.itemCategory ?? '',
        item.product ?? '',
        item.name,
        item.itemCode,
        item.uom
      );
    }).toList(),
  );
}).toList();
return modelList;
}

setResumeData(BuildContext context, VisitItemsModel model){ 
  List contactList = (model.contact??[]).map((e)=>e.contact).toList();
    state = state.copyWith(tabBarIndex: 2,
    currentTimer: (model.visitDuration?.toDouble() ?? 0.0).toInt(),
    selectedCustomerType: model.customerType.toString().toLowerCase() == "new"? 0: 1,
    visitStartDate: model.visitStart,
    channelParterName:  model.channelPartner,
    captureImageList: model.imageUrl,
    selectedVisitType: model.customerLevel.toString().toLowerCase() == "primary"?0:1,
    selectedProductList: convertInSelectproductedListFromResume(model),
    dealTypeValue: int.parse((model.dealType ?? '0').toString()),
    contactNumberList: contactList,
    hasProductTrial: model.hasTrialPlan,
    );
     isEditDetails = model.custEditNeeded.toString() == '1'? true : false; 
    selectedExistingCustomer = model.customer ?? '';
    verifiedCustomerLocation = model.location ?? '';
    selectedshop = model.shop ?? '';
    selectedVerificationType = model.verificType ?? '';
    trialConductType = model.conductBy ?? '';
    trialType  = model.trialType ?? '';
    trailItems = model.itemTrial ?? [];

    

    customerNameController.text = model.customerName ?? '';
    shopNameController.text = model.shopName ?? '';
    addressTypeController.text = model.addressTitle?? '';
    address1Controller.text = model.addressLine1 ?? '';
    address2Controller.text = model.addressLine2 ?? '';
    pincodeController.text = model.pincode ?? '';
    channelPartnerController.text = model.channelPartner ?? '';

    remarksController.text = model.remarksnotes ?? '';
    bookAppointmentController.text = model.appointmentDate ?? '';
    districtController.text = model.district ?? '';
    numberController.text = model.contact?[0].contact;
    stateController.text = model.state ?? '';
    stateApiFunction(context);
    if((model.state ?? '').isNotEmpty){
      selectedStateValue = model.state;
      districtApiFunction(context, stateText: model.state);
      selectedDistrictValue = model.district;
    }
    
    
    startTimer();
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

customerInfoApiFunction({required String searchText, String channelPartern = '', String visitType = '', String verificationType = ''})async{ 
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.customerUrl}?search_text=$searchText&customer_level=$visitType&channel_partner=$channelPartern&verification_type=$verificationType", method: ApiMethod.get.name);
  if(response!=null){
    state = state.copyWith(customerInfoModel: CustomerInfoModel.fromJson(response.data));
  }
}

unvCustomerApiFunction(String searchText)async{
  state = state.copyWith(unvCustomerModel: null);
   final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.unvCustomerUrl}?search_text=$searchText", method: ApiMethod.get.name);
  if(response!=null){
    state = state.copyWith(unvCustomerModel: UNVCustomerModel.fromJson(response.data));
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

productApiFunction(String searchText)async{
  state = state.copyWith(productModel: null);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.productUrl}?search_text=$searchText', method:ApiMethod.get.name);
  if(response!=null){
   state = state.copyWith(productModel: ProductModel.fromJson(response.data));
   print(state.productModel?.data);
  } 
}

Future productItemApiFunction(BuildContext context, {required String productTitle,  String itemCategory = "MP"})async{
  state = state.copyWith(productItemModel: null);
  ShowLoader.loader(context);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.productItemUrl}?product=$productTitle&item_category=$itemCategory', method:ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
   state = state.copyWith(productItemModel: ProductItemModel.fromJson(response.data));
   print("dsfcsd..${state.productItemModel?.data}");
   return response.data;
  } 
}

competitorApiFunction(BuildContext context, String searchText)async{ 
  ShowLoader.loader(context);
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.competitorUrl}?search_text=$searchText", method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
    state = state.copyWith(competitorModel: CompetitorModel.fromJson(response.data));
  }
}

Future itemsApiFunction(BuildContext context, String searchText)async{ 
  ShowLoader.loader(context);
  state = state.copyWith(itemModel: null);
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.salesItemVariantUrl}?item_template=$searchText&item_category=', method: ApiMethod.get.name);
  ShowLoader.hideLoader();
  if(response!=null){
    state = state.copyWith(itemModel: ItemModel.fromJson(response.data));
    return response.data;
  }
  else{
    state = state.copyWith(itemModel: null);
  }
  return response?.data;
}

updatehasProductTrial(int val){
  state = state.copyWith(hasProductTrial: val);
} 

void detailsBack(List list){
  print("list...$list");
  trialType = list[0];
  trialConductType = list[1];
  trailItems = list[2];
}


createProductApiFunction(BuildContext context, {required String actionType, required String route})async{
  ShowLoader.loader(context);
  List<Map<String, dynamic>> formattedData = state.selectedProductList.map((e) {
  return e.list.map((items) {
    return {
      "product": e.productType, 
      "item_name": items.name ?? '',
      "item_code":items.itemCode??'',
      "item_category": items.productCategory,
      "competitor": items.seletedCompetitor, 
      "qty": items.quantity, 
    };
  }).toList(); 
}).expand((x) => x).toList(); 

String unvCustomer  = state.selectedCustomerType ==0 ? customerNameController.text :
      selectedVerificationType.toLowerCase() =='verified'? '' : selectedExistingCustomer;

String unvCustomerName = state.selectedCustomerType ==0 ? customerNameController.text : selectedVerificationType.toLowerCase() =='verified'? '' : customerNameController.text;

String customer = state.selectedCustomerType ==0 ? '': selectedVerificationType.toLowerCase() =='verified'? selectedExistingCustomer : '';

String customerName = state.selectedCustomerType ==0 ? '': selectedVerificationType.toLowerCase() =='verified'? customerNameController.text : '';

final body = {
   "action": actionType, //Draft or Submit
    "customer_type": state.selectedCustomerType ==0 ? "New":"Existing",
    "customer_level": state.selectedVisitType==0? "Primary":"Secondary",
    "verific_type": selectedVerificationType.isEmpty ? 'Unverified':selectedVerificationType,
    "channel_partner":state.selectedVisitType==1? channelPartnerController.text : '',
    "unv_customer": unvCustomer,
    "unv_customer_name":unvCustomerName,
    "customer": customer,
    "customer_name":customerName,
    "deal_type":state.dealTypeValue == 0 ? 1 : state.dealTypeValue, //1 to 5
    "has_product_trial": state.productTrial == 1? state.hasProductTrial : 0, //1 or 0
    "shop_name": shopNameController.text,
    "shop": selectedshop,
    "contact": state.contactNumberList.map((e){
      return {"contact": e.toString()};
    }).toList(),
    "location": state.selectedCustomerType ==1 ?verifiedCustomerLocation: LocalSharePreference.currentAddress ,
    "address_title": addressTypeController.text,
    "address_line1": address1Controller.text,
    "address_line2": address2Controller.text,
    "district": districtController.text,
    "state": stateController.text,
    "pincode":pincodeController.text,
    // "appointment_date": bookAppointmentController.text,
    "latitude":LocalSharePreference.currentLatitude,
    "longitude": LocalSharePreference.currentLongitude,
    "remarksnotes": remarksController.text,
    "visit_start": state.visitStartDate,
    "visit_end": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString(),
    "visit_duration": state.currentTimer,
    "product_trial": state.productTrial == 1 && trialType.toLowerCase() == 'product' ? trailItems : [],
    "item_trial":state.productTrial == 1 && trialType.toLowerCase() == 'item' ? trailItems:[] , // if trial plan is item,
    "conduct_by":state.productTrial == 1 ? trialConductType : '', // if trial plan,
    "trial_type": state.productTrial == 1 ? trialType : '', // if trial plan,
    "product_pitching": formattedData,
    "captured_images": state.uploadedImageList,
    "cust_edit_needed": isEditDetails ? 1 :0
};
// print(body);
log(json.encode(body));

final response = await ApiService().makeRequest(apiUrl: ApiUrls.createCVMurl, method: ApiMethod.post.name,data: body);
ShowLoader.hideLoader();
if(response!=null){
  CreateOrderResponseModel model = CreateOrderResponseModel.fromJson(response.data);
  AppRouter.pushCupertinoNavigation( BookTrialSuccessScreen(id: model.data?[0].cvm??'',route: route,));
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


convertToOrderApiFunction(BuildContext context, String id)async{
  ShowLoader.loader(context);
  final body = {
    "cvm_id":id
  };
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.convertToOrderUrl, method: ApiMethod.post.name,data: body);
  ShowLoader.hideLoader();
  if(response!=null){
    MessageHelper.showSuccessSnackBar(context, response.data['message']);
        Navigator.pop(context);
         Navigator.pop(context,true);
  }
}

locationValidationApiFunction(BuildContext context)async{
  ShowLoader.loader(context);
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.locationValidationurl}?destination=${state.visitStartLatitude}, ${state.visitStartLetitude}&origin=${state.visitEndLatitude}, ${state.visitEndLetitude}", method: ApiMethod.get.name);
 ShowLoader.hideLoader();
  if(response!=null){

  }
}
}
