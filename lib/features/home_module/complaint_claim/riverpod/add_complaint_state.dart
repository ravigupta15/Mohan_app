import 'package:mohan_impex/features/home_module/complaint_claim/model/compalint_model.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/invoice_items_model.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/invoice_model.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/view_complaint_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:riverpod/riverpod.dart';

import 'add_complaint_notifier.dart';

// Define a class to hold the multiple state variables
class AddComplaintState {
  final bool isLoading;
  final int selectedVisitType;
  final int selectedClaimTypeIndex;
  final List imgList;
  final List itemList;
  final List channerPartnerList;
  int tabBarIndex;
  int selectedRadio;
  ComplaintModel? complaintModel;
  ViewComplaintModel? viewComplaintModel;
  CustomerInfoModel? customerInfoModel;
  InvoiceModel ? invoiceModel;
  InvoiceItemsModel ? invoiceItemsModel;
  int currentPage;
  bool isLoadingMore;
  AddComplaintState({
    required this.isLoading,
    required this.selectedVisitType,
    required this.selectedClaimTypeIndex, 
    required this.imgList,
    required this.itemList, 
    required this.channerPartnerList,
    this.selectedRadio=0,this.tabBarIndex=0,
    this.complaintModel, 
    this.viewComplaintModel, 
    this.customerInfoModel,
    this.invoiceModel,
    this.invoiceItemsModel,
    this.currentPage = 1,
    this.isLoadingMore= false
  });

  AddComplaintState copyWith({bool? isLoading,int?selectedVisitType, int?selectedClaimTypeIndex, List? imgList, List? itemList, List? channerPartnerList,int? tabBarIndex, int? selectedRadio, ComplaintModel?complaintModel,ViewComplaintModel? viewComplaintModel,CustomerInfoModel? customerInfoModel,InvoiceModel ? invoiceModel,
  InvoiceItemsModel ? invoiceItemsModel,
  int? currentPage, bool? isLoadingMore
  }) {
    return AddComplaintState(
      isLoading: isLoading??this.isLoading,
      selectedVisitType: selectedVisitType??this.selectedVisitType,
      selectedClaimTypeIndex: selectedClaimTypeIndex??this.selectedClaimTypeIndex,
      imgList: imgList??this.imgList,
      itemList: itemList??this.itemList,
      channerPartnerList: channerPartnerList??this.channerPartnerList,
      selectedRadio: selectedRadio??this.selectedRadio,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      complaintModel: complaintModel??this.complaintModel,
      viewComplaintModel:viewComplaintModel??this.viewComplaintModel ,
      customerInfoModel: customerInfoModel?? this.customerInfoModel,
      invoiceModel: invoiceModel?? this.invoiceModel,
      invoiceItemsModel: invoiceItemsModel ?? this.invoiceItemsModel,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final addComplaintsProvider = StateNotifierProvider<AddComplaintNotifier, AddComplaintState>(
  (ref) => AddComplaintNotifier(),
);
