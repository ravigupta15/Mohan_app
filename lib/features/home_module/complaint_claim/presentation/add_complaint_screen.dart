import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohan_impex/core/services/image_picker_service.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/documents_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/empty_widget.dart';

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
    refNotifier.itemListApiFunction(context);
    refNotifier.channelPartnerApiFunction();
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
                const SizedBox(
                  height: 15,
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
                const SizedBox(
                  height: 15,
                ),
                 LabelTextTextfield(title: 'Company Name', isRequiredStar: true),
                const SizedBox(height: 15),
                CustomDropDown(
                  hintText: "Select company name",
                  items: companyNameDropDownItem(addComplaintState.channerPartnerList),
                  onChanged: addComplaintNotifier.onChangedCompanyName,
                  validator: (val) {
                    if ((val ?? "").isEmpty) {
                      return "Select company name";
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
                    title: "Contact",
                    controller: addComplaintNotifier.contactController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
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
                  title: "Town",
                  controller: addComplaintNotifier.townTypeController,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Town";
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
                LabelTextTextfield(title: 'Item Name', isRequiredStar: true),
                const SizedBox(height: 15),
                CustomDropDown(
                  hintText: "Select customer type",
                  items: dropDownMenuItems(addComplaintState.itemList),
                  onChanged: addComplaintNotifier.onChangedCustomType,
                  validator: (val) {
                    if ((val ?? "").isEmpty) {
                      return "Select customer type";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelTextTextfield(
                        title: "Invoice no", isRequiredStar: true),
                        // & Date
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: AppTextfield(
                          fillColor: false,
                          controller: addComplaintNotifier.invoiceNoController,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter Invoice no ";
                            }
                            return null;
                          },
                        )),
                        // const SizedBox(
                        //   width: 30,
                        // ),
                        // AppDateWidget(
                        //   onTap: () {
                        //     DatePickerService.datePicker(context,
                        //             selectedDate: startDate)
                        //         .then((picked) {
                        //       if (picked != null) {
                        //         var day = picked.day < 10
                        //             ? '0${picked.day}'
                        //             : picked.day;
                        //         var month = picked.month < 10
                        //             ? '0${picked.month}'
                        //             : picked.month;
                        //         addComplaintNotifier.invoiceDateController
                        //             .text = "${picked.year}-$month-$day";
                        //         setState(() {
                        //           startDate = picked;
                        //         });
                        //       }
                        //     });
                        //   },
                        //   title:
                        //       addComplaintNotifier.invoiceDateController.text,
                        // ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * .2,
                        // )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "Complaint Item Quantity",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: addComplaintNotifier.complaintItemQuanityController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Complaint Item Quantity";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "Value of Goods",
                  controller: addComplaintNotifier.goodsController,
                  textInputAction: TextInputAction.next,
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
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "Batch no.",
                  controller: addComplaintNotifier.batchNoController,
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
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "MFD",
                  controller: addComplaintNotifier.mfdController,
                  isReadOnly: true,
                  onTap: (){
                       DatePickerService.datePicker(context,
                            selectedDate: mfdDate)
                        .then((picked) {
                      if (picked != null) {
                        var day =
                            picked.day < 10 ? '0${picked.day}' : picked.day;
                        var month = picked.month < 10
                            ? '0${picked.month}'
                            : picked.month;
                        addComplaintNotifier.mfdController.text =
                            "${picked.year}-$month-$day";
                        setState(() {
                          mfdDate = picked;
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
                  height: 15,
                ),
                textfieldWithTitleWidget(
                  title: "Expiry",
                  controller: addComplaintNotifier.expiryController,
                  isReadOnly: true,
                  onTap: (){
                       DatePickerService.datePicker(context,
                            selectedDate: expiryDate)
                        .then((picked) {
                      if (picked != null) {
                        var day =
                            picked.day < 10 ? '0${picked.day}' : picked.day;
                        var month = picked.month < 10
                            ? '0${picked.month}'
                            : picked.month;
                        addComplaintNotifier.expiryController.text =
                            "${picked.year}-$month-$day";
                        setState(() {
                          expiryDate = picked;
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

  Widget invoiceNoAndDateWidget(
      TextEditingController? controller, addComplaintNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Invoice no & Date", isRequiredStar: true),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
                child: AppTextfield(
              fillColor: false,
              controller: controller,
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Enter Invoice no ";
                }
                return null;
              },
            )),
            const SizedBox(
              width: 30,
            ),
            AppDateWidget(
              onTap: () {
                DatePickerService.datePicker(context, selectedDate: startDate)
                    .then((picked) {
                  if (picked != null) {
                    var day = picked.day < 10 ? '0${picked.day}' : picked.day;
                    var month =
                        picked.month < 10 ? '0${picked.month}' : picked.month;
                    addComplaintNotifier.creditStartDaysController.text =
                        "${picked.year}-$month-$day";
                    setState(() {
                      startDate = picked;
                    });
                  }
                });
              },
              title: addComplaintNotifier.creditStartDaysController.text,
            ),
            AppDateWidget(),
            SizedBox(
              width: MediaQuery.of(context).size.width * .2,
            )
          ],
        )
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
        viewUploadedImage(url: refState.imgList[0]['url'],removeImg: (){
                    refState.imgList.clear();
                    setState(() {
                    });
                  }): EmptyWidget(),
      
      ],
    );
  }

viewUploadedImage({required String url, Function()? removeImg}){
  return   Container(
          padding: const EdgeInsets.only(top: 6),
          height: 80,width: 80,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                child: AppNetworkImage(imgUrl: url,height: 80,width: 80,)),
               Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: removeImg,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.redColor
                    ),
                    child: Icon(Icons.close,color: AppColors.whiteColor,size: 15,),
                  ),
                ))
            ],
          ),
  );
}


  customerTypeWidget(
      {required AddComplaintNotifier addComplaintNotifier,
      required AddComplaintState addComplaintState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Customer Type", isRequiredStar: false),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            customRadioButton(
                isSelected: addComplaintState.selectedCustomerType == 0 ? true : false,
                title: 'Primary',
                onTap: () {
                  addComplaintNotifier.updateCustomerType(0);
                }),
            const Spacer(),
            customRadioButton(
                isSelected: addComplaintState.selectedCustomerType == 1 ? true : false,
                title: 'Secondary',
                onTap: () {
                  addComplaintNotifier.updateCustomerType(1);
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


  List<DropdownMenuItem<String>> dropDownMenuItems(List list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item['name'],
            child: Text(
              item['name'],
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
