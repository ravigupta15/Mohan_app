import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/competitor_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/product_item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/product_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/unv_customer_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class NewCustomerVisitState {
  final bool isLoading;
  final int tabBarIndex;
  final int currentTimer;
final int selectedCustomerType;
final int selectedVisitType;
final String customerName;
final String shopName;
final int addQuantity;
final List captureImageList;
final List uploadedImageList;
final int productTrial;
final List channelList;
CompetitorModel? competitorModel;
ItemModel? itemModel;
List<ProductSendModel> selectedProductList;
CustomerInfoModel? customerInfoModel;
 List contactNumberList;
 var selectedUnvModel = ();
 String channelParterName;
 int dealTypeValue;
 String visitStartDate;
 int hasProductTrial;
 ProductModel? productModel;
 ProductItemModel? productItemModel;
 StateModel?stateModel;
  DistrictModel? districtModel;
  UNVCustomerModel? unvCustomerModel;
  String visitStartLatitude;
 String visitStartLetitude;
 String visitEndLatitude;
 String visitEndLetitude;
  NewCustomerVisitState({required this.isLoading,required this.tabBarIndex, required this.currentTimer, required this.selectedCustomerType,required this.selectedVisitType, required this.customerName, required this.shopName, required this.addQuantity, required this.captureImageList,required this.uploadedImageList, this.productTrial=0,
  required this.channelList,this.competitorModel, this.itemModel, required this.selectedProductList,this.customerInfoModel,required this.contactNumberList,  this.channelParterName = '',this.dealTypeValue=1, this.visitStartDate = '', this.hasProductTrial=0, this.productModel,this.productItemModel,
  this.stateModel,this.districtModel, this.unvCustomerModel,
  this.visitEndLatitude ='',this.visitEndLetitude = '',this.visitStartLatitude='',this.visitStartLetitude=''
  });

  NewCustomerVisitState copyWith({  bool? isLoading, int? tabBarIndex, int? currentTimer, int?selectedCustomerType,
  int? selectedVisitType, String? customerName, String? shopName, int?addQuantity,List?captureImageList,int?productTrial, List? uploadedImageList,  List? channelList,CompetitorModel? competitorModel, ItemModel?itemModel,
  List<ProductSendModel>?selectedProductList, CustomerInfoModel?customerInfoModel,List?contactNumberList, String?channelParterName,int?dealTypeValue, String?visitStartDate,int?hasProductTrial,
  ProductModel? productModel,ProductItemModel? productItemModel,StateModel?stateModel,
  DistrictModel? districtModel,UNVCustomerModel? unvCustomerModel,
  String? visitStartLatitude, String? visitStartLetitude, String? visitEndLatitude, String? visitEndLetitude,
 
  }) {
    return NewCustomerVisitState(
      isLoading: isLoading??this.isLoading,
      tabBarIndex: tabBarIndex?? this.tabBarIndex,
      currentTimer: currentTimer??this.currentTimer,
      selectedCustomerType: selectedCustomerType??this.selectedCustomerType,
      selectedVisitType: selectedVisitType??this.selectedVisitType,
      customerName: customerName??this.customerName,
      shopName: shopName??this.shopName,
      addQuantity: addQuantity??this.addQuantity,
      captureImageList: captureImageList??this.captureImageList,
      productTrial: productTrial??this.productTrial,
      uploadedImageList: uploadedImageList??this.uploadedImageList,
      channelList: channelList??this.channelList,
      competitorModel: competitorModel??this.competitorModel,
      itemModel: itemModel??this.itemModel,
      selectedProductList: selectedProductList??this.selectedProductList,
      customerInfoModel: customerInfoModel??this.customerInfoModel,
      contactNumberList: contactNumberList??this.contactNumberList,
      channelParterName: channelParterName??this.channelParterName,
      dealTypeValue: dealTypeValue??this.dealTypeValue,
      visitStartDate: visitStartDate??this.visitStartDate,
      hasProductTrial: hasProductTrial??this.hasProductTrial,
      productModel: productModel??this.productModel,
      productItemModel: productItemModel??this.productItemModel,
      districtModel: districtModel??this.districtModel,
      stateModel: stateModel??this.stateModel,
      // customerAddressModel: customerAddressModel??this.customerAddressModel,
      unvCustomerModel:unvCustomerModel??this.unvCustomerModel ,
      visitEndLatitude: visitEndLatitude??this.visitEndLatitude,
      visitEndLetitude: visitEndLetitude??this.visitEndLetitude,
      visitStartLatitude: visitStartLatitude??this.visitStartLatitude,
      visitStartLetitude: visitStartLetitude??this.visitStartLetitude
    );
  }
}



final newCustomVisitProvider  =StateNotifierProvider<NewCustomerVisitNotifier,NewCustomerVisitState>((ref)=>NewCustomerVisitNotifier());
