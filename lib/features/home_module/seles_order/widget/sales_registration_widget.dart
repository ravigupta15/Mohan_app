import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/helper/dropdown_item_helper.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/core/widget/date_picker_bottom_sheet.dart';
import 'package:mohan_impex/features/home_module/search/presentation/search_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_notifier.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/utils/app_date_format.dart';
import 'package:mohan_impex/utils/app_validation.dart';
import 'package:mohan_impex/utils/message_helper.dart';

import '../../../../../core/widget/app_text_field/custom_drop_down.dart';
import '../../../../../res/app_asset_paths.dart';

class SalesRegistrationWidget extends StatefulWidget {
  final AddSalesOrderNotifier refNotifer;
  final AddSalesOrderState refState;
  const SalesRegistrationWidget(
      {super.key, required this.refNotifer, required this.refState});

  @override
  State<SalesRegistrationWidget> createState() => _SalesRegistrationWidgetState();
}

class _SalesRegistrationWidgetState extends State<SalesRegistrationWidget>
    with AppValidation {
  final unvCustomerSearchController = TextEditingController();
   DateTime selectedDay = DateTime.now().add(Duration(days: 1)); // Track the selected day
  DateTime focusedDay = DateTime.now().add(Duration(days: 1));

  DateTime currentDay = DateTime.now().add(Duration(days: 1)); // Track the selected day
  DateTime currentfocusedDay = DateTime.now().add(Duration(days: 1));
  
 
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // widget.refState.selectedCustomerType == 1
        //     ? Column(
        //         children: [
        //           customerNameSearchDropdown()
        //         ],
        //       )
        //     : SizedBox.shrink(),
        // const SizedBox(
        //   height: 20,
        // ),
        visitTypeWidget(),
        const SizedBox(
          height: 20,
        ),
        registrationWidget()
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
                  setState(() {
                    
                  });
                }),
            const Spacer(),
            customRadioButton(
                isSelected:
                    widget.refState.selectedVisitType == 1 ? true : false,
                title: "Secondary",
                onTap: () {
                  widget.refNotifer.updateVisitType(1);
                  setState(() {
                    
                  });
                }),
            const Spacer(),
          ],
        ),
      ],
    );
  }


  registrationWidget() {
    return Column(
      children: [
        widget.refState.selectedVisitType == 0? EmptyWidget():
         Padding(padding: EdgeInsets.only(bottom: 18),
         child: channelParnterTextField(),
         ),
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
        deliveryDateTextField(),
        const SizedBox(
          height: 18,
        ),
        Row(
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
          isReadOnly: true,
          textInputAction: TextInputAction.next,
          controller: widget.refNotifer.customerNameController,
          hintText: "Select name",
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
          onTap: (){
            if(widget.refState.selectedVisitType == 1 && widget.refNotifer.channelPartnerController.text.isEmpty){
                 MessageHelper.showToast("Please select the channel partner to search the customer");
            }
            else{
           widget.refState.customerInfoModel = null;
            AppRouter.pushCupertinoNavigation(SearchScreen(
              route: 'verified',
                visitType: AppConstants.visitTypeList[widget.refState.selectedVisitType],
              channelParter:widget.refState.selectedVisitType ==1 ? widget.refNotifer.channelPartnerController.text : ''
            )).then((val) {
              if (val != null) {
                  CustomerDetails model = val;
                      widget.refState.contactNumberList = (model.contact??[]);
                    widget.refNotifer.shopNameController.text = model.shopName ?? '';
                    widget.refNotifer.selectedExistingCustomer = model.name ?? '';
                    widget.refNotifer.searchController.text = model.customerName ?? '';
                    widget.refNotifer.selectedshop = model.shop ?? '';
                    widget.refNotifer.selectedVerificationType = model.verificType ?? '';
                    widget.refNotifer.customerNameController.text =
                        model.customerName ?? '';
                    if (widget.refState.contactNumberList.isNotEmpty) {
                      widget.refNotifer.numberController.text =
                          widget.refState.contactNumberList[0];
                    }
                setState(() {});
              }
            }); 
          }
          }
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
          isReadOnly: true,
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



  deliveryDateTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Delivery Date", isRequiredStar: true),
        const SizedBox(
          height: 10,
        ),
        AppTextfield(
          isReadOnly: true,
          controller: widget.refNotifer.deliveryDateController,
          textInputAction: TextInputAction.next,
          fillColor: false,
          inputFormatters: [emojiRestrict()],
          hintText: "Select delivery date",
          onTap: (){
            currentDay = selectedDay;
            currentfocusedDay = focusedDay;
            setState(() {
            });
            datePickerBottomsheet(context);
          },
           suffixWidget: Container(
              height: 33,
              width: 33,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.add,
                color: AppColors.whiteColor,
                size: 25,
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
            isReadOnly: true,
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
            : Container()
      ],
    );
  }


  datePickerBottomsheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors.whiteColor,
        context: context,
        builder: (context) {
          return Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              child: StatefulBuilder(builder: (context, state) {
                return ViewDatePickerWidget(
                    selectedDay: currentDay,
                    focusedDay: currentfocusedDay,
                    firstDay: DateTime.now().add(Duration(days: 1)),
                    onDaySelected: (selectedDay, focusedDay) {
                      state(() {});
                      currentDay = selectedDay;
                      currentfocusedDay = focusedDay;
                    },
                    applyTap: () {
                      state(() {});
                      selectedDay = currentDay;
                      focusedDay = currentfocusedDay;
                      widget.refNotifer.deliveryDateController.text = AppDateFormat.datePickerView(selectedDay);
                      Navigator.pop(context);
                    });
              }),
            );
          });
        });
  }

}
