import 'package:mohan_impex/features/home_module/complaint_claim/model/compalint_model.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/view_complaint_model.dart';
import 'package:riverpod/riverpod.dart';

import 'add_complaint_notifier.dart';

// Define a class to hold the multiple state variables
class AddComplaintState {
  final bool isLoading;
  final int selectedCustomerType;
  final int selectedClaimTypeIndex;
  final List imgList;
  final List itemList;
  final List channerPartnerList;
  int tabBarIndex;
  int selectedRadio;
  ComplaintModel? complaintModel;
  ViewComplaintModel? viewComplaintModel;
  AddComplaintState({required this.isLoading,required this.selectedCustomerType,required this.selectedClaimTypeIndex, required this.imgList, required this.itemList, required this.channerPartnerList,this.selectedRadio=0,this.tabBarIndex=0,this.complaintModel, this.viewComplaintModel});

  AddComplaintState copyWith({bool? isLoading,int?selectedCustomerType, int?selectedClaimTypeIndex, List? imgList, List? itemList, List? channerPartnerList,int? tabBarIndex, int? selectedRadio, ComplaintModel?complaintModel,ViewComplaintModel? viewComplaintModel}) {
    return AddComplaintState(
      isLoading: isLoading??this.isLoading,
      selectedCustomerType: selectedCustomerType??this.selectedCustomerType,
      selectedClaimTypeIndex: selectedClaimTypeIndex??this.selectedClaimTypeIndex,
      imgList: imgList??this.imgList,
      itemList: itemList??this.itemList,
      channerPartnerList: channerPartnerList??this.channerPartnerList,
      selectedRadio: selectedRadio??this.selectedRadio,
      tabBarIndex: tabBarIndex??this.tabBarIndex,
      complaintModel: complaintModel??this.complaintModel,
      viewComplaintModel:viewComplaintModel??this.viewComplaintModel 
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final addComplaintsProvider = StateNotifierProvider<AddComplaintNotifier, AddComplaintState>(
  (ref) => AddComplaintNotifier(),
);
