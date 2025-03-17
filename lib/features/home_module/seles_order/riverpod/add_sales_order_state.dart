import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/item_template_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class AddSalesOrderState {
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
ItemTemplateModel? itemTemplateModel;
ItemTemplateModel? itemVariantModel;
List<SalesItemVariantSendModel> selectedProductList;
CustomerInfoModel? customerInfoModel;
 List contactNumberList;
 var selectedUnvModel = ();
 String channelParterName;
 int dealTypeValue;
 String visitStartDate;
 int hasProductTrial;
  AddSalesOrderState({required this.isLoading,required this.tabBarIndex, required this.currentTimer, required this.selectedCustomerType,required this.selectedVisitType, required this.customerName, required this.shopName, required this.addQuantity, required this.captureImageList,required this.uploadedImageList, this.productTrial=0,
  required this.channelList,this.itemTemplateModel, this.itemVariantModel, required this.selectedProductList,this.customerInfoModel,required this.contactNumberList,  this.channelParterName = '',this.dealTypeValue=1, this.visitStartDate = '', this.hasProductTrial=0,
  });

  AddSalesOrderState copyWith({  bool? isLoading, int? tabBarIndex, int? currentTimer, int?selectedCustomerType,
  int? selectedVisitType, String? customerName, String? shopName, int?addQuantity,List?captureImageList,int?productTrial, List? uploadedImageList,  List? channelList, ItemTemplateModel?itemTemplateModel,
  ItemTemplateModel?itemVariantModel,
  List<SalesItemVariantSendModel>?selectedProductList, CustomerInfoModel?customerInfoModel,List?contactNumberList, String?channelParterName,int?dealTypeValue, String?visitStartDate,int?hasProductTrial,
  }) {
    return AddSalesOrderState(
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
      itemVariantModel: itemVariantModel??this.itemVariantModel,
      itemTemplateModel: itemTemplateModel??this.itemTemplateModel,
      selectedProductList: selectedProductList??this.selectedProductList,
      customerInfoModel: customerInfoModel??this.customerInfoModel,
      contactNumberList: contactNumberList??this.contactNumberList,
      channelParterName: channelParterName??this.channelParterName,
      dealTypeValue: dealTypeValue??this.dealTypeValue,
      visitStartDate: visitStartDate??this.visitStartDate,
      hasProductTrial: hasProductTrial??this.hasProductTrial,
    );
  }
}



final addSalesOrderProvider  =StateNotifierProvider<AddSalesOrderNotifier,AddSalesOrderState>((ref)=>AddSalesOrderNotifier());
