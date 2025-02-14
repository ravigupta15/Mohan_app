import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';

class SalesRegistrationWidget extends StatefulWidget {
  const SalesRegistrationWidget({super.key});

  @override
  State<SalesRegistrationWidget> createState() => _SalesRegistrationWidgetState();
}

class _SalesRegistrationWidgetState extends State<SalesRegistrationWidget> {

  int selectedCustomerType = 0;
int selectedVisitType = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         customerTypeWidget(),
              selectedCustomerType==1?
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AppSearchBar(
                  hintText: 'Search by name, phone, etc.',
                  suffixWidget: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(AppAssetPaths.searchIcon),
                  ),
                ),
              ):SizedBox.shrink(),
              const SizedBox(height: 20,),
              visitTypeWidget(),
              const SizedBox(height: 20,),
              registrationFieldsWidget()
      ],
    );
  }

  customerTypeWidget(){
  return Column(
    children: [
      Row(
        children: [
          AppText(title: "Vendor Type",color: AppColors.lightTextColor,),
          AppText(title: " *",color: AppColors.redColor,),
        ],
      ),
      const SizedBox(height: 15,),
      Row(
        children: [
          customRadioButton(isSelected:selectedCustomerType==0? true:false, title: "New",onTap: (){
            selectedCustomerType=0;
            setState(() {
              
            });
          }),
          const Spacer(),
          customRadioButton(isSelected: selectedCustomerType==1? true:false, title: "Existing",onTap: (){
            selectedCustomerType=1;
            setState(() {
              
            });
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
          customRadioButton(isSelected:selectedVisitType==0? true:false, title: "Primary",onTap: (){
            selectedVisitType=0;
            setState(() {
              
            });
          }),
          const Spacer(),
          customRadioButton(isSelected: selectedVisitType==1? true:false, title: "Secondary",onTap: (){
            selectedVisitType=1;
            setState(() {
              
            });
          }),
          const Spacer(),
        ],
      ),
    ],
  );
}


registrationFieldsWidget(){
  return Column(
    children: [
         LabelTextTextfield(title: "Channel Partner", isRequiredStar: true),
        const SizedBox(height: 10,),
        AppTextfield(
          hintText: "Search by name, contact, etc.",
          suffixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: Icon(Icons.expand_more)
          ),
        ),
        const SizedBox(height: 20,),
        LabelTextTextfield(title: "Vendor name", isRequiredStar: true),
        const SizedBox(height: 10,),
        AppTextfield(
          fillColor: false,
          hintText: "Vendor name",
          prefixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssetPaths.personIcon,height: 17,width: 14,),
          ),
        ),
        const SizedBox(height: 20,),
          LabelTextTextfield(title: "Shop/Bakery name", isRequiredStar: true),
        const SizedBox(height: 10,),
        AppTextfield(
          fillColor: false,
          hintText: "Enter shop name",
          prefixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssetPaths.shopIcon,height: 14,width: 14,),
          ),
        ),
         const SizedBox(height: 20,),
          LabelTextTextfield(title: "Contact", isRequiredStar: true),
        const SizedBox(height: 10,),
        AppTextfield(
          fillColor: false,
          hintText: "Enter number",
          prefixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssetPaths.callIcon,height: 14,width: 14,color: AppColors.light92Color,),
          ),
          suffixWidget: Container(
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8)
              )
            ),
            child: Icon(Icons.add,color: AppColors.whiteColor,size: 30,),
          ),
        )
    ],
  );
}
}