// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mohan_impex/core/widget/app_text_button.dart';
// import 'package:mohan_impex/core/widget/custom_app_bar.dart';
// import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
// import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/deal_type_widget.dart';
// import 'package:mohan_impex/res/app_asset_paths.dart';
// import 'package:mohan_impex/res/app_colors.dart';
// import 'package:mohan_impex/res/app_fontfamily.dart';

// import '../../../../core/widget/app_text.dart';

// class ViewDraftOrderScreen extends StatefulWidget {
//   const ViewDraftOrderScreen({super.key});

//   @override
//   State<ViewDraftOrderScreen> createState() => _ViewDraftOrderScreenState();
// }

// class _ViewDraftOrderScreenState extends State<ViewDraftOrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(title: "Order Draft"),
//       body: Padding(
//          padding: const EdgeInsets.only(top: 12),
//         child: Column(
//           children: [
//             tabbarWidget(),
//              const SizedBox(height: 10,),
//             Align(
//                 alignment: Alignment.center,
//                 child: AppText(title: "Overview"
//                  ,fontFamily: AppFontfamily.poppinsSemibold,)),
//                 const SizedBox(height: 20,),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: EdgeInsets.only(left: 15,right: 15,bottom: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _AddedProductWidget(),
//                       const SizedBox(height: 15,),
//                       _AdditionalDetailsWidget(),
//                       const SizedBox(height: 15,),
//                       RemarksWidget(),
//                       const SizedBox(height: 15,),
//                       _ActivityWidget(),
//                       const SizedBox(height: 20,),
//                       Align(
//                         alignment: Alignment.center,
//                         child: AppTextButton(title: "Resume",color: AppColors.arcticBreeze,
//                         height: 42,width: 110,
//                         ),
//                       )
//                     ],
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }

//   tabbarWidget(){
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _roundedContainer(bgColor: AppColors.greenColor,borderColor: AppColors.greenColor),

//         Padding(padding: EdgeInsets.symmetric(horizontal: 6),
//         child: _divider(AppColors.greenColor),),

//         _roundedContainer(bgColor:
//          AppColors.greenColor ,borderColor : AppColors.greenColor ),
        
//         Padding(padding: EdgeInsets.symmetric(horizontal: 6),
//         child: _divider(AppColors.greenColor),),

//         _roundedContainer(bgColor:AppColors.black,borderColor:
//          AppColors.black),
//       ],
//     );
//   }
// _divider(Color color){
//   return Container(
// width: 50,color: color,height: 1,
//   );
// }
//  _roundedContainer({required Color bgColor, required Color borderColor}){
//     return Container(
//       height: 16,width: 16,
//       decoration: BoxDecoration(
//         border: Border.all(color: borderColor),
//         color: bgColor,
//         shape: BoxShape.circle
//       ),
//     );
//   }

// }


// class _AddedProductWidget extends StatelessWidget {
//   const _AddedProductWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//          Align(
//               alignment: Alignment.centerRight,
//               child: AppText(title: 'Add Products',
//               fontsize: 12,color: AppColors.oliveGray,
//               fontFamily: AppFontfamily.poppinsSemibold,),
//             ),
//             const SizedBox(height: 6,),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
//           decoration: BoxDecoration(
//             color:AppColors.itemsBG,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: AppColors.e2Color),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AppText(title: 'Added Items',
//               fontsize: 14,color: AppColors.black,
//               fontFamily: AppFontfamily.poppinsSemibold,),
//                 const SizedBox(height: 10,),
//                expandWidget()
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   expandWidget(){
//     return Container(
//          decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.e2Color),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 14,vertical: 16),
//       child: Column(
//             children: [
//           productItemWidget(1),
//           const SizedBox(height: 12,),
//           productItemWidget(2),
//           const SizedBox(height: 12,),
//           productItemWidget(3),
//             ],
//           ),
//       );
//   }

// productItemWidget(int index){
//   return Row(
//     children: [
//       AppText(title: "Item $index",fontFamily: AppFontfamily.poppinsMedium,fontsize: 12,),
//       addedProductWidget(),
//       SvgPicture.asset(AppAssetPaths.deleteIcon)
//     ],
//   );
// }

//   addedProductWidget(){
//     return  Expanded(
//       child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               customContainerForAddRemove(isAdd: false),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 9),
//                 child: AppText(title: "2"),
//               ),
//               customContainerForAddRemove(isAdd: true),
//             ],
//           ),
//     );
//   }

// Widget customContainerForAddRemove({required bool isAdd}){
//     return InkWell(
//       onTap: (){},
//       child: Container(
//         height: 18,width: 18,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: AppColors.edColor,
//           borderRadius: BorderRadius.circular(4)
//         ),
//         child: Icon(isAdd? Icons.add:Icons.remove,
//         size: 16,
//         color: isAdd?AppColors.greenColor:AppColors.redColor,
//         ),
//       ),
//     );
//   }

// }


// class _AdditionalDetailsWidget extends StatelessWidget {
//   const _AdditionalDetailsWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//           AppText(title: "Additional Details",fontFamily: AppFontfamily.poppinsSemibold,),
//           const SizedBox(height: 14,),
//          DealTypeWidget(),
//          const SizedBox(height: 15,),
//          _CustomInfoWidget()
//       ],
//     );
//   }
// }



// class _CustomInfoWidget extends StatelessWidget {
//   const _CustomInfoWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, 0),
//             color: AppColors.black.withValues(alpha: .2),
//             blurRadius: 10
//           )
//         ]
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//             AppText(title: "Customer Information",fontFamily:AppFontfamily.poppinsSemibold,),
//             const SizedBox(height: 10,),
//               itemsWidget("Channel Partner", "Channel Partner name"),
//               const SizedBox(height: 19,),
//             itemsWidget("Vendor Name", "Ramesh"),
//             const SizedBox(height: 19,),
//             itemsWidget("Shop Name", "Ammas"),
//             const SizedBox(height: 19,),
//             itemsWidget("Contact", "7049234489"),
//             const SizedBox(height: 19,),
//             itemsWidget("Location", "123, Market Street"),
//         ],
//       ),
//     );
//   }

//   Widget itemsWidget(String title, String subTitle){
//     return Row(
//       children: [
//         AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
//         AppText(title: subTitle,
//         fontsize: 13,
//         fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
//       ],
//     );
//   }
// }


// class _ActivityWidget extends StatelessWidget {
//   const _ActivityWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 11),
//           decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(offset: Offset(0, 0),color: AppColors.black.withValues(alpha: .2),blurRadius: 10)
//         ]
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//               AppText(title: 'Activity',fontFamily: AppFontfamily.poppinsSemibold,),
//               Icon(Icons.expand_less,color: AppColors.light92Color,),
//         ],
//       ),
//     );
//   }
// }