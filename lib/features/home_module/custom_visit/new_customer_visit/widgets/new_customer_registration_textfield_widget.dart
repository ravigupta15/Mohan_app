import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';

class NewCustomerRegistrationTextfieldWidget extends StatelessWidget {
  final int customerTypeIndex;
  final int visitTypeIndex; 
  const NewCustomerRegistrationTextfieldWidget({required this.customerTypeIndex,required this.visitTypeIndex  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customerTypeIndex==0&&visitTypeIndex==0?
        _newCustomerPrimaryVisitWidget():
        customerTypeIndex==0&&visitTypeIndex==1?
        _newCustomerSecondaryVisitWidget():
        customerTypeIndex==1&&visitTypeIndex==0?
        _existingCustomerPrimaryVisitWidget():
        customerTypeIndex==1&&visitTypeIndex==1?
      _existingCustomerSecondayVisitWidget():Container(),
        const SizedBox(height: 18,),
        _LocationWidget()
      ],
    );
  }
Widget _newCustomerPrimaryVisitWidget(){
    return Column(
      children: [
        _CustomerNameTextField(),
        const SizedBox(height: 18,),
        _ShopTextField(),
        const SizedBox(height: 18,),
        _ContactTextField(),
      ],
    );
  }

  Widget _newCustomerSecondaryVisitWidget(){
    return Column(
      children: [
  _ChannelPartnerTextField(),
        const SizedBox(height: 18,),
        _CustomerNameTextField(),
        const SizedBox(height: 18,),
        _ShopTextField(),
        const SizedBox(height: 18,),
        _ContactTextField(),
      ],
    );
  }

  Widget _existingCustomerPrimaryVisitWidget(){
    return Column(
      children: [
        _CustomerNameTextField(),
        const SizedBox(height: 18,),
        _ContactTextField(),
      ],
    );
  }

   Widget _existingCustomerSecondayVisitWidget(){
    return Column(
      children: [
  _ChannelPartnerTextField(),
        const SizedBox(height: 18,),
        _CustomerNameTextField(),
        const SizedBox(height: 18,),
        _ContactTextField(),
      ],
    );
  }
}

class _ChannelPartnerTextField extends StatelessWidget {
  const _ChannelPartnerTextField();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        )
      ],
    );
  }
}


class _CustomerNameTextField extends StatelessWidget {
  const _CustomerNameTextField();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Customer name", isRequiredStar: true),
        const SizedBox(height: 10,),
        AppTextfield(
          fillColor: false,
          hintText: "Enter name",
          prefixWidget: Container(
            width: 33,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssetPaths.personIcon,height: 17,width: 14,),
          ),
        )
      ],
    );
  }
}

class _ShopTextField extends StatelessWidget {
  const _ShopTextField();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        )
      ],
    );
  }
}

class _ContactTextField extends StatelessWidget {
  const _ContactTextField();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

class _LocationWidget extends StatelessWidget {
  const _LocationWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Location", isRequiredStar: true),
        const SizedBox(height: 10,),
      Image.asset('assets/dummy/map.png'),
      const SizedBox(height: 10,),
      Align(alignment: Alignment.centerRight,
      child: Container(
        width: 90,
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.greenColor,
          borderRadius: BorderRadius.circular(7)
        ),
        alignment: Alignment.center,
        child: AppText(title: 'Fetch',fontsize: 13,),
      ),
      )
      ],
    );
  }
} 



