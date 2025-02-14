import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/new_customer_registration_textfield_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({super.key});

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {

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
                ),
              ):SizedBox.shrink(),
              const SizedBox(height: 20,),
              visitTypeWidget(),
              const SizedBox(height: 20,),
              NewCustomerRegistrationTextfieldWidget(customerTypeIndex: selectedCustomerType,visitTypeIndex: selectedVisitType,),
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
}