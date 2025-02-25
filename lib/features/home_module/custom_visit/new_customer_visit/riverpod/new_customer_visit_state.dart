import 'package:mohan_impex/features/home_module/custom_visit/model/competitor_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/product_item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/product_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
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
 String selectedExistingCustomer;
 String channelParterName;
 int dealTypeValue;
 String visitStartDate;
 int hasProductTrial;
 ProductModel? productModel;
 ProductItem? productItem;
  NewCustomerVisitState({required this.isLoading,required this.tabBarIndex, required this.currentTimer, required this.selectedCustomerType,required this.selectedVisitType, required this.customerName, required this.shopName, required this.addQuantity, required this.captureImageList,required this.uploadedImageList, this.productTrial=0,
  required this.channelList,this.competitorModel, this.itemModel, required this.selectedProductList,this.customerInfoModel,required this.contactNumberList, required this.selectedExistingCustomer, this.channelParterName = '',this.dealTypeValue=0, this.visitStartDate = '', this.hasProductTrial=0, this.productModel,this.productItem
  });

  NewCustomerVisitState copyWith({  bool? isLoading, int? tabBarIndex, int? currentTimer, int?selectedCustomerType,
  int? selectedVisitType, String? customerName, String? shopName, int?addQuantity,List?captureImageList,int?productTrial, List? uploadedImageList,  List? channelList,CompetitorModel? competitorModel, ItemModel?itemModel,
  List<ProductSendModel>?selectedProductList, CustomerInfoModel?customerInfoModel,List?contactNumberList, String?selectedExistingCustomer, String?channelParterName,int?dealTypeValue, String?visitStartDate,int?hasProductTrial,
  ProductModel? productModel,ProductItem? productItem
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
      selectedExistingCustomer: selectedExistingCustomer??this.selectedExistingCustomer ,
      channelParterName: channelParterName??this.channelParterName,
      dealTypeValue: dealTypeValue??this.dealTypeValue,
      visitStartDate: visitStartDate??this.visitStartDate,
      hasProductTrial: hasProductTrial??this.hasProductTrial,
      productModel: productModel??this.productModel,
      productItem: productItem??this.productItem
    );
  }
}



final newCustomVisitProvider  =StateNotifierProvider<NewCustomerVisitNotifier,NewCustomerVisitState>((ref)=>NewCustomerVisitNotifier());
