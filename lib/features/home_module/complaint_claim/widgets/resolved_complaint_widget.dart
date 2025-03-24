// import 'package:flutter/material.dart';
// import 'package:mohan_impex/features/home_module/complaint_claim/riverpod/add_complaint_notifier.dart';
// import 'package:mohan_impex/features/home_module/complaint_claim/riverpod/add_complaint_state.dart';
// import 'package:mohan_impex/features/home_module/complaint_claim/widgets/complaint_items_widget.dart';
// import 'package:mohan_impex/res/app_colors.dart';
// import 'package:mohan_impex/res/no_data_found_widget.dart';
// import 'package:mohan_impex/res/shimmer/list_shimmer.dart';

// class ResolvedComplaintWidget extends StatelessWidget {
//    final AddComplaintNotifier refNotifer;
//   final AddComplaintState refState;
//   const ResolvedComplaintWidget({super.key,required this.refNotifer,required this.refState});

//   @override
//   Widget build(BuildContext context) {
//     return refState.isLoading?
//     CustomerVisitShimmer(isShimmer: refState.isLoading, isKyc: false):
//     (refState.complaintModel?.data?[0].records?.length??0)>0
//     ?ListView.separated(
//       separatorBuilder: (ctx,sb){
//         return const SizedBox(height: 15,);
//       },
//       itemCount:  (refState.complaintModel?.data?[0].records?.length??0),
//       padding: EdgeInsets.only(top: 10,bottom: 20,left:17,right: 17),
//       shrinkWrap: true,
//       itemBuilder: (ctx,index){
//           var model = refState.complaintModel?.data?[0].records?[index];
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(5),
//             boxShadow: [
//               BoxShadow(
//                 offset: Offset(0, 0),
//                 color: AppColors.black.withValues(alpha: .2),
//                 blurRadius: 3
//               )
//             ]
//           ),
//           child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                      ComplaintItemsWidget(
//                   title:"Ticket #${model?.name??''}",
//                   name: model?.username??'',
//                   date: model?.date??'',reasonTitle: model?.claimType??'', status: "Resolved",),
//                     ],
//           ),
//         );
//     }): NoDataFound(title: "No resolved tickets found");
//   }
// }