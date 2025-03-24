import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohan_impex/core/helper/dropdown_item_helper.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/services/image_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_text_field/custom_drop_down.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/view_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_address_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/add_kyc_notifier.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/add_kyc_state.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/documents_widget.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/kyc_page_number.dart';
import 'package:mohan_impex/features/home_module/search/presentation/search_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/utils/app_validation.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/app_text.dart';
import '../../../../core/widget/app_text_field/app_textfield.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/app_text_field/label_text_textfield.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_fontfamily.dart';
import '../../../../res/app_router.dart';

// ignore: must_be_immutable
class AddKycScreen extends ConsumerStatefulWidget {
  VisitItemsModel? visitItemsModel;
  final String route;
   AddKycScreen({super.key, this.visitItemsModel, this.route = ''});

  @override
  ConsumerState<AddKycScreen> createState() => _AddKycScreenState();
}

class _AddKycScreenState extends ConsumerState<AddKycScreen>
    with AppValidation {
  DateTime? startDate;
  DateTime? endDate;

// int tabBarIndex =0;

  @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(addKycProvider.notifier);
    refNotifier.resetControllers();
    refNotifier.segementApiFunction(context);
    refNotifier.stateApiFunction(context);
    if(widget.visitItemsModel!=null){
     refNotifier.setVisitValues(context,widget.visitItemsModel);
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(addKycProvider);
    final refNotifier = ref.read(addKycProvider.notifier);
    return WillPopScope(
      onWillPop: ()async{
        _handleBackButton(refNotifier: refNotifier, refState: refState);
        return false;
      },
      child: Scaffold(
        appBar: customAppBar(title: 'KYC',isBackTap: (){
          _handleBackButton(refNotifier: refNotifier, refState: refState);
        }),
        body: SingleChildScrollView(
          child: Form(
            key: refNotifier.formKey,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 18, right: 19, top: 14, bottom: 30),
              child: Column(
                children: [
                  refState.addKycTabBarIndex==0
                      ? customerDetailsWidget(
                          refNotifier: refNotifier, refState: refState)
                      : refState.addKycTabBarIndex == 1
                          ? documentUploadWidget(
                              refNotifer: refNotifier, refState: refState)
                          : kycReviewWidget(refNotifier: refNotifier,refState: refState),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: AppButton(
                          width: 95,
                          height: 40,
                          color: Colors.black,
                          onPressed: () {
                          _handleBackButton(refNotifier: refNotifier, refState: refState);
                          },
                          title: "Back",
                        ),
                      ),
                      // Spacer(),
                      Flexible(
                          child: AppButton(
                              width: 120,
                              color: Colors.black,
                              onPressed: () {
                                if (refState.addKycTabBarIndex == 0) {
                                  refNotifier.checkValidation(context);
                                }
                                else if(refState.addKycTabBarIndex == 1){
                                  refNotifier.checkDocumentValidation();
                                }
                                else if(refState.addKycTabBarIndex==2){
                                  
                                  refNotifier.createKycApiFunction(context);
                                }
                              },
                              height: 40,
                              title: refState.addKycTabBarIndex ==2 ?"Submit": "Next")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget businessTypeWidget(
      {required AddKycNotifier refNotifier, required AddKycState refState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         LabelTextTextfield(title: 'Business Type', isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            customRadioButton(
                isSelected: refState.selectedBusinessType == 0 ? true : false,
                title: 'Registered',
                onTap: () {
                  refNotifier.updateBusinessType(0);
                }),
            const Spacer(),
            customRadioButton(
                isSelected: refState.selectedBusinessType == 1 ? true : false,
                title: 'Unregistered',
                onTap: () {
                  refNotifier.updateBusinessType(1);
                }),
            const Spacer(),
          ],
        )
      ],
    );
  }

  Widget customerDetailsWidget(
      {required AddKycNotifier refNotifier, required AddKycState refState}) {
        
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDividerWidget(
          number: '1',
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.center,
          child: AppText(
            title: 'Customer information',
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
        ),
        const SizedBox(height: 25),
        LabelTextTextfield(title: 'Customer name', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter customer name",
          fillColor: false,
          isReadOnly:  true,
          controller: refNotifier.customerNameController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter customer name";
            }
            return null;
          },
          onTap: (){
            if(widget.route.isEmpty){
              _handleCustomerName(refNotifer: refNotifier, refState: refState);
            }
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(
          title: 'Contact',
          isRequiredStar: true,
        ),
        const SizedBox(height: 5),
        AppTextfield(
            hintText: "Enter contact number",
            fillColor: false,
            isReadOnly: true,
            controller: refNotifier.contactNumberController,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            validator: numberValidation,
            suffixWidget: Container(
              decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Icon(
                Icons.add,
                color: AppColors.whiteColor,
                size: 30,
              ),
            )),
              (refNotifier.contactList).isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: refNotifier.contactList.map((e) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppColors.lightEBColor,
                            borderRadius: BorderRadius.circular(25)),
                        alignment: Alignment.center,
                        child: AppText(title: e));
                  }).toList(),
                ),
              )
            : Container(),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Email', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter email",
          fillColor: false,
          textInputAction: TextInputAction.next,
          controller: refNotifier.emailController,
          inputFormatters: [
            emojiRestrict(),
          ],
          validator: emailValidator,
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Business name', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter business name",
          fillColor: false,
          isReadOnly:  true,
          textInputAction: TextInputAction.next,
          controller: refNotifier.businessNameController,
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter business name";
            }
            return null;
          },
        ),
        
        const SizedBox(height: 15),
         LabelTextTextfield(title: 'Address', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter address",
          fillColor: false,
          isReadOnly: widget.route.isEmpty? false : true,
          controller: refNotifier.addressController,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            emojiRestrict(),
          ],
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter your address";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
       
          LabelTextTextfield(title: 'State', isRequiredStar: true),
        const SizedBox(height: 5),
        CustomDropDown(
          selectedValue: refNotifier.selectedState,
          items: DropdownItemHelper().stateItems((refState.stateModel?.data??[])),
          hintText: "state",
          onChanged: (val){
            refNotifier.onChangedStateVal(context, val);
            setState(() {
              
            });
          },
        validator: (val) {
            if ((val??'').isEmpty) {
              return "Select state";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
      
        LabelTextTextfield(title: 'District', isRequiredStar: true),
        const SizedBox(height: 5),
        CustomDropDown(
          selectedValue: refNotifier.selectedDistrict,
          items: DropdownItemHelper().districtItems((refState.districtModel?.data??[])),
          hintText: "Select district",
          onChanged: (val){
            refNotifier.districtController.text = val;
            refNotifier.selectedDistrict = val;
            setState(() {
              
            });
          },
        validator: (val) {
            if ((val??'').isEmpty) {
              return "Select district";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        // LabelTextTextfield(title: 'Visit Type', isRequiredStar: true),
        // const SizedBox(height: 5),
        // CustomDropDown(
        //   hintText: "Select visit type",
        //   selectedValue: refNotifier.selectedVisitTypeValue,
        //   items: DropdownItemHelper().dropdownListt(refNotifier.list),
        //   onChanged: refNotifier.onChangedVisitType,
        //   validator: (val) {
        //     if ((val ?? "").isEmpty) {
        //       return "Select visit type";
        //     }
        //     return null;
        //   },
        // ),
        // const SizedBox(height: 15),
        LabelTextTextfield(title: 'Segment', isRequiredStar: true),
        const SizedBox(height: 5),
        CustomDropDown(
          hintText: "Select segment type",
          selectedValue: refNotifier.selectedSegmentTypeValue,
          items: DropdownItemHelper().segmentList((refState.segmentModel?.data??[])),
          onChanged: refNotifier.onChangedSegment,
          validator: (val) {
            if ((val ?? "").isEmpty) {
              return "Select segment type";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing Address-1', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter billing address1",
          fillColor: false,
          isReadOnly:  true,
          controller: refNotifier.billingAddress1Controller,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if ((val??'').isEmpty) {
              return "Enter your billing addres1";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing Address-2', isRequiredStar: false),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter billing address2",
          fillColor: false,
          isReadOnly: true,
          controller: refNotifier.billingAddress2Controller,
          textInputAction: TextInputAction.next,
          // validator: (val) {
          //   if ((val??"").isEmpty) {
          //     return "Enter your billing addres2";
          //   }
          //   return null;
          // },
        ),
       
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing state', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          controller: refNotifier.billingStateController,
          isReadOnly: true,
          fillColor: false,
          hintText: "Select billing state",
          validator: (val){
             if ((val??"").isEmpty) {
              return "Select billing state";
            }
            return null;
          },
        ),
        // CustomDropDown(
        //   selectedValue: refNotifier.selectedBillingState,
        //   items:widget.route.isEmpty? DropdownItemHelper().stateItems((refState.billingStateModel?.data??[])) : [],
        //   hintText: widget.route.isNotEmpty && refNotifier.billingStateController.text.isNotEmpty
        //       ? refNotifier.billingStateController.text
        //       : "Select State",
        //   hintColor:
        //       widget.route.isNotEmpty && refNotifier.billingStateController.text.isNotEmpty ? AppColors.black : AppColors.lightTextColor,
          
        //   onChanged: (val){
        //     refNotifier.onChangedBillingStateVal(context, val);
        //     setState(() {
              
        //     });
        //   },
        // validator: (val) {
        //     if ((val??"").isEmpty) {
        //       return "Select billing state";
        //     }
        //     return null;
        //   },
        // ),
         const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing District', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          controller: refNotifier.billingDistrictController,
          isReadOnly: true,
          fillColor: false,
          hintText: "Select billing district",
          validator: (val){
             if ((val??"").isEmpty) {
              return "Select billing district";
            }
            return null;
          },
        ),
        
        //  CustomDropDown(
        //   selectedValue: refNotifier.selectedBillingDistrict,
        //   items:widget.route.isEmpty? DropdownItemHelper().districtItems((refState.billingDistrictModel?.data??[])) : [],
        //   hintText: widget.route.isNotEmpty && refNotifier.billingDistrictController.text.isNotEmpty
        //       ? refNotifier.billingDistrictController.text
        //       : "Select District",
        //   hintColor:
        //       widget.route.isNotEmpty && refNotifier.billingDistrictController.text.isNotEmpty ? AppColors.black : AppColors.lightTextColor,
          
        //   onChanged: (val){
        //     refNotifier.billingDistrictController.text = val;
        //     refNotifier.selectedBillingDistrict = val;
        //     setState(() {
              
        //     });
        //   },
        // validator: (val) {
        //     if ((val??"").isEmpty) {
        //       return "Select billing district";
        //     }
        //     return null;
        //   },
        // ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing pincode', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter billing pincode",
          fillColor: false,
          isReadOnly: true,
          controller: refNotifier.billingPincodeController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter your billing pincode";
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              customCheckbox(
                  isCheckbox: refState.isSameBillingAddress,
                  onChanged: (val) {
                    refNotifier.onChangedCheckBox(context, val!);
                    setState(() {
                      
                    });
                  }),
              AppText(
                title: "Same as shipping address",
                color: AppColors.lightTextColor,
                fontFamily: AppFontfamily.poppinsMedium,
                fontsize: 11,
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Shipping Address1', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter shipping address1",
          fillColor: false,
          controller: refNotifier.shippingAddress1Controller,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            emojiRestrict(),
          ],
          validator: (val) {
            if ((val??"").isEmpty) {
              return "Enter shipping address1";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Shipping Address2', isRequiredStar: false),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter shipping address2",
          fillColor: false,
          controller: refNotifier.shippingAddress2Controller,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            emojiRestrict(),
          ],
          // validator: (val) {
          //   if ((val??'').isEmpty) {
          //     return "Enter shipping address2";
          //   }
          //   return null;
          // },
        ),
        const SizedBox(height: 15),
          LabelTextTextfield(title: 'Shipping state', isRequiredStar: true),
        const SizedBox(height: 5),
        CustomDropDown(
          selectedValue:refNotifier.selectedShippingState,
          items: DropdownItemHelper().stateItems((refState.shippingStateModel?.data??[])),
          hintText: "Select state",
          onChanged: (val){
            refNotifier.onChangedShippingStateVal(context, val);
            setState(() {
              
            });
          },
        validator: (val) {
            if ((val??"").isEmpty) {
              return "Select shipping state";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
      
        LabelTextTextfield(title: 'Shipping District', isRequiredStar: true),
        const SizedBox(height: 5),
        CustomDropDown(
          selectedValue: refNotifier.selectedShippingDistrict ,
          items: DropdownItemHelper().districtItems((refState.shippingDistrictModel?.data??[])),
          hintText: "Select district",
          onChanged: (val){
            refNotifier.shippingDistrictController.text = val;
            refNotifier.selectedShippingDistrict = val;
            setState(() {
              
            });
          },
        validator: (val) {
            if ((val??"").isEmpty) {
              return "Select shipping district";
            }
            return null;
          },
        ),
        
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Shipping pincode', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter shipping pincode",
          fillColor: false,
          controller: refNotifier.shippingPincodeController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: (val) {
            if ((val??"").isEmpty) {
              return "Enter shipping pincode";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        businessTypeWidget(refNotifier: refNotifier, refState: refState),
        const SizedBox(height: 15),
        LabelTextTextfield(
            title: refState.selectedBusinessType == 0 ? 'GST NO.' : "PAN No.",
            isRequiredStar: false),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "",
          fillColor: false,
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [
            removeWhiteSpace(),
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 ]')) 
          ],
          controller: refState.selectedBusinessType == 0
              ? refNotifier.gstNumberController
              : refNotifier.panNumberController,
              
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return refState.selectedBusinessType == 0
                  ? "Enter your GST No."
                  : "Enter your PAN No.";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(
          title: 'Proposed Credit Limit.',
          isRequiredStar: true,
        ),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter proposed credit limit",
          fillColor: false,
          textInputType: TextInputType.number,
          inputFormatters: [
            emojiRestrict(),
            FilteringTextInputFormatter.digitsOnly
          ],
          controller: refNotifier.creditLimitController,
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter proposed credit limit";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(
          title: 'Proposed Credit Days',
          isRequiredStar: false,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AppDateWidget(
              onTap: () {
                DatePickerService.datePicker(context, selectedDate: startDate)
                    .then((picked) {
                  if (picked != null) {
                    var day = picked.day < 10 ? '0${picked.day}' : picked.day;
                    var month =
                        picked.month < 10 ? '0${picked.month}' : picked.month;
                    refNotifier.creditStartDaysController.text =
                        "${picked.year}-$month-$day";
                    setState(() {
                      startDate = picked;
                       if (endDate != null &&
                                          startDate!.isAfter(endDate!)) {
                                        endDate = null;
                                        refNotifier.creditEndDaysController.clear();
                                      } 
                    });
                  }
                });
              },
              title: refNotifier.creditStartDaysController.text,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: 8,
              height: 2,
              color: AppColors.black,
            ),
            AppDateWidget(
              onTap: () {
                 DateTime firstDate = startDate ?? DateTime.now();
                DatePickerService.datePicker(context, selectedDate: endDate,
                firstDate: firstDate
                )
                    .then((picked) {
                  if (picked != null) {
                    var day = picked.day < 10 ? '0${picked.day}' : picked.day;
                    var month =
                        picked.month < 10 ? '0${picked.month}' : picked.month;
                    refNotifier.creditEndDaysController.text =
                        "${picked.year}-$month-$day";
                    setState(() {
                      endDate = picked;
                    });
                  }
                });
              },
              title: refNotifier.creditEndDaysController.text,
            ),
          ],
        ),
      ],
    );
  }

  Widget documentUploadWidget(
      {required AddKycNotifier refNotifer, required AddKycState refState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDividerWidget(
          number: '2',
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: AppText(
            title: "Document Upload",
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        LabelTextTextfieldDocument(
            title: 'Customer Declaration (CD)', isRequiredStar: true),
        const SizedBox(
          height: 5,
        ),
        AppText(
          title:
              "Upload or capture a clear photo of your signed declaration form",
          color: AppColors.mossGreyColor,
          fontsize: 11,
        ),
        const SizedBox(
          height: 13,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: DocumantWidget(
              image: AppAssetPaths.cameraIcon,
              title: "Camera",
              subtitle: "Take a photo",
              onTap: () {
                ImagePickerService.imagePicker(ImageSource.camera).then((val) {
                  if (val != null) {
                    refNotifer.imageUploadApiFunction(context, val,
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
              onTap: () {
                ImagePickerService.imagePicker(ImageSource.gallery).then((val) {
                  if (val != null) {
                    refNotifer.imageUploadApiFunction(context, val,
                        isCLImage: false);
                  }
                });
              },
            )),
          ],
        ),
        refState.cdImageList.isNotEmpty?
        viewUploadedImage( refState.cdImageList): EmptyWidget(),
        const SizedBox(
          height: 24,
        ),
        LabelTextTextfieldDocument(
            title: 'Customer License (CL)', isRequiredStar: true),
        const SizedBox(
          height: 5,
        ),
        AppText(
          title: "Upload or capture a clear photo of your valid license",
          color: AppColors.mossGreyColor,
          fontsize: 12,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: DocumantWidget(
              image: AppAssetPaths.cameraIcon,
              title: "Camera",
              subtitle: "Take a photo",
              onTap: () {
                ImagePickerService.imagePicker(ImageSource.camera).then((val) {
                  if (val != null) {
                    refNotifer.imageUploadApiFunction(context, val,
                        isCLImage: true);
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
              onTap: () {
                ImagePickerService.imagePicker(ImageSource.gallery).then((val) {
                  if (val != null) {
                    refNotifer.imageUploadApiFunction(context, val,
                        isCLImage: true);
                  }
                });
              },
            )),
          ],
        ),
        refState.clImageList.isNotEmpty?
        viewUploadedImage(refState.clImageList): EmptyWidget(),
        //  Spacer(),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Flexible(
        //         child: AppButton(
        //           width: 95,
        //           height: 40,
        //           color: AppColors.black,
        //           onPressed: () {
        //             //AppRouter.pushReplacementNavigation(const KycScreen());
        //           },
        //           title: "Back",
        //         ),
        //       ),
        //       Spacer(),
        //       Flexible(
        //           child: AppButton(
        //               width: 95,
        //               color: AppColors.black,
        //               onPressed: () {
        //                 // AppRouter.pushCupertinoNavigation(const KycReviewScreen());
        //               },
        //               height: 40,
        //               title: "Next")),
        //     ],
        //   ),

        const SizedBox(
          height: 25,
        ),
      ],
    );
  }




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
                      childAspectRatio: 2.9 / 3),
                  itemBuilder: (ctx, index) {
                    return Stack(
                            fit: StackFit.expand,
                            children: [
                              AppNetworkImage(
                                imgUrl: 
                                list[index]['url'],
                                height: 79,
                                width: 100,
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
  Widget kycReviewWidget({required AddKycNotifier refNotifier, required AddKycState refState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDividerWidget(
          number: '3',
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: AppText(
            title: "Review",
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        _CustomInfoWidget(refNotifier: refNotifier,refState: refState,),
        const SizedBox(
          height: 24,
        ),
        _documentCheckListWidget(refNotifier: refNotifier,refState: refState,),
      ],
    );
  }

Widget _documentCheckListWidget({required AddKycNotifier refNotifier, required AddKycState refState}){
  return ExpandableWidget(
        initExpanded: false,
        isBorderNoShadow: true,
        collapsedWidget: documentCheckListCollapsedWidget(
          isExpanded: true,refNotifier: refNotifier, refState: refState
        ),
        expandedWidget: documentCheckListExpandedWidget(isExpanded: false, refNotifier: refNotifier, refState: refState));
}


  Widget documentCheckListCollapsedWidget({required bool isExpanded, required AddKycNotifier refNotifier, required AddKycState refState}) {
    return Container(
      padding: isExpanded
          ? EdgeInsets.symmetric(horizontal: 10, vertical: 12)
          : EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                  title: "Documents Checklist",
                  fontFamily: AppFontfamily.poppinsSemibold),
              Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.light92Color),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          !isExpanded
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(34, (index) {
                    return Container(
                      width: 8.5,
                      height: 2,
                      color: index % 2 == 0
                          ? AppColors.edColor
                          : Colors.transparent,
                      // Alternating between black and transparent
                      margin: EdgeInsets.symmetric(
                          horizontal: 0), // Spacing between dashes
                    );
                  }),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget documentCheckListExpandedWidget({required bool isExpanded, required AddKycNotifier refNotifier, required AddKycState refState}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withOpacity(0.2),
                blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          documentCheckListCollapsedWidget(isExpanded: isExpanded,refNotifier: refNotifier, refState: refState),
          SizedBox(
            height: 10,
          ),
          LabelTextTextfield(
              title: "Customer Declaration (CD)", isRequiredStar: true),
             refState.cdImageList.isNotEmpty?
             Padding(
               padding: const EdgeInsets.only(top: 6),
               child: viewImage(refState.cdImageList)
             ): EmptyWidget() ,
             const SizedBox(height: 15,),
             LabelTextTextfield(
              title: "Customer License (CL)", isRequiredStar: true),
              refState.clImageList.isNotEmpty?
             Padding(
               padding: const EdgeInsets.only(top: 6),
               child: viewImage(refState.clImageList),
             ) : EmptyWidget(),
        ],
      ),
    );
  }


  viewImage(List list,){
    return  ListView.separated(
      separatorBuilder: (ctx, sb){
        return const SizedBox(height: 10,);
      },
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx,index){
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.edColor
            )
          ),
          child: Row(
            children: [
              SvgPicture.asset(AppAssetPaths.documentIcon,height: 20,),
              const SizedBox(width: 7,),
              Expanded(
                child: Text(list[index]['file_name'],maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,fontWeight: FontWeight.w400,
                  color: Color(0xff6F7482)
                ),
                ),
              ),
              const SizedBox(width: 5,),
              list.length>1 ?
              InkWell(
                onTap: (){
                  if(list.length>1){
                    list.removeAt(index);
                  }
                  setState(() {
                    
                  });
                },
                child: Icon(Icons.close, size: 20,color: Color(0xff193238),)) : EmptyWidget()
            ],
          ),
        );
    });
    // GridView.builder(
    //               itemCount: list.length,
    //               shrinkWrap: true,
    //               physics: const NeverScrollableScrollPhysics(),
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 3,
    //                   mainAxisSpacing: 15,
    //                   crossAxisSpacing: 15,
    //                   childAspectRatio: 2.9 / 3),
    //               itemBuilder: (ctx, index) {
    //                 return    AppNetworkImage(
    //                             imgUrl: 
    //                             list[index]['url'],
    //                             height: 79,
    //                             width: 100,
    //                             boxFit: BoxFit.cover,borderRadius:10
    //                           );
    //               })
    //           ;
  }

  _handleBackButton({required AddKycNotifier refNotifier, required AddKycState refState}){
      if (refState.addKycTabBarIndex == 0) {
                              print(LocalSharePreference.token);
                              Navigator.pop(context);
                            } else {
                              refNotifier
                                  .addKycTabBarIndex(refState.addKycTabBarIndex - 1);
                            }
  }


_handleCustomerName({required AddKycNotifier refNotifer, required AddKycState refState,}){
            refState.customerInfoModel = null;
            AppRouter.pushCupertinoNavigation(SearchScreen(
              route: 'verified',
              visitType: 'Primary',
              verificationType: 'Unverified',
            )).then((val) {
              if (val != null) {
                CustomerDetails model = val;
                      refNotifer.contactList = (model.contact??[]);
                      refNotifer.businessNameController.text = model.shopName?? '';
                      refNotifer.selectedShop = model.shop ?? '';
                      refNotifer.unvCustomerId = model.name ?? '';
                    refNotifer.customerNameController.text = model.customerName ?? '';
                    if (refNotifer.contactList.isNotEmpty) {
                      refNotifer.contactNumberController.text =
                          refNotifer.contactList[0];
                    }
                    /// calling address api
                  refNotifer
                      .customerAddressApiFunction(context, model.name ?? '', model.verificType ?? '')
                      .then((response) {
                        if(response!=null&& response['data'].isNotEmpty){
                    CustomerAddressModel addressModel =
                        CustomerAddressModel.fromJson(response);
                    refNotifer.billingAddress1Controller.text = addressModel.data?.addressLine1 ?? '';
                    refNotifer.billingAddress2Controller.text = addressModel.data?.addressLine2 ?? '';
                    refNotifer.billingDistrictController.text = addressModel.data?.district ?? '';
                    refNotifer.billingStateController.text = addressModel.data?.state ?? '';
                    refNotifer.billingPincodeController.text = addressModel.data?.pincode ?? '';
                        }
                  });
                
                setState(() {});
              }
            });
          
}

}

class _CustomInfoWidget extends StatelessWidget {
  final AddKycNotifier refNotifier;
  final AddKycState refState;
   _CustomInfoWidget({required this.refNotifier,required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
        initExpanded: false,
        collapsedWidget: collapsedWidget(
          isExpanded: true,
        ),
        expandedWidget: expandedWidget(isExpanded: false));
  }

  Widget collapsedWidget({required bool isExpanded}) {
    return Container(
      padding: isExpanded
          ? EdgeInsets.symmetric(horizontal: 10, vertical: 12)
          : EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                  title: "Customer Information",
                  fontFamily: AppFontfamily.poppinsSemibold),
              Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.light92Color),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          !isExpanded
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(34, (index) {
                    return Container(
                      width: 8.5,
                      // Width of each dash
                      height: 2,
                      // Line thickness
                      color: index % 2 == 0
                          ? AppColors.edColor
                          : Colors.transparent,
                      // Alternating between black and transparent
                      margin: EdgeInsets.symmetric(
                          horizontal: 0), // Spacing between dashes
                    );
                  }),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget expandedWidget({required bool isExpanded}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withOpacity(0.2),
                blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 10),
          itemsWidget("Customer Name", refNotifier.customerNameController.text),
          const SizedBox(height: 10),
          itemsWidget("Contact", refNotifier.contactNumberController.text),
          const SizedBox(height: 10),
          itemsWidget("Address", refNotifier.addressController.text),
          const SizedBox(height: 10),
          itemsWidget("Email", refNotifier.emailController.text),
          const SizedBox(height: 10),
          itemsWidget("Business name", refNotifier.businessNameController.text),
          // const SizedBox(height: 10),
          // itemsWidget("Shop name", refNotifier.shopNameController.text),
          const SizedBox(height: 10),
          // itemsWidget("Visit type", refNotifier.visitTypeController.text),
          // const SizedBox(height: 10),
          itemsWidget("Segment", refNotifier.segmentController.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping address-1", refNotifier.shippingAddress1Controller.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping address-2", refNotifier.shippingAddress2Controller.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping District", refNotifier.shippingDistrictController.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping state", refNotifier.shippingStateController.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping pincode", refNotifier.shippingPincodeController.text),
          const SizedBox(height: 10),
          itemsWidget("Billing address-1", refNotifier.billingAddress1Controller.text),
          const SizedBox(height: 10),
          itemsWidget("Billing address-2", refNotifier.billingAddress2Controller.text),
          const SizedBox(height: 10),
          itemsWidget("Billing District", refNotifier.billingDistrictController.text),
          const SizedBox(height: 10),
          itemsWidget("Billing state", refNotifier.billingStateController.text),
          const SizedBox(height: 10),
          itemsWidget("Billing pincode", refNotifier.billingPincodeController.text),
          const SizedBox(height: 10),
          itemsWidget("Business type", refNotifier.businessTypeTitle(refState.selectedBusinessType)),
         const SizedBox(height: 10),
           refState.selectedBusinessType == 0?
          itemsWidget("GST No", refNotifier.gstNumberController.text):
          itemsWidget("PAN No", refNotifier.panNumberController.text)
          ,
          const SizedBox(height: 10),
          itemsWidget("Proposed credit limit", refNotifier.creditLimitController.text),
          const SizedBox(height: 10),
          itemsWidget("Proposed credit days", refNotifier.calculateCreditDays().toString()),
         
        ],
      ),
    );
  }


  Widget itemsWidget(String title, String subTitle) {
    return Row(
      children: [
        AppText(
          title: "$title : ",
          fontFamily: AppFontfamily.poppinsRegular,
          fontsize: 14,
          color: Colors.black,
        ),
        AppText(
            title: subTitle,
            fontsize: 14,
            fontFamily: AppFontfamily.poppinsRegular,
            color: AppColors.lightTextColor),
      ],
    );
  }
}
