import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohan_impex/res/app_colors.dart';

// ignore: must_be_immutable
class AppTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  Widget? suffixWidget;
  Widget? prefixWidget;
  FocusNode? focusNode;
  bool isObscureText;
  final bool fillColor;
  final int maxLines;
  Function()? onTap;
  AppTextfield(
      {this.controller,
      this.hintText,
      this.textInputType = TextInputType.text,
      this.inputFormatters,
      this.isReadOnly = false,
      this.textInputAction,
      this.validator,
      this.onChanged,
      this.suffixWidget,
      this.prefixWidget,
      this.textCapitalization = TextCapitalization.none,
      this.focusNode,
      this.onTap,this.maxLines = 1,
      this.isObscureText = false,this.fillColor=true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      readOnly: isReadOnly,
      obscureText: isObscureText,
      // cursorHeight: 20,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      style:const TextStyle(
        fontSize: 14,color: AppColors.black1,
      ),
      decoration: InputDecoration(
        filled: true,
          hintText: hintText,
          suffixIcon: suffixWidget,
          prefixIcon: prefixWidget,
          // isDense: true,
          // contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
          // isCollapsed: true,
          // isDense: true,
          fillColor:fillColor? AppColors.edColor:AppColors.whiteColor,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 45,
            minHeight: 50,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 35,
            minHeight: 4,
          ),
          hintStyle: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              color: AppColors.lightTextColor,),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color:fillColor? AppColors.edColor:AppColors.e2Color)
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color:fillColor? AppColors.edColor:AppColors.e2Color)
          ),
          errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.redColor)
          ),
          focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.redColor)
          )
              ),
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
    );
  }
}
