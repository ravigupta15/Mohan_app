import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/services/image_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_text_field/custom_drop_down.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_notifier.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_state.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/documents_widget.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/kyc_page_number.dart';
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

class AddKycScreen extends ConsumerStatefulWidget {
  const AddKycScreen({super.key});

  @override
  ConsumerState<AddKycScreen> createState() => _AddKycScreenState();
}

class _AddKycScreenState extends ConsumerState<AddKycScreen>
    with AppValidation {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(kycProvider);
    final refNotifier = ref.read(kycProvider.notifier);
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
                  refState.tabBarIndex == 0
                      ? customerDetailsWidget(
                          refNotifier: refNotifier, refState: refState)
                      : refState.tabBarIndex == 1
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
                                if (refState.tabBarIndex == 0) {
                                  refNotifier.checkValidation(context);
                                }
                                else if(refState.tabBarIndex == 1){
                                  refNotifier.checkDocumentValidation();
                                }
                                else if(refState.tabBarIndex==2){
                                  print(LocalSharePreference.token);
                                  refNotifier.createKycApiFunction();
                                }
                              },
                              height: 40,
                              title: refState.tabBarIndex ==2 ?"Submit": "Next")),
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

  _handleBackButton({required KycNotifier refNotifier, required KycState refState}){
      if (refState.tabBarIndex == 0) {
                              print(LocalSharePreference.token);
                              Navigator.pop(context);
                            } else {
                              refNotifier
                                  .updateTabBarIndex(refState.tabBarIndex - 1);
                            }
  }

  Widget businessTypeWidget(
      {required KycNotifier refNotifier, required KycState refState}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: "Business Type",
          color: AppColors.lightBlue62Color,
          fontsize: 13,
        ),
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
      {required KycNotifier refNotifier, required KycState refState}) {
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
          controller: refNotifier.customerNameController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter customer name";
            }
            return null;
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
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Address', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter address",
          fillColor: false,
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
          textInputAction: TextInputAction.next,
          controller: refNotifier.businessNameController,
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter business name";
            }
            return null;
          },
        ),
        // const SizedBox(height: 15),
        // LabelTextTextfield(title: 'Shop name', isRequiredStar: true),
        // const SizedBox(height: 5),
        // AppTextfield(
        //   hintText: "Enter shop name",
        //   fillColor: false,
        //   textInputAction: TextInputAction.next,
        //   controller: refNotifier.shopNameController,
        //   validator: (val) {
        //     if (val!.isEmpty) {
        //       return "Enter shop name";
        //     }
        //     return null;
        //   },
        // ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Customer Type', isRequiredStar: true),
        const SizedBox(height: 5),
        CustomDropDown(
          hintText: "Select customer type",
          selectedValue: refNotifier.selectedCustomerTypeValue,
          items: dropDownMenuItems(refNotifier.list),
          onChanged: refNotifier.onChangedCustomType,
          validator: (val) {
            if ((val ?? "").isEmpty) {
              return "Select customer type";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Segment', isRequiredStar: true),
        const SizedBox(height: 5),
        CustomDropDown(
          hintText: "Select segment type",
          selectedValue: refNotifier.selectedSegmentTypeValue,
          items: dropDownMenuItems(refNotifier.segemantList),
          onChanged: refNotifier.onChangedSegment,
          validator: (val) {
            if ((val ?? "").isEmpty) {
              return "Select segment type";
            }
            return null;
          },
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
            if (val!.isEmpty) {
              return "Enter shipping address1";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Shipping Address2', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter shipping address2",
          fillColor: false,
          controller: refNotifier.shippingAddress2Controller,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            emojiRestrict(),
          ],
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter shipping address2";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Shipping City', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter shipping city",
          fillColor: false,
          controller: refNotifier.shippingCityController,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            emojiRestrict(),
          ],
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter shipping city";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Shipping state', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter shipping state",
          fillColor: false,
          controller: refNotifier.shippingStateController,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            emojiRestrict(),
          ],
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter shipping state";
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
            if (val!.isEmpty) {
              return "Enter shipping pincode";
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
                    refNotifier.onChangedCheckBox(val!);
                  }),
              AppText(
                title: "Same as billing address",
                color: AppColors.lightTextColor,
                fontFamily: AppFontfamily.poppinsMedium,
                fontsize: 11,
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing Address-1', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter billing address1",
          fillColor: false,
          controller: refNotifier.billingAddress1Controller,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter your billing addres1";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing Address-2', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter billing address2",
          fillColor: false,
          controller: refNotifier.billingAddress2Controller,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter your billing addres2";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing city', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter billing city",
          fillColor: false,
          controller: refNotifier.billingCityController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter your billing city";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing state', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter billing state",
          fillColor: false,
          controller: refNotifier.billingStateController,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "Enter your billing state";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Billing pincode', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter billing pincode",
          fillColor: false,
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
            removeWhiteSpace()
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
          isRequiredStar: false,
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
                DatePickerService.datePicker(context, selectedDate: endDate)
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
      {required KycNotifier refNotifer, required KycState refState}) {
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
        viewUploadedImage(url: refState.cdImageList[0]['url'],removeImg: (){
                    refState.cdImageList.clear();
                    setState(() {
                    });
                  }): EmptyWidget(),
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
        viewUploadedImage(url: refState.clImageList[0]['url'],removeImg: (){
                    refState.clImageList.clear();
                    setState(() {
                    });
                  }): EmptyWidget(),
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

  Widget kycReviewWidget({required KycNotifier refNotifier, required KycState refState}) {
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
        _DocumentCheckListWidget(refNotifier: refNotifier,refState: refState,),
      ],
    );
  }

  List<DropdownMenuItem<String>> dropDownMenuItems(List list) {
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

class _CustomInfoWidget extends StatelessWidget {
  final KycNotifier refNotifier;
  final KycState refState;
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
          itemsWidget("Customer type", refNotifier.customerTypeController.text),
          const SizedBox(height: 10),
          itemsWidget("Segment", refNotifier.segmentController.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping address-1", refNotifier.shippingAddress1Controller.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping address-2", refNotifier.shippingAddress2Controller.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping city", refNotifier.shippingCityController.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping state", refNotifier.shippingStateController.text),
          const SizedBox(height: 10),
          itemsWidget("Shipping pincode", refNotifier.shippingPincodeController.text),
          const SizedBox(height: 10),
          itemsWidget("Billing address-1", refNotifier.billingAddress1Controller.text),
          const SizedBox(height: 10),
          itemsWidget("Billing address-2", refNotifier.billingAddress2Controller.text),
          const SizedBox(height: 10),
          itemsWidget("Billing city", refNotifier.billingCityController.text),
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

class _DocumentCheckListWidget extends StatelessWidget {
   final KycNotifier refNotifier;
  final KycState refState;
 
  const _DocumentCheckListWidget({required this.refNotifier, required this.refState});

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
          SizedBox(
            height: 10,
          ),
          LabelTextTextfield(
              title: "Customer Declaration (CD)", isRequiredStar: true),
             refState.cdImageList.isNotEmpty?
             Padding(
               padding: const EdgeInsets.only(top: 6),
               child: AppNetworkImage(imgUrl: refState.cdImageList[0]['url'],height: 80,width: 80,),
             ): EmptyWidget() ,
             const SizedBox(height: 15,),
             LabelTextTextfield(
              title: "Customer License (CL)", isRequiredStar: true),
              refState.clImageList.isNotEmpty?
             Padding(
               padding: const EdgeInsets.only(top: 6),
               child: AppNetworkImage(imgUrl: refState.clImageList[0]['url'],height: 80,width: 80,),
             ) : EmptyWidget(),
        ],
      ),
    );
  }
}
