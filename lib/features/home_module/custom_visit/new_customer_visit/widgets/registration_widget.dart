import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/services/location_service.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/features/home_module/search/presentation/search_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_google_map.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/utils/app_validation.dart';
import 'package:mohan_impex/utils/message_helper.dart';

import '../../../../../res/app_asset_paths.dart';

class RegistrationWidget extends StatefulWidget {
  final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
  const RegistrationWidget({super.key,
  required this.refNotifer,required this.refState
  });

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> with AppValidation {
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
         customerTypeWidget(),
             widget.refState.selectedCustomerType==1?
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AppSearchBar(
                  hintText: 'Search by name, phone, etc.',
                  isReadOnly: true,
                  controller: widget.refNotifer.searchController,
                  onTap: (){
                    AppRouter.pushCupertinoNavigation( SearchScreen(route: "customer",)).then((val){
                      if(val!=null){
                        CustomerDetails model = val;
                        widget.refNotifer.customerNameController.text = model.customerName;
                        widget.refState.contactNumberList = model.contact??[];
                        widget.refNotifer.shopNameController.text = model.shop;
                        widget.refState.selectedExistingCustomer = model.customer;
                        if(widget.refState.contactNumberList.isNotEmpty){
                          widget.refNotifer.numberController.text = widget.refState.contactNumberList[0];
                        }
                        setState(() {                          
                        });
                      }
                    });
                  },
                ),
              ):SizedBox.shrink(),
              const SizedBox(height: 20,),
              visitTypeWidget(),
              const SizedBox(height: 20,),
              _registrationWidget()

      ],
    );
  }

   customerTypeWidget(){
  return Column(
    children: [
      Row(
        children: [
          AppText(title: "Customer Type",color: AppColors.lightTextColor,),
          AppText(title: " *",color: AppColors.redColor,),
        ],
      ),
      const SizedBox(height: 15,),
      Row(
        children: [
          customRadioButton(isSelected:widget.refState.selectedCustomerType==0? true:false, title: "New",onTap: (){
            widget.refNotifer.updateCustomerType(0);
          }),
          const Spacer(),
          customRadioButton(isSelected: widget.refState.selectedCustomerType==1? true:false, title: "Existing",onTap: (){
            widget.refNotifer.updateCustomerType(1);
          }),
          const Spacer(),
        ],
      ),
    ],
  );
}

visitTypeWidget(){
  return Column(
    children: [
      LabelTextTextfield(title: "Visit Type", isRequiredStar: true),
      const SizedBox(height: 15,),
      Row(
        children: [
          customRadioButton(isSelected:widget.refState.selectedVisitType==0? true:false, title: "Primary",onTap: (){
           widget.refNotifer.updateVisitType(0);
          }),
          const Spacer(),
          customRadioButton(isSelected: widget.refState.selectedVisitType==1? true:false, title: "Secondary",onTap: (){
            widget.refNotifer.updateVisitType(1);
          }),
          const Spacer(),
        ],
      ),
    ],
  );
}

Widget _registrationWidget(){
  return Column(
    children: [
      widget.refState.selectedCustomerType == 0 && widget.refState.selectedVisitType==0?
        _newCustomerPrimaryVisitWidget():
        widget.refState.selectedCustomerType==0 && widget.refState.selectedVisitType==1?
        _newCustomerSecondaryVisitWidget():
        widget.refState.selectedCustomerType==1 && widget.refState.selectedVisitType==0?
        _existingCustomerPrimaryVisitWidget():
       widget.refState. selectedCustomerType==1 && widget.refState.selectedVisitType==1?
      _existingCustomerSecondayVisitWidget():Container(),
        const SizedBox( height: 18,),
        SizedBox(
          height: 200,
          child: AppGoogleMap(),
        ),
        Align(alignment: Alignment.centerRight,
      child: InkWell(
        onTap: (){
          LocationService().startLocationUpdates();
        },
        child: Container(
          width: 90,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(7)
          ),
          alignment: Alignment.center,
          child: AppText(title: 'Fetch',fontsize: 13,),
        ),
      ),
      )
    ],
  );
}

Widget _newCustomerPrimaryVisitWidget(){
    return Column(
      children: [
        customerNameTextField(),
        const SizedBox(height: 18,),
        shopTextField(
        ),
        const SizedBox(height: 18,),
        contactTextField(),
      ],
    );
  }

  Widget _newCustomerSecondaryVisitWidget(){
    return Column(
      children: [
     channelParnterTextField(),
        const SizedBox(height: 18,),
        customerNameTextField(
        ),
        const SizedBox(height: 18,),
        shopTextField(
        ),
        const SizedBox(height: 18,),
        contactTextField(),
      ],
    );
  }

  Widget _existingCustomerPrimaryVisitWidget(){
    return Column(
      children: [
        customerNameTextField(),
        const SizedBox(height: 18,),
        shopTextField(
        ),
        const SizedBox(height: 18,),
        contactTextField(),
      ],
    );
  }

   Widget _existingCustomerSecondayVisitWidget(){
    return Column(
      children: [
     channelParnterTextField(),
        const SizedBox(height: 18,),
        customerNameTextField(
        ),
        const SizedBox(height: 18,),
        shopTextField(
        ),
        const SizedBox(height: 18,),
        contactTextField(),
      ],
    );
  }

  channelParnterTextField(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Channel Partner", isRequiredStar: true),
        const SizedBox(height: 10,),
        AppTextfield(
          hintText: "Search by name, contact, etc.",
          controller: widget.refNotifer.channelPartnerController,
          isReadOnly: true,
          onTap: (){
            AppRouter.pushCupertinoNavigation(SearchScreen(route: 'channel',)).then((val){
              if(val!=null){
                 widget.refNotifer.channelPartnerController.text = val;
                 widget.refNotifer.shopNameController.text = val;
                   setState(() {                          
                        });
                      }
            });
          },
          suffixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: Icon(Icons.expand_more)
          ),

        )
      ],
    );
  }

  customerNameTextField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Vendor Name", isRequiredStar: true),
        const SizedBox(height: 10,),
        AppTextfield(
          fillColor: false,
          textInputAction: TextInputAction.next,
          controller: widget.refNotifer.customerNameController,
          hintText: "Enter name",
          inputFormatters: [
            emojiRestrict()
          ],
          prefixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssetPaths.personIcon,height: 17,width: 14,),
          ),
          validator: (val){
            if(val!.isEmpty){
              return "Please enter name";
            }
            return null;
          },
        )
      ],
    );
  }

  shopTextField(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Shop/Bakery name", isRequiredStar: true),
        const SizedBox(height: 10,),
        AppTextfield(
          controller:widget.refNotifer.shopNameController,
          textInputAction: TextInputAction.next,
          fillColor: false,
          inputFormatters: [
            emojiRestrict()
          ],
          hintText: "Enter shop name",
          prefixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssetPaths.shopIcon,height: 14,width: 14,),
          ),
          validator: (val){
            if(val!.isEmpty){
              return "Please enter shop name";
            }
            return null;
          },
        )
      ],
    );
  }

  contactTextField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Contact", isRequiredStar: true),
        const SizedBox(height: 10,),
        AppTextfield(
          controller: widget.refNotifer.numberController,
          fillColor: false,
          textInputAction: TextInputAction.done,
          hintText: "Enter number",
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10)
          ],
          prefixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssetPaths.callIcon,height: 14,width: 14,color: AppColors.light92Color,),
          ),
          suffixWidget: InkWell(
            onTap: (){
               if(widget.refState.contactNumberList.length>=3){
                MessageHelper.showToast("Only 3 contact numbers are allowed.");
              }
             else if(widget.refNotifer.numberController.text.isNotEmpty){
                widget.refState.contactNumberList.add(widget.refNotifer.numberController.text);
              setState(() {
              });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)
                )
              ),
              child: Icon(Icons.add,color: AppColors.whiteColor,size: 30,),
            ),
          ),
          validator: numberValidation
        ),
        (widget.refState.contactNumberList).isNotEmpty?
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(top: 10),
          child: Row(
          children: widget.refState.contactNumberList.map((e){
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.lightEBColor,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  alignment: Alignment.center,
                  child: AppText(title: e)),
                  Positioned(
                    right: 0,top: 0,
                    child: InkWell(
                      onTap: (){
                        widget.refState.contactNumberList.remove(e);
                        setState(() {
                          
                        });
                      },
                      child: Container(
                        height: 12,width: 12,
                        decoration: BoxDecoration(
                          color: AppColors.cardBorder,
                          shape: BoxShape.circle
                        ),
                        child: Icon(Icons.close,size: 10,),
                      ),
                    ),
                  )
              ],
            );
          }).toList(),
          ),
        ):Container()
      ],
    );
  }
}