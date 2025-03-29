import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
  
  
  // ignore: must_be_immutable
  class CustomDropDown extends StatelessWidget {
    final ValueChanged? onChanged;
    final String? selectedValue;
    final String hintText;
    List<DropdownMenuItem<String>>? items;
    double height;
    String? Function(String?)? validator;
    bool isfillColor;
    Color hintColor;
    bool isEnable;
   CustomDropDown({required this.items, this.onChanged,this.selectedValue,this.hintText = '', this.validator,
   this.height = double.infinity, this.isfillColor=false, this.hintColor =AppColors.lightTextColor, this.isEnable = true
   });

  @override
  Widget build(BuildContext context) {
    return customDropDown();
  }

Widget customDropDown(){
  return DropdownButtonHideUnderline(
    child: DropdownButtonFormField2<String>(
      // isDense: true,
      decoration: InputDecoration(
          hintStyle: TextStyle(
                    fontSize: 14,color: AppColors.black1,fontFamily: AppFontfamily.poppinsRegular
                  ),
        isDense: true,
        fillColor: isfillColor? AppColors.edColor: AppColors.whiteColor,
        filled: true,
        contentPadding: EdgeInsetsDirectional.all(15),
         enabledBorder: textFormFieldEnabledBorder,
        disabledBorder: textFormFieldDisabledBorder,
        errorBorder: textFormFieldErrorBorder,
        focusedErrorBorder: textFormFieldFocusErrorBorder,
        focusedBorder: textFormFieldFocusBorder,
        border: const OutlineInputBorder(),
      ),
            isExpanded: true,
            validator: validator,
            hint:  Text(
                        hintText,
                         style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: hintColor,
              fontFamily: AppFontfamily.poppinsRegular
            ),
           ),
          
            style: TextStyle(
              fontSize: 13,color: AppColors.black
            ),
            items: items,
            value: selectedValue,
            onChanged:isEnable ? onChanged : null,
            buttonStyleData:const ButtonStyleData(
              width: double.infinity,
              height: 17,
              elevation: 0,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.expand_more,
                color: AppColors.black,
              ),
              iconSize: 20,
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 4,
              maxHeight: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              // offset: const Offset(-8, 0),
              // scrollbarTheme: ScrollbarThemeData(
              //   radius: const Radius.circular(20),
              //   thickness: MaterialStateProperty.all(2),
              //   thumbVisibility: MaterialStateProperty.all(true),
              // ),
            ),
            menuItemStyleData:const  MenuItemStyleData(
              height: 25,
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            
          ),
  );
}

OutlineInputBorder get textFormFieldErrorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
             BorderSide(color: AppColors.redColor),
      );

  OutlineInputBorder get textFormFieldFocusBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:  BorderSide(color: AppColors.e2Color),
      );

  OutlineInputBorder get textFormFieldFocusErrorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
             BorderSide(color:AppColors.e2Color),
      );

  OutlineInputBorder get textFormFieldEnabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.e2Color
        ),
      );

  OutlineInputBorder get textFormFieldDisabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color:  AppColors.e2Color
        ),
      );

 
}