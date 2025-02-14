import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';

// ignore: must_be_immutable
class AppSearchBar extends StatelessWidget {
   final TextEditingController? controller;
  final String? hintText;
 final ValueChanged<String>? onChanged;
 Widget? suffixWidget;
 final bool isReadOnly;
 final void Function()?onTap;
   AppSearchBar({this.controller,this.hintText,this.onChanged,this.suffixWidget,this.onTap,this.isReadOnly=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.edColor,
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.only(left: 15),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        readOnly: isReadOnly,      
        style:const TextStyle(
          fontSize: 14
        ),
        textAlign: TextAlign.start,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixWidget,
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 4,
              minHeight: 4,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 4,
              minHeight: 4,
            ),
            hintStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlue62Color,),
           border: InputBorder.none,
                ),
        onChanged: onChanged,
        // onTap: onTap,
        // validator: validator,
      ),
    );
  }
}