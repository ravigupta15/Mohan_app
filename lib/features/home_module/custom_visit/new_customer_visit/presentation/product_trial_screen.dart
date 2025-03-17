// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mohan_impex/api_config/api_service.dart';
// import 'package:mohan_impex/api_config/api_urls.dart';
// import 'package:mohan_impex/core/helper/dropdown_item_helper.dart';
// import 'package:mohan_impex/core/services/date_picker_service.dart';
// import 'package:mohan_impex/core/widget/app_button.dart';
// import 'package:mohan_impex/core/widget/app_date_widget.dart';
// import 'package:mohan_impex/core/widget/app_text.dart';
// import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
// import 'package:mohan_impex/core/widget/app_text_field/custom_drop_down.dart';
// import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
// import 'package:mohan_impex/core/widget/custom_app_bar.dart';
// import 'package:mohan_impex/core/widget/custom_radio_button.dart';
// import 'package:mohan_impex/core/widget/date_picker_bottom_sheet.dart';
// import 'package:mohan_impex/data/datasources/local_share_preference.dart';
// import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/item_model.dart';
// import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
// import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
// import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/timer_widget.dart';
// import 'package:mohan_impex/res/app_asset_paths.dart';
// import 'package:mohan_impex/res/app_colors.dart';
// import 'package:mohan_impex/res/app_fontfamily.dart';
// import 'package:mohan_impex/res/loader/show_loader.dart';
// import 'package:mohan_impex/res/no_data_found_widget.dart';
// import 'package:mohan_impex/utils/app_date_format.dart';
// import 'package:mohan_impex/utils/message_helper.dart';

// class ProductTrialScreen extends ConsumerStatefulWidget {
//   final NewCustomerVisitNotifier refNotifer;
//   final NewCustomerVisitState refState;
//   const ProductTrialScreen(
//       {super.key, required this.refNotifer, required this.refState});

//   @override
//   ConsumerState<ProductTrialScreen> createState() => _ProductTrialScreenState();
// }

// class _ProductTrialScreenState extends ConsumerState<ProductTrialScreen> {
//   int selectedTrialType = 0;

//   final bookAppointmentController = TextEditingController();
//   final trialLocationController = TextEditingController();
//   final visitTypeController = TextEditingController();
//   final customerNameController = TextEditingController();
//   final shopNameController = TextEditingController();
//   final contactNumberController = TextEditingController();
//   final locationController = TextEditingController();
//   final addressTypeController = TextEditingController();
//   final address1Controller = TextEditingController();
//   final address2Controller = TextEditingController();
//   final districtController = TextEditingController();
//   final stateController = TextEditingController();
//   final pincodeController = TextEditingController();
//   final dateController = TextEditingController();
//   final timeController = TextEditingController();

//   final formKey = GlobalKey<FormState>();
//   List<Items> selectedItem = [];

//   @override
//   void initState() {
//     Future.microtask(() {
//       callInitFunction();
//     });
//     super.initState();
//   }

//   ItemModel? itemModel;

//   callInitFunction() {
//     final refNotifier = ref.read(newCustomVisitProvider.notifier);
//     final refState = ref.watch(newCustomVisitProvider);
//     itemsApiFunction(context, '');
//     customerNameController.text = refNotifier.customerNameController.text;
//     visitTypeController.text = refState.selectedVisitType == 0
//         ? "Primary"
//         : refState.selectedVisitType == 1
//             ? "Secondary"
//             : "";
//     shopNameController.text = refNotifier.shopNameController.text;
//     contactNumberController.text = refNotifier.numberController.text;
//     locationController.text = LocalSharePreference.currentAddress;
//     addressTypeController.text = refNotifier.addressTypeController.text;
//     address1Controller.text = refNotifier.address1Controller.text;
//     address2Controller.text = refNotifier.address2Controller.text;
//     districtController.text = refNotifier.districtController.text;
//     stateController.text = refNotifier.stateController.text;
//     pincodeController.text = refNotifier.pincodeController.text;
//   }

//   DateTime? selectedDate;

//   List trialLocation = ["On Site", 'R&D Lab'];

//   TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0); // Default time
//   DateTime selectedDay = DateTime.now(); // Track the selected day
//   DateTime focusedDay = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(title: "Product Trial", actions: [
//         timerWidget(ref.watch(newCustomVisitProvider).currentTimer)
//       ]),
//       body: SingleChildScrollView(
//         padding:
//             const EdgeInsets.only(left: 15, right: 15, top: 14, bottom: 20),
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               selectItemWidget(),
//               const SizedBox(
//                 height: 15,
//               ),
//               bookAppointmentWidget(),
//               const SizedBox(
//                 height: 15,
//               ),
//               trialTypeWidget(),
//               const SizedBox(
//                 height: 30,
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: AppButton(
//                   title: "Submit",
//                   color: AppColors.arcticBreeze,
//                   height: 44,
//                   width: 150,
//                   onPressed: () {
//                     _handleValidation();
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget selectItemWidget() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       decoration: BoxDecoration(
//         color: AppColors.itemsBG,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.e2Color),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               AppText(
//                 title: 'Selected Items',
//                 fontFamily: AppFontfamily.poppinsSemibold,
//                 fontsize: 12,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   addItemBottomSheet(context);
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(
//                           color: AppColors.lightBlue62Color, width: .5)),
//                   padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.add,
//                         color: AppColors.lightBlue62Color,
//                         size: 15,
//                       ),
//                       AppText(
//                         title: "Add Items",
//                         fontsize: 12,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           selectedItem.isNotEmpty
//               ? Container(
//                   decoration: BoxDecoration(
//                       color: AppColors.whiteColor,
//                       border: Border.all(color: AppColors.e2Color, width: .5),
//                       borderRadius: BorderRadius.circular(10)),
//                   padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
//                   child: ListView.separated(
//                       separatorBuilder: (ctx, sb) {
//                         return const SizedBox(
//                           height: 15,
//                         );
//                       },
//                       itemCount: selectedItem.length,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         return Row(
//                           children: [
//                             Expanded(
//                                 child: AppText(
//                               title: selectedItem[index].itemName ?? '',
//                               maxLines: 1,
//                             )),
//                             InkWell(
//                                 onTap: () {
//                                   selectedItem[index].isSelected = false;
//                                   selectedItem.removeAt(index);
//                                   setState(() {});
//                                 },
//                                 child:
//                                     SvgPicture.asset(AppAssetPaths.deleteIcon))
//                           ],
//                         );
//                       }),
//                 )
//               : AppTextfield(
//                   fillColor: false,
//                   isReadOnly: true,
//                   hintText: "Please add items",
//                 )
//         ],
//       ),
//     );
//   }

//   Widget trialTypeWidget() {
//     return Container(
//       padding: EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 15),
//       decoration: BoxDecoration(
//         color: AppColors.itemsBG,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.e2Color),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AppText(
//             title: "Select Trial Type",
//             fontFamily: AppFontfamily.poppinsSemibold,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             children: [
//               customRadioButton(
//                   isSelected: selectedTrialType == 0 ? true : false,
//                   title: 'Self',
//                   onTap: () {
//                     selectedTrialType = 0;
//                     setState(() {});
//                   }),
//               const Spacer(),
//               customRadioButton(
//                   isSelected: selectedTrialType == 1 ? true : false,
//                   title: 'TSM Required',
//                   onTap: () {
//                     selectedTrialType = 1;
//                     setState(() {});
//                   }),
//               const Spacer(),
//             ],
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               LabelTextTextfield(
//                 title: "Trial Location",
//                 isRequiredStar: false,
//                 fontFamily: AppFontfamily.poppinsSemibold,
//                 textColor: AppColors.black1,
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               CustomDropDown(
//                 items: DropdownItemHelper().dropdownListt(trialLocation),
//                 onChanged: (val) {
//                   trialLocationController.text = val;
//                   setState(() {});
//                 },
//                 validator: (val) {
//                   if ((val ?? '').isEmpty) {
//                     return "Select trail location";
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               LabelTextTextfield(
//                 title: "Visit Type",
//                 isRequiredStar: false,
//                 fontFamily: AppFontfamily.poppinsSemibold,
//                 textColor: AppColors.black1,
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               AppTextfield(
//                 fillColor: false,
//                 isReadOnly: true,
//                 controller: visitTypeController,
//                 suffixWidget: Icon(Icons.expand_more),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               LabelTextTextfield(
//                 title: "Customer Name",
//                 isRequiredStar: false,
//                 fontFamily: AppFontfamily.poppinsSemibold,
//                 textColor: AppColors.black1,
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               AppTextfield(
//                 fillColor: false,
//                 isReadOnly: true,
//                 controller: customerNameController,
//                 suffixWidget: Icon(Icons.expand_more),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               LabelTextTextfield(
//                 title: "Shop Name",
//                 isRequiredStar: false,
//                 fontFamily: AppFontfamily.poppinsSemibold,
//                 textColor: AppColors.black1,
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               AppTextfield(
//                 fillColor: false,
//                 controller: shopNameController,
//                 isReadOnly: true,
//                 suffixWidget: Icon(Icons.expand_more),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               LabelTextTextfield(
//                 title: "Contact No.",
//                 isRequiredStar: false,
//                 fontFamily: AppFontfamily.poppinsSemibold,
//                 textColor: AppColors.black1,
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               AppTextfield(
//                 fillColor: false,
//                 isReadOnly: true,
//                 controller: contactNumberController,
//                 suffixWidget: Container(
//                   height: 33,
//                   width: 33,
//                   decoration: BoxDecoration(
//                       color: AppColors.greenColor,
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Icon(
//                     Icons.add,
//                     color: AppColors.whiteColor,
//                     size: 20,
//                   ),
//                 ),
//               ),
//               (widget.refState.contactNumberList).isNotEmpty
//                   ? SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       padding: EdgeInsets.only(top: 10),
//                       child: Row(
//                         children: widget.refState.contactNumberList.map((e) {
//                           return Stack(
//                             children: [
//                               Container(
//                                   margin: EdgeInsets.symmetric(horizontal: 6),
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 2),
//                                   decoration: BoxDecoration(
//                                       color: AppColors.lightEBColor,
//                                       borderRadius: BorderRadius.circular(25)),
//                                   alignment: Alignment.center,
//                                   child: AppText(title: e)),
//                               Positioned(
//                                 right: 0,
//                                 top: 0,
//                                 child: InkWell(
//                                   onTap: () {
//                                     widget.refState.contactNumberList.remove(e);
//                                     setState(() {});
//                                   },
//                                   child: Container(
//                                     height: 12,
//                                     width: 12,
//                                     decoration: BoxDecoration(
//                                         color: AppColors.cardBorder,
//                                         shape: BoxShape.circle),
//                                     child: Icon(
//                                       Icons.close,
//                                       size: 10,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     )
//                   : Container(),
//               const SizedBox(
//                 height: 15,
//               ),
//               LabelTextTextfield(
//                 title: "Location",
//                 isRequiredStar: false,
//                 fontFamily: AppFontfamily.poppinsSemibold,
//                 textColor: AppColors.black1,
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               AppTextfield(
//                 fillColor: false,
//                 controller: locationController,
//                 isReadOnly: true,
//                 suffixWidget: Icon(Icons.expand_more),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               LabelTextTextfield(title: 'Address-1', isRequiredStar: true),
//               const SizedBox(height: 5),
//               AppTextfield(
//                 hintText: "Enter address1",
//                 fillColor: false,
//                 textInputAction: TextInputAction.next,
//                 controller: address1Controller,
//               ),
//               const SizedBox(height: 15),
//               LabelTextTextfield(title: 'Address-2', isRequiredStar: true),
//               const SizedBox(height: 5),
//               AppTextfield(
//                 hintText: "Enter address2",
//                 fillColor: false,
//                 controller: address2Controller,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: 15),
//               LabelTextTextfield(title: 'State', isRequiredStar: true),
//               const SizedBox(height: 5),
//               AppTextfield(
//                 hintText: "Enter state",
//                 fillColor: false,
//                 controller: stateController,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: 15),
//               LabelTextTextfield(title: 'District', isRequiredStar: true),
//               const SizedBox(height: 5),
//               AppTextfield(
//                 hintText: "Enter district",
//                 fillColor: false,
//                 controller: districtController,
//                 textInputAction: TextInputAction.next,
//               ),
//               const SizedBox(height: 15),
//               LabelTextTextfield(title: 'Pincode', isRequiredStar: true),
//               const SizedBox(height: 5),
//               AppTextfield(
//                 hintText: "Enter pincode",
//                 fillColor: false,
//                 isReadOnly: true,
//                 controller: pincodeController,
//                 textInputAction: TextInputAction.next,
//                 textInputType: TextInputType.number,
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               dateTimeWidget(),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   dateTimeWidget() {
//     return Row(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             LabelTextTextfield(title: "Date", isRequiredStar: false),
//             const SizedBox(
//               height: 10,
//             ),
//             AppDateWidget(
//               title: dateController.text,
//               onTap: () {
//                 datePickerBottomsheet(context);
//               },
//             )
//           ],
//         ),
//         const Spacer(),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             LabelTextTextfield(title: "Time", isRequiredStar: false),
//             const SizedBox(
//               height: 10,
//             ),
//             AppDateWidget(
//               hintText: 'HH-MM',
//               title: timeController.text,
//               onTap: () {
//                 _selectTime(context);
//               },
//             )
//           ],
//         ),
//         const Spacer(),
//       ],
//     );
//   }

//   datePickerBottomsheet(
//     BuildContext context,
//   ) {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         backgroundColor: AppColors.whiteColor,
//         context: context,
//         builder: (context) {
//           return Builder(builder: (context) {
//             return Padding(
//               padding: const EdgeInsets.only(
//                   top: 20, left: 10, right: 10, bottom: 10),
//               child: StatefulBuilder(builder: (context, state) {
//                 return ViewDatePickerWidget(
//                     selectedDay: selectedDay,
//                     focusedDay: focusedDay,
//                     onDaySelected: (selectedDay, focusedDay) {
//                       state(() {});
//                       this.selectedDay = selectedDay;
//                       this.focusedDay = focusedDay;
//                       setState(() {});
//                     },
//                     applyTap: () {
//                       state(() {});
//                       setState(() {});
//                       dateController.text =
//                           AppDateFormat.datePickerView(selectedDay);
//                       Navigator.pop(context);
//                     });
//               }),
//             );
//           });
//         });
//   }

//   addItemBottomSheet(BuildContext context) {
//     // final refState = ref.watch(newCustomVisitProvider);
//     showModalBottomSheet(
//         backgroundColor: AppColors.whiteColor,
//         isScrollControlled: true,
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, state) {
//             return Container(
//               padding: EdgeInsets.only(
//                   top: 14, bottom: MediaQuery.of(context).viewInsets.bottom),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 11),
//                     child: Row(
//                       children: [
//                         const Spacer(),
//                         AppText(
//                           title: "Select Items",
//                           fontsize: 16,
//                           fontFamily: AppFontfamily.poppinsSemibold,
//                         ),
//                         const Spacer(),
//                         InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             height: 24,
//                             width: 24,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 color: AppColors.edColor,
//                                 shape: BoxShape.circle),
//                             child: Icon(
//                               Icons.close,
//                               size: 19,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: AppTextfield(
//                       fillColor: false,
//                       suffixWidget: Container(
//                         padding: EdgeInsets.all(10),
//                         child: SvgPicture.asset(AppAssetPaths.searchIcon),
//                       ),
//                       onChanged: (val) {
//                         _onChangedSearchForItem(val, state);
//                       },
//                     ),
//                   ),
//                   (itemModel?.data?.length ?? 0) > 0
//                       ? ListView.separated(
//                           separatorBuilder: (ctx, index) {
//                             return const SizedBox(
//                               height: 10,
//                             );
//                           },
//                           shrinkWrap: true,
//                           padding: EdgeInsets.only(
//                               left: 15, right: 15, top: 10, bottom: 10),
//                           itemCount: (itemModel?.data?.length ?? 0),
//                           itemBuilder: (ctx, index) {
//                             var model = itemModel?.data![index];
//                             return Container(
//                               height: 40,
//                               alignment: Alignment.centerLeft,
//                               decoration: BoxDecoration(
//                                   border: Border(
//                                       bottom: BorderSide(
//                                           width: 1,
//                                           color: AppColors.light92Color
//                                               .withValues(alpha: .5)))),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                       child: AppText(
//                                     title: model?.itemName ?? '',
//                                     maxLines: 1,
//                                   )),
//                                   InkWell(
//                                     onTap: () {
//                                       bool isMatchingItemFound =
//                                           selectedItem.any((selectedValue) {
//                                         return model?.itemCode ==
//                                             selectedValue.itemCode ? true : false;
//                                       });
//                                       if(isMatchingItemFound){
//                                       MessageHelper.showToast("Already added");
//                                       }
//                                       else{
//                                         if (model?.isSelected == false) {
//                                         model?.isSelected = true;
//                                         selectedItem.add(model!);
//                                       } else {
//                                         model?.isSelected = false;
//                                         for (int i = 0;
//                                             i < selectedItem.length;
//                                             i++) {
//                                           if (selectedItem[i].isSelected ==
//                                               false) {
//                                             selectedItem.removeAt(i);
//                                           }
//                                         }
//                                       }
//                                       }
//                                       state(() {});
//                                     },
//                                     child: Container(
//                                       height: 20,
//                                       width: 20,
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           color: AppColors.edColor,
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       child: Icon(
//                                         (model?.isSelected ?? false) == false
//                                             ? Icons.add
//                                             : Icons.remove,
//                                         size: 20,
//                                         color: (model?.isSelected ?? false) ==
//                                                 false
//                                             ? AppColors.greenColor
//                                             : AppColors.redColor,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           })
//                       : NoDataFound(title: "No items found")
//                 ],
//               ),
//             );
//           });
//         });
//   }

//   _onChangedSearchForItem(String val, state) {
//     if (val.isEmpty) {
//       itemsApiFunction(context, '');
//     } else {
//       itemsApiFunction(context, val).then((val) {
//         if (val != null) {}
//       });
//     }
//     state(() {});
//   }

//   Widget bookAppointmentWidget() {
//     return Container(
//       padding: EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 15),
//       decoration: BoxDecoration(
//         color: AppColors.itemsBG,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.e2Color),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AppText(
//             title: "Book Appointment",
//             fontFamily: AppFontfamily.poppinsSemibold,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           AppTextfield(
//             fillColor: false,
//             isReadOnly: true,
//             controller: bookAppointmentController,
//             onTap: () {
//               DatePickerService.datePicker(context, selectedDate: selectedDate)
//                   .then((picked) {
//                 if (picked != null) {
//                   var day = picked.day < 10 ? '0${picked.day}' : picked.day;
//                   var month =
//                       picked.month < 10 ? '0${picked.month}' : picked.month;
//                   bookAppointmentController.text = "${picked.year}-$month-$day";
//                   setState(() {
//                     selectedDate = picked;
//                   });
//                 }
//               });
//             },
//             suffixWidget: Container(
//               height: 33,
//               width: 33,
//               margin: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                   color: AppColors.greenColor,
//                   borderRadius: BorderRadius.circular(5)),
//               child: Icon(
//                 Icons.add,
//                 color: AppColors.whiteColor,
//                 size: 20,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   _handleValidation() {
//     if (formKey.currentState!.validate()) {
//       if (bookAppointmentController.text.isEmpty) {
//         MessageHelper.showErrorSnackBar(
//             context, "Please select appointment date.");
//       } else if (selectedItem.isEmpty) {
//         MessageHelper.showErrorSnackBar(context, "Please add items.");
//       } else if (dateController.text.isEmpty && timeController.text.isEmpty) {
//         MessageHelper.showErrorSnackBar(context, "Please select date and time");
//       } else {
//         callApiFunction();
//       }
//     }
//   }

//   callApiFunction() async {
//     ShowLoader.loader(context);
//     final body = {
//       "conduct_by": selectedTrialType == 0 ? "Self" : "Tsm Required",
//       "trial_type": "Item",
//       "trial_location": trialLocationController.text,
//       "verific_type": widget.refNotifer.verfiyTypeController.text.isEmpty
//           ? "Unverified"
//           : widget.refNotifer.verfiyTypeController.text,
//       "customer_level": visitTypeController.text,
//       "channel_partner": widget.refState.channelParterName,
//       "unv_customer_name": widget.refNotifer.verfiyTypeController.text == 'Unverified'
//           ? customerNameController.text
//           : "",
//         "unv_customer":   widget.refNotifer.verfiyTypeController.text == 'Unverified'? widget.refNotifer.unvName:'',
//       "customer":widget.refNotifer.verfiyTypeController.text == 'Unverified'? "": widget.refState.selectedExistingCustomer,
//       "customer_name":widget.refNotifer.verfiyTypeController.text == 'Unverified'? "": customerNameController.text,
//       "shop_name": shopNameController.text,
//       "contact": widget.refState.contactNumberList.map((e) {
//         return {"contact": e.toString()};
//       }).toList(),
//       "location": widget.refState.selectedCustomerType == 0? '':widget.refNotifer.verifiedCustomerLocation,
//       "address_title": addressTypeController.text,
//       "address_line1": address1Controller.text,
//       "address_line2": address2Controller.text,
//       "district": districtController.text,
//       "state": stateController.text,
//       "pincode": pincodeController.text,
//       "appointment_date": bookAppointmentController.text,
//       "remarksnotes": widget.refNotifer.remarksController.text,
//       "date": dateController.text,
//       "time": timeController.text,
//       "item_trial_table": selectedItem.map((e) {
//         return {"item_name": e.itemName, "item_code": e.itemCode};
//       }).toList()
//     };
//     print(body);
//     final response = await ApiService().makeRequest(
//         apiUrl: ApiUrls.trialPlanUrl, method: ApiMethod.post.name, data: body);
//     ShowLoader.hideLoader();
//     if (response != null) {
//       widget.refState.hasProductTrial = 1;
//       MessageHelper.showSuccessSnackBar(context, response.data['message']);
//       Navigator.pop(context);
//     }
//   }

//   Future itemsApiFunction(
//     BuildContext context,
//     String searchText,
//   ) async {
//     itemModel = null;
//     final response = await ApiService().makeRequest(
//         apiUrl:
//             '${ApiUrls.itemListUrl}?fields=["item_code", "item_name","item_category", "competitor"]&filters=[["item_name", "like", "%$searchText%"]]',
//         method: ApiMethod.get.name);
//     if (response != null) {
//       itemModel = ItemModel.fromJson(response.data);

//       return response;
//     } else {}
//     setState(() {});
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     // Display the time picker
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//     );

//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked; // Update the selected time
//         final hour = _selectedTime.hour < 10
//             ? '0${_selectedTime.hour}'
//             : '${_selectedTime.hour}';
//         final minute = _selectedTime.minute < 10
//             ? '0${_selectedTime.minute}'
//             : '${_selectedTime.minute}';
//         timeController.text = "$hour-$minute";
//       });
//     }
//   }
// }
