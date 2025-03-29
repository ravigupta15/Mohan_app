import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/helper/dropdown_item_helper.dart';
import 'package:mohan_impex/core/services/image_picker_service.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/invoice_items_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_address_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/documents_widget.dart';
import 'package:mohan_impex/features/home_module/search/presentation/search_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import '../../../../../core/services/date_picker_service.dart';
import '../../../../../core/widget/app_text_field/custom_drop_down.dart';
import '../../../../../utils/app_validation.dart';
// import '../../../../auth/sign-in/riverpod/sign_in_state.dart';
import '../riverpod/add_complaint_notifier.dart';
import '../riverpod/add_complaint_state.dart';

class AddComplaintScreen extends ConsumerStatefulWidget {
  const AddComplaintScreen({super.key});

  @override
  ConsumerState<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends ConsumerState<AddComplaintScreen>
    with AppValidation {
  // int selectedClaimTypeIndex = 1;
  DateTime? startDate;
  DateTime? expiryDate;
  DateTime? mfdDate;
  DateTime? endDate;
 String  itemSelectedValue = '';
 final searchController = TextEditingController();

  @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(addComplaintsProvider.notifier);
    refNotifier.resetValues();
    refNotifier.channelPartnerApiFunction();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final addComplaintState =
        ref.watch(addComplaintsProvider); 
    final addComplaintNotifier = ref.read(addComplaintsProvider
        .notifier); 
    return Scaffold(
      appBar: customAppBar(title: "Complaints & Claim"),
      body: SingleChildScrollView(
        child: Form(
          key: addComplaintNotifier.formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 14, left: 18, right: 18, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customerTypeWidget(
                    addComplaintNotifier: addComplaintNotifier,
                    addComplaintState: addComplaintState),
                
                addComplaintState.selectedVisitType == 0 ? EmptyWidget():
                 Padding(
                   padding: const EdgeInsets.only(top: 15),
                   child: Column(
                     children: [
                       LabelTextTextfield(title: 'Channel Partner', isRequiredStar: true),
                       const SizedBox(height: 15),
                                   CustomDropDown(
                    hintText: "Select channel partner",
                    items: companyNameDropDownItem(addComplaintState.channerPartnerList),
                    onChanged: addComplaintNotifier.onChangedChannelPartner,
                    validator: (val) {
                      if ((val ?? "").isEmpty) {
                        return "Select partner channel";
                      }
                      return null;
                    },
                    ),
                                  
                     ],
                   ),
                 ),
                const SizedBox(
                  height: 14,
                ),
                LabelTextTextfield(title: "Date", isRequiredStar: true),
                const SizedBox(
                  height: 15,
                ),
                AppTextfield(
                  hintText: "YYYY-MM-DD",
                  fillColor: true,
                  controller: addComplaintNotifier.dateController,
                  isReadOnly: true,
                  onTap: (){
                          DatePickerService.datePicker(context,
                            selectedDate: startDate)
                        .then((picked) {
                      if (picked != null) {
                        var day =
                            picked.day < 10 ? '0${picked.day}' : picked.day;
                        var month = picked.month < 10
                            ? '0${picked.month}'
                            : picked.month;
                        addComplaintNotifier.dateController.text =
                            "${picked.year}-$month-$day";
                        setState(() {
                          startDate = picked;
                        });
                      }
                    });
                  },
                  validator: (val){
                    if((val??'').isEmpty){
                      return "Select date";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                claimTypeWidget(addComplaintNotifier: addComplaintNotifier,addComplaintState: addComplaintState),
                const SizedBox(
                  height: 15,
                ),
                  textfieldWithTitleWidget(
                  title: "Subject",
                  controller: addComplaintNotifier.subjectController,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the subject";
                    }
                    return null;
                  },
                ),
                // textfieldWithTitleWidget(
                //   title: "Company Name",
                //   controller: addComplaintNotifier.companyNameController,
                //   textInputAction: TextInputAction.next,
                //   validator: (val) {
                //     if (val!.isEmpty) {
                //       return "Enter Company Name";
                //     }
                //     return null;
                //   },
                // ),

                const SizedBox(
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "Contact Person Name",
                  controller: addComplaintNotifier.contactPersonNameController,
                  textInputAction: TextInputAction.next,
                  isReadOnly: true,
                  onTap: (){
                    _handleCustomerName(refNotifer: addComplaintNotifier, refState: addComplaintState);
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter contact person name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "Shop Name",
                  controller: addComplaintNotifier.shopNameController,
                  textInputAction: TextInputAction.next,
                  isReadOnly: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter shop name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                textfieldWithTitleWidget(
                    title: "Contact",
                    controller: addComplaintNotifier.contactController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    isReadOnly: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    validator: numberValidation,
                    suffix: Container(
                      decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                        size: 30,
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "State",
                  controller: addComplaintNotifier.stateNameController,
                  textInputAction: TextInputAction.next,
                  isReadOnly: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter State";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "District",
                  controller: addComplaintNotifier.townTypeController,
                  textInputAction: TextInputAction.next,
                  isReadOnly: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter District";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "Pincode",
                  controller: addComplaintNotifier.pincodeController,
                  isReadOnly: true,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6)
                  ],
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Pincode";
                    }
                    else if(val.length<6){
                      return "Enter valid pincode";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                    LabelTextTextfield(
                        title: "Invoice no", isRequiredStar: true),
                        // & Date
                    const SizedBox(
                      height: 15,
                    ),
                    CustomDropDown(
                      selectedValue: addComplaintNotifier.selectedInvoice,
                      items: DropdownItemHelper().invoiceList((addComplaintState.invoiceModel?.data ?? [])),
                     hintText: "Invoice no",
                     onChanged: (val){
                      addComplaintNotifier.onChangedInvoiceNo(context, val);
                     },
                     validator: (val){
                      if ((val ?? '').isEmpty) {
                        return "Select Invoice no";
                         }
                       return null;
                     },
                    ),
                     const SizedBox(
                      height: 15,
                    ),
                LabelTextTextfield(title: 'Invoice Date', isRequiredStar: true),
              const SizedBox(
                      height: 15,
                    ),
                 AppTextfield(
                          fillColor: false,
                          isReadOnly: true,
                          hintText: 'Invoice date',
                          controller: addComplaintNotifier.invoiceDateController,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Select Invoice date";
                            }
                            return null;
                          },
                        ),
               const SizedBox(
                      height: 15,
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabelTextTextfield(title: 'Item', isRequiredStar: true),
                    InkWell(
                      onTap: (){
                        if(addComplaintNotifier.invoiceNoController.text.isEmpty){
                          MessageHelper.showErrorSnackBar(context, "Select invoice no");
                        }

                        else if(addComplaintNotifier.checkItemsValueIsEmpty()){
                          MessageHelper.showErrorSnackBar(context, "Values should not be empty");
                        }
                        else{
                        addComplaintNotifier.increaseSelectedItemsList();
                        }
                        setState(() {
                          
                        });
                      },
                      child: Icon( Icons.add,
                                      color: AppColors.greenColor,
                                        size: 25,
                                  ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                itemsWidget(refNotifer: addComplaintNotifier, refState: addComplaintState),         
                const SizedBox(
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "Reason for Complaint",
                  controller: addComplaintNotifier.reasonController,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Reason for Complaint";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                imageWidget(refNotifier: addComplaintNotifier, refState: addComplaintState),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: AppButton(
                  title: "Submit",
                  color: AppColors.arcticBreeze,
                  height: 40,
                  width: 120,
                  onPressed: () {
                    addComplaintNotifier.checkValidation(context);
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget itemsWidget({required AddComplaintNotifier refNotifer, required AddComplaintState refState,}){
  return  ListView.separated(
    separatorBuilder: (ctx,sb){
      return const SizedBox(height: 15,);
    },
    shrinkWrap: true,
    physics: const ScrollPhysics(),
    itemCount: refNotifer.selectedItemsList.length,
    itemBuilder: (context,index) {
      var model = refNotifer.selectedItemsList[index];
      return ExpandableWidget(
          initExpanded: false,
          collapsedWidget: collpasedWidget(isExpanded: true, refNotifer: refNotifer, refState: refState, model: model),
         expandedWidget: expandedWidget(isExpanded: false, refNotifer: refNotifer, refState: refState,model: model));
    }
  );
  }

collpasedWidget({required AddComplaintNotifier refNotifer, required AddComplaintState refState,required bool isExpanded, InvoiceItemRecords? model}){
  return Container(
    padding: isExpanded? EdgeInsets.all(12) : null,
   child: Column(
    children: [
      Row(
        children: [
          LabelTextTextfield(title: 'Item', isRequiredStar: true),
          const Spacer(),
          refNotifer.selectedItemsList.length>1 && isExpanded?
          InkWell(
            onTap: (){
              refNotifer.selectedItemsList.remove(model);
              setState(() {
              });
            },
            child: Container(
              padding: const EdgeInsets.only(right: 15,left: 15),
              color: AppColors.whiteColor,
              child: SvgPicture.asset(AppAssetPaths.deleteIcon,colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn),))) : EmptyWidget(),
           Icon(
            !isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.light92Color,
          ),
        ],
      )
    ],
   ),
  );
}

expandedWidget({required AddComplaintNotifier refNotifer, required AddComplaintState refState,required bool isExpanded,InvoiceItemRecords? model}){
  return Container(
   padding: !isExpanded? EdgeInsets.all(12) : null,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        collpasedWidget(refNotifer: refNotifer, refState: refState, isExpanded: isExpanded), 
        const SizedBox(height: 13,),
        CustomDropDown(
          selectedValue: model?.selectedDropdownValue,
          items: DropdownItemHelper().invoiceItemList(refState.invoiceItemsModel?.data??[]),
        onChanged: (val){
          model?.selectedDropdownValue = val;
          refState.invoiceItemsModel?.data?.forEach((value){
            if(value.itemName == val){
              model?.itemQuantityController.text = value.qty.toString();
              model?.valueOfGoodsController.text = value.amount.toString();
              model?.selectedItemName = value.itemName;
              model?.selectedItemCode = value.itemCode;
              setState(() {
              });
            }
          });
        },
        ),
        const SizedBox(
                    height: 10,
                  ),
          textfieldWithTitleWidget(
                    title: "Complaint Item Quantity",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    isReadOnly: true,
                    controller: model?.itemQuantityController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Complaint Item Quantity";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textfieldWithTitleWidget(
                    title: "Value of Goods",
                    controller: model?.valueOfGoodsController,
                    textInputAction: TextInputAction.next,
                    isReadOnly: true,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Value of Goods";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textfieldWithTitleWidget(
                    title: "Batch no.",
                    controller: model?.batchNoController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Batch no.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textfieldWithTitleWidget(
                    title: "MFD",
                    controller: model?.mfdDateController,
                    isReadOnly: true,
                    onTap: (){
                         DatePickerService.datePicker(context,
                              selectedDate:  model?.mfdDate)
                          .then((picked) {
                        if (picked != null) {
                          var day =
                              picked.day < 10 ? '0${picked.day}' : picked.day;
                          var month = picked.month < 10
                              ? '0${picked.month}'
                              : picked.month;
                          model?.mfdDateController.text =
                              "${picked.year}-$month-$day";
                          setState(() {
                           model?.mfdDate = picked;
                            if ((model?.expiryDateController.text ?? '').isNotEmpty && (model?.mfdDate)!.isAfter((model?.expiryDate)!)) {
                             model?.expiryDate = null;
                           model?.expiryDateController.clear();
                           }
                          });
                        }
                      });
    
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter MFD";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textfieldWithTitleWidget(
                    title: "Expiry",
                    controller: model?.expiryDateController,
                    isReadOnly: true,
                    onTap: (){
                         DateTime firstDate = model?.mfdDate ?? DateTime(1994);
                         DatePickerService.datePicker(context,
                              selectedDate:model?.expiryDate,
                              firstDate: firstDate
                              )
                          .then((picked) {
                        if (picked != null) {
                          var day =
                              picked.day < 10 ? '0${picked.day}' : picked.day;
                          var month = picked.month < 10
                              ? '0${picked.month}'
                              : picked.month;
                          model?.expiryDateController.text =
                              "${picked.year}-$month-$day";
                          setState(() {
                            model?.expiryDate = picked;
                          });
                        }
                      });
    
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Select Expiry date";
                      }
                      return null;
                    },
                  ),
                
      ],
    ),
  );

}

  Widget textfieldWithTitleWidget(
      {required String title,
      Widget? suffix,
      TextEditingController? controller,
      String? Function(String?)? validator,
      bool isReadOnly = false,
      TextInputType? textInputType,
      TextInputAction ? textInputAction,
      final List<TextInputFormatter>? inputFormatters,
      Function()? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: title, isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        AppTextfield(
          fillColor: false,
          onTap: onTap,
          textInputType: textInputType ?? TextInputType.text,
        inputFormatters: inputFormatters,
          isReadOnly: isReadOnly,
          suffixWidget: suffix,
          controller: controller,
          textInputAction: textInputAction,
          validator: validator,
        ),
      ],
    );
  }

  Widget imageWidget({required AddComplaintNotifier refNotifier, required AddComplaintState refState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title: "Attach Image/Video",
                  color: AppColors.lightTextColor,
                ),
                AppText(
                  title: "Upload or capture a clear photo or video",
                  fontsize: 10,
                  color: AppColors.lightTextColor,
                ),
              ],
            ),
            Icon(
              Icons.add,
              color: AppColors.greenColor,
              size: 25,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: DocumantWidget(
              image: AppAssetPaths.cameraIcon,
              title: "Camera",
              subtitle: "Take a photo",
              onTap: (){
                 ImagePickerService.imagePicker(ImageSource.camera).then((val) {
                  if (val != null) {
                    refNotifier.imageUploadApiFunction(context, val,
                        isCLImage: false);
                  }
                });
              },
            )),
            SizedBox(
              width: 25,
            ),
            Expanded(
                child: DocumantWidget(
              image: AppAssetPaths.uploadIcon,
              title: "Upload",
              subtitle: "JPG, PNG",
              onTap: (){
                 ImagePickerService.imagePicker(ImageSource.gallery).then((val) {
                  if (val != null) {
                    refNotifier.imageUploadApiFunction(context, val,
                        isCLImage: false);
                  }
                });
              },
            )),
          ],
        ),
          refState.imgList.isNotEmpty?
        viewUploadedImage( refState.imgList,): EmptyWidget(),
      
      ],
    );
  }

// viewUploadedImage({required String url, Function()? removeImg}){
//   return   Container(
//           padding: const EdgeInsets.only(top: 6),
//           height: 80,width: 80,
//           child: Stack(
//             children: [
//               ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                 child: AppNetworkImage(imgUrl: url,height: 80,width: 80,boxFit: BoxFit.cover,borderRadius: 10,)),
//                Align(
//                 alignment: Alignment.topRight,
//                 child: GestureDetector(
//                   onTap: removeImg,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.redColor
//                     ),
//                     child: Icon(Icons.close,color: AppColors.whiteColor,size: 15,),
//                   ),
//                 ))
//             ],
//           ),
//   );
// }

  viewUploadedImage(List list){
    return  GridView.builder(
      padding: EdgeInsets.only(top: 10),
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2.99 / 3),
                  itemBuilder: (ctx, index) {
                    return Stack(
                            fit: StackFit.expand,
                            children: [
                              AppNetworkImage(
                                imgUrl: 
                                list[index]['url'],
                                height: 79,
                                width: 80,
                                boxFit: BoxFit.cover,borderRadius:10
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      list.removeAt(index);
                                      setState(() {
                                        
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.redColor),
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.whiteColor,
                                        size: 15,
                                      ),
                                    ),
                                  ))
                            ],
                          );
                  })
              ;
  }



  customerTypeWidget(
      {required AddComplaintNotifier addComplaintNotifier,
      required AddComplaintState addComplaintState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Visit Type", isRequiredStar: false),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            customRadioButton(
                isSelected: addComplaintState.selectedVisitType == 0 ? true : false,
                title: 'Primary',
                onTap: () {
                  addComplaintNotifier.updateVisitType(0);
                }),
            const Spacer(),
            customRadioButton(
                isSelected: addComplaintState.selectedVisitType == 1 ? true : false,
                title: 'Secondary',
                onTap: () {
                  addComplaintNotifier.updateVisitType(1);
                }),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget claimTypeWidget( {required AddComplaintNotifier addComplaintNotifier,
      required AddComplaintState addComplaintState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Claim Type", isRequiredStar: false),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            customRadioButton(
                isSelected: addComplaintState.selectedClaimTypeIndex  == 0 ? true : false,
                title: 'Transit',
                onTap: () {
                  addComplaintNotifier.updateClaimType(0);
                }),
            const Spacer(),
            customRadioButton(
                isSelected: addComplaintState.selectedClaimTypeIndex == 1 ? true : false,
                title: 'Quality',onTap: (){
                  addComplaintNotifier.updateClaimType(1);
                }),
            const Spacer(),
          ],
        ),
      ],
    );
  }


_handleCustomerName({required AddComplaintNotifier refNotifer, required AddComplaintState refState,}){
            refState.customerInfoModel = null;
            AppRouter.pushCupertinoNavigation(SearchScreen(
              route: 'verified',
              visitType: AppConstants.visitTypeList[refState.selectedVisitType],
              verificationType: 'Verified',
            )).then((val) {
              if (val != null) {
                
                setState(() {
                });
                refNotifer.resetOnChangedVerfiyType();
                CustomerDetails model = val;
                refNotifer.invoiceApiFunction(context,model.name ??''); // 

                      refNotifer.contactNumberList = (model.contact??[]);
                      refNotifer.shopNameController.text = model.shopName?? '';
                      refNotifer.selectedShop = model.shop ?? '';
                    refNotifer.selectedCustomer = model.name ?? '';
                    refNotifer.contactPersonNameController.text = model.customerName ?? '';
                    if (refNotifer.contactNumberList.isNotEmpty) {
                      refNotifer.contactController.text =
                          refNotifer.contactNumberList[0];
                    }
                    /// calling address api
                  refNotifer
                      .customerAddressApiFunction(context, model.name ?? '', model.verificType ?? '')
                      .then((response) {
                        if(response!=null&& response['data'].isNotEmpty){
                    CustomerAddressModel addressModel =
                        CustomerAddressModel.fromJson(response);
                    refNotifer.stateNameController.text = addressModel.data?.state ?? '';
                    refNotifer.pincodeController.text = addressModel.data?.pincode ?? '';
                    refNotifer.townTypeController.text = addressModel.data?.district ?? ''; 
                        }
                  });
                
                setState(() {});
              }
            });
          
}


  List<DropdownMenuItem<String>> dropDownMenuItems(List list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item['item_name'],
            child: Text(
              item['item_name'],
            ),
          ),
          if (item != list.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }



  List<DropdownMenuItem<String>> companyNameDropDownItem(List list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item,
            child: Text(
              item,
            ),
          ),
          if (item != list.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

}
