import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/helper/dropdown_item_helper.dart';
import 'package:mohan_impex/core/services/location_service.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/custom_search_drop_down.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_address_model.dart';
import 'package:mohan_impex/features/home_module/search/presentation/search_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_google_map.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/utils/app_validation.dart';
import 'package:mohan_impex/utils/message_helper.dart';

import '../../../../../core/widget/app_text_field/custom_drop_down.dart';
import '../../../../../res/app_asset_paths.dart';

class RegistrationWidget extends StatefulWidget {
  final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
  const RegistrationWidget(
      {super.key, required this.refNotifer, required this.refState});

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget>
    with AppValidation {
  final stateSearchController = TextEditingController();
  final districtSearchController = TextEditingController();
  final unvCustomerSearchController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customerTypeWidget(),
        widget.refState.selectedCustomerType == 1
            ? customerNameSearchDropdown()
            : SizedBox.shrink(),
        const SizedBox(
          height: 20,
        ),
        visitTypeWidget(),
        const SizedBox(
          height: 20,
        ),
        _registrationWidget()
      ],
    );
  }

  customerTypeWidget() {
    return Column(
      children: [
        Row(
          children: [
            AppText(
              title: "Customer Type",
              color: AppColors.lightTextColor,
            ),
            AppText(
              title: " *",
              color: AppColors.redColor,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            customRadioButton(
                isSelected:
                    widget.refState.selectedCustomerType == 0 ? true : false,
                title: "New",
                onTap: () {
                  widget.refNotifer.isReadOnlyFields=false;
                  setState(() {
                    
                  });
                  widget.refNotifer.updateCustomerType(0);
                }),

            const Spacer(),
            customRadioButton(
                isSelected:
                    widget.refState.selectedCustomerType == 1 ? true : false,
                title: "Existing",
                onTap: () {
                  widget.refNotifer.isReadOnlyFields = true;
                  widget.refNotifer.updateCustomerType(1);
                  setState(() {
                    
                  });
                }),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  visitTypeWidget() {
    return Column(
      children: [
        LabelTextTextfield(title: "Visit Type", isRequiredStar: true),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            customRadioButton(
                isSelected:
                    widget.refState.selectedVisitType == 0 ? true : false,
                title: "Primary",
                onTap: () {
                  widget.refNotifer.updateVisitType(0);
                }),
            const Spacer(),
            customRadioButton(
                isSelected:
                    widget.refState.selectedVisitType == 1 ? true : false,
                title: "Secondary",
                onTap: () {
                  widget.refNotifer.updateVisitType(1);
                }),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _registrationWidget() {
    return Column(
      children: [
        registrationWidget(),
        const SizedBox(
          height: 18,
        ),
        SizedBox(
          height: 200,
          child: AppGoogleMap(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              LocationService().startLocationUpdates();
            },
            child: Container(
              width: 90,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(7)),
              alignment: Alignment.center,
              child: AppText(
                title: 'Fetch',
                fontsize: 13,
              ),
            ),
          ),
        )
      ],
    );
  }

  registrationWidget() {
    return Column(
      children: [
        (widget.refState.selectedCustomerType == 0 &&
                    widget.refState.selectedVisitType == 1) ||
                (widget.refState.selectedCustomerType == 1 &&
                    widget.refState.selectedVisitType == 1)
            ? Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: channelParnterTextField(),
              )
            : SizedBox(),
        customerNameTextField(),
        const SizedBox(
          height: 18,
        ),
        shopTextField(),
        const SizedBox(
          height: 18,
        ),
        contactTextField(),
        const SizedBox(
          height: 18,
        ),
        // LabelTextTextfield(title: "Address type", isRequiredStar: true),
        // const SizedBox(
        //   height: 10,
        // ),
        // AppTextfield(
        //   isReadOnly: widget.refNotifer.isReadOnlyFields,
        //   controller: widget.refNotifer.addressTypeController,
        //   hintText: "Enter address type",
        //   fillColor: false,
        //   textInputAction: TextInputAction.next,
        //   validator: (val) {
        //     if ((val ?? '').isEmpty) {
        //       return "Required";
        //     }
        //     return null;
        //   },
        // ),
        // const SizedBox(
        //   height: 18,
        // ),
        LabelTextTextfield(title: "Address 1", isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        AppTextfield(
          isReadOnly: widget.refNotifer.isReadOnlyFields,
          controller: widget.refNotifer.address1Controller,
          hintText: "Enter address",
          fillColor: false,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if ((val ?? '').isEmpty) {
              return "Required";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 18,
        ),
        LabelTextTextfield(title: "Address 2", isRequiredStar: false),
        const SizedBox(
          height: 10,
        ),
        AppTextfield(
          isReadOnly: widget.refNotifer.isReadOnlyFields,
          controller: widget.refNotifer.address2Controller,
          hintText: "Enter address",
          fillColor: false,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(
          height: 18,
        ),
        LabelTextTextfield(title: "State", isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        CustomSearchDropDown(
          selectedValues: widget.refNotifer.selectedStateValue ?? '',
          height: 300,
          searchController: stateSearchController,
          items: widget.refNotifer.isReadOnlyFields? []: DropdownItemHelper()
                  .stateItems((widget.refState.stateModel?.data ?? [])),
          hintText: widget.refNotifer.isReadOnlyFields && widget.refNotifer.stateController.text.isNotEmpty
              ? widget.refNotifer.stateController.text
              : "Select state",
          hintColor:widget.refNotifer.isReadOnlyFields ? AppColors.black : AppColors.lightTextColor,
          onChanged: (val) {
            widget.refNotifer.selectedDistrictValue = null;
            widget.refNotifer.selectedStateValue = val;
            widget.refNotifer.onChangedState(context, val);
            districtSearchController.clear();
            setState(() {});
          },
          validator: (val) {
            if(widget.refNotifer.isReadOnlyFields && widget.refNotifer.stateController.text.isNotEmpty){
              return null;
            }
            else{
              if ((val ?? "").isEmpty) {
                return "Required";
              }
            }
            return null;
          },
        ),
        const SizedBox(
          height: 18,
        ),
        LabelTextTextfield(title: "District", isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        CustomSearchDropDown(
          selectedValues: widget.refNotifer.selectedDistrictValue ?? '',
          height: 300,
          searchController: districtSearchController,
          items: widget.refNotifer.isReadOnlyFields?[]: DropdownItemHelper()
                  .districtItems((widget.refState.districtModel?.data ?? []))
              ,
          hintText: widget.refNotifer.isReadOnlyFields && widget.refNotifer.districtController.text.isNotEmpty
              ? widget.refNotifer.districtController.text
              : "Select district",
          hintColor:
              widget.refNotifer.isReadOnlyFields ? AppColors.black : AppColors.lightTextColor,
          onChanged: (val) {
            widget.refNotifer.onChangedDistrict(val);
            widget.refNotifer.selectedDistrictValue = val;
            setState(() {});
          },
          validator: (val) {
            if(widget.refNotifer.isReadOnlyFields && widget.refNotifer.districtController.text.isNotEmpty){
              return null;
            }
            else{
           if ((val ?? "").isEmpty) {
                return "Required";
              }
            }
            return null;
          },
        ),
        const SizedBox(
          height: 18,
        ),
        LabelTextTextfield(title: "Pincode", isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        AppTextfield(
          controller: widget.refNotifer.pincodeController,
          hintText: "Enter pincode",
          isReadOnly: widget.refNotifer.isReadOnlyFields,
          fillColor: false,
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6)
          ],
          textInputAction: TextInputAction.done,
          validator: pincodeValidation,
        ),

                 Padding(
                   padding: const EdgeInsets.only(top: 20),
                   child: Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               customCheckbox(
                                 isCheckbox: widget.refNotifer.isEditDetails,
                                 onChanged: (val){
                                  widget.refNotifer.isEditDetails = val!;
                                  setState(() {
                                  });
                                 }
                               ),
                               const SizedBox(width: 5,),
                               Flexible(
                                 child: Text('Do you want to request edit to the information?',
                                 ),
                               )
                             ],
                           ),
                 )
      ],
    );
  }

  verfiyTypeDrodownWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CustomDropDown(
        hintText: "Select verification type",
        isfillColor: true,
        items: DropdownItemHelper().dropdownListt(AppConstants.verificationTypeList),
        selectedValue: widget.refNotifer.selectedVerificationType,
        onChanged: widget.refNotifer.onChangedVerificationType,
        validator: (val) {
          if ((val ?? '').isEmpty) {
            return "Please select type";
          }
          return null;
        },
      ),
    );
  }

  Widget customerNameSearchDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: AppSearchBar(
        hintText: 'Search by name, phone, etc.',
        isReadOnly: true,
        controller: widget.refNotifer.searchController,
        onTap: () {
          if(widget.refState.selectedCustomerType == 1 && widget.refState.selectedVisitType == 1 && widget.refNotifer.channelPartnerController.text.isEmpty){
             MessageHelper.showToast("Please select the channel partner to search the customer");
          } else {
            widget.refState.customerInfoModel = null;
            widget.refState.unvCustomerModel = null;
            AppRouter.pushCupertinoNavigation(SearchScreen(
              route: 'verified',
              showCustomerStatus: true,
              visitType: widget.refState.selectedCustomerType == 1 ? AppConstants.visitTypeList[widget.refState.selectedVisitType] : '',
              channelParter: widget.refState.selectedCustomerType == 1 && widget.refState.selectedVisitType == 1  ?
               widget.refNotifer.channelPartnerController.text : '',
            )).then((val) {
              if (val != null) {
               widget.refNotifer.selectedStateValue = null;
               widget.refNotifer. selectedDistrictValue = null;
                widget.refNotifer.resetControllersWhenSwitchCustomType(isResetChannel: false);
                ///
                // if (widget.refNotifer.verfiyTypeController.text.toLowerCase() ==
                //     'verified') {
                  CustomerDetails model = val;
                      widget.refState.contactNumberList = (model.contact??[]);
                    widget.refNotifer.shopNameController.text = model.shopName ?? '';
                    widget.refNotifer.selectedshop = model.shop ?? '';
                    widget.refNotifer.selectedExistingCustomer = model.name ?? '';
                    widget.refNotifer.selectedVerificationType = model.verificType ?? '';
                    widget.refNotifer.searchController.text = model.customerName ?? '';
                    widget.refNotifer.customerNameController.text =
                        model.customerName ?? '';
                    if (widget.refState.contactNumberList.isNotEmpty) {
                      widget.refNotifer.numberController.text =
                          widget.refState.contactNumberList[0];
                    }
                    /// calling address api
                  widget.refNotifer
                      .customerAddressApiFunction(context, model.name ?? '', model.verificType ?? '')
                      .then((response) {
                        if(response!=null&& response['data'] != null){
                    CustomerAddressModel addressModel =
                        CustomerAddressModel.fromJson(response);
                       widget.refNotifer.verifiedCustomerLocation = (addressModel.data?.name??'');
                    widget.refNotifer.address1Controller.text =
                        addressModel.data?.addressLine1 ?? '';
                    widget.refNotifer.address2Controller.text =
                        addressModel.data?.addressLine2 ?? '';
                    widget.refNotifer.districtController.text =
                        addressModel.data?.district ?? '';
                    widget.refNotifer.stateController.text =
                        addressModel.data?.state ?? '';
                    widget.refNotifer.pincodeController.text =
                        addressModel.data?.pincode ?? '';
                    widget.refNotifer.addressTypeController.text =
                        addressModel.data?.addressTitle ?? '';
                        if((addressModel.data?.district ?? '').isEmpty && (addressModel.data?.state??'').isNotEmpty){
                          // widget.refNotifer.districtApiFunction(context, stateText: addressModel.data?.state);
                        }
                    
                        }
                  });
                // }
                //  else {
                //   UNVModel model = val;
                //   widget.refNotifer.customerNameController.text =
                //       model.customerName;
                //   widget.refState.contactNumberList = (model.contact??[]);
                //   widget.refNotifer.shopNameController.text = model.shopName;
                //   widget.refNotifer.selectedExistingCustomer = model.customerName;
                //    widget.refNotifer.searchController.text = model.customerName;
                //    widget.refNotifer.verifiedCustomerLocation = model.address??'';
                //    widget.refNotifer.unvName = model.name;
                //   widget.refNotifer.address1Controller.text =
                //       model.addressLine1 ?? '';
                //   widget.refNotifer.address2Controller.text =
                //       model.addressLine2 ?? '';
                //   widget.refNotifer.districtController.text =
                //       model.district ?? '';
                //   widget.refNotifer.stateController.text = model.state ?? '';
                //   widget.refNotifer.pincodeController.text =
                //       model.pincode ?? '';
                //   widget.refNotifer.addressTypeController.text =
                //       model.address ?? '';
                //        if((model.district ?? '').isEmpty && (model.state ?? '').isNotEmpty){
                //           widget.refNotifer.districtApiFunction(context, stateText: model.state);
                //         }
                //   if (widget.refState.contactNumberList.isNotEmpty) {
                //     widget.refNotifer.numberController.text =
                //         widget.refState.contactNumberList[0];
                //   }
                // }
                setState(() {});
              }
            });
          }
        },
      ),
    );
  }

  channelParnterTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Channel Partner", isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        AppTextfield(
          hintText: "Search by name, contact, etc.",
          controller: widget.refNotifer.channelPartnerController,
          isReadOnly: true,
          onTap: () {
            AppRouter.pushCupertinoNavigation(SearchScreen(
              route: 'channel',
            )).then((val) {
              if (val != null) {
                widget.refNotifer.channelPartnerController.text = val;
                // widget.refNotifer.shopNameController.text = val;
                setState(() {});
              }
            });
          },
          suffixWidget: Container(
              width: 33,
              alignment: Alignment.center,
              child: Icon(Icons.expand_more)),
              validator: (val){
                if((val??'').isEmpty){
                  return "Required";
                }
                return null;
              },
        )
      ],
    );
  }

  customerNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Vendor Name", isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        AppTextfield(
          fillColor: false,
          isReadOnly: widget.refNotifer.isReadOnlyFields,
          textInputAction: TextInputAction.next,
          controller: widget.refNotifer.customerNameController,
          hintText: "Enter name",
          inputFormatters: [emojiRestrict()],
          prefixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppAssetPaths.personIcon,
              height: 17,
              width: 14,
            ),
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return "Required";
            }
            return null;
          },
        )
      ],
    );
  }

  shopTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Shop/Bakery name", isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        AppTextfield(
          isReadOnly:widget.refNotifer. isReadOnlyFields,
          controller: widget.refNotifer.shopNameController,
          textInputAction: TextInputAction.next,
          fillColor: false,
          inputFormatters: [emojiRestrict()],
          hintText: "Enter shop name",
          prefixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppAssetPaths.shopIcon,
              height: 14,
              width: 14,
            ),
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return "Required";
            }
            return null;
          },
        )
      ],
    );
  }

  contactTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Contact", isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        AppTextfield(
            isReadOnly: widget.refNotifer.isReadOnlyFields,
            controller: widget.refNotifer.numberController,
            fillColor: false,
            textInputAction: TextInputAction.next,
            hintText: "Enter number",
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            prefixWidget: Container(
              width: 33,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppAssetPaths.callIcon,
                height: 14,
                width: 14,
                color: AppColors.light92Color,
              ),
            ),
            suffixWidget: InkWell(
              onTap: () {
                if(!widget.refNotifer.isReadOnlyFields){
                  if (widget.refState.contactNumberList.length >= 3) {
                    MessageHelper.showToast(
                        "Only 3 contact numbers are allowed.");
                  } else if (widget
                      .refNotifer.numberController.text.isNotEmpty) {
                    widget.refState.contactNumberList
                        .add(widget.refNotifer.numberController.text);
                        widget.refNotifer.numberController.clear();
                    setState(() {});
                      }
                  }
              
              },
              child: Container(
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
              ),
            ),
            validator: numberValidation),
        (widget.refState.contactNumberList).isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: widget.refState.contactNumberList.map((e) {
                    return Stack(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: AppColors.lightEBColor,
                                borderRadius: BorderRadius.circular(25)),
                            alignment: Alignment.center,
                            child: AppText(title: e)),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: InkWell(
                            onTap: () {
                              if(!widget.refNotifer.isReadOnlyFields){
                               widget.refState.contactNumberList.remove(e);
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                  color: AppColors.cardBorder,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.close,
                                size: 10,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
              )
            : Container()
      ],
    );
  }
}
