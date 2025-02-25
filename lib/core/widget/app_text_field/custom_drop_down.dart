import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
  
  
  // ignore: must_be_immutable
  class CustomDropDown extends StatelessWidget {
    final ValueChanged? onChanged;
    final String? selectedValue;
    final String hintText;
    List<DropdownMenuItem<String>>? items;
    String? Function(String?)? validator;
   CustomDropDown({required this.items, this.onChanged,this.selectedValue,this.hintText = '', this.validator});

  @override
  Widget build(BuildContext context) {
    return customDropDown();
  }

Widget customDropDown(){
  return DropdownButtonHideUnderline(
    child: DropdownButtonFormField2<String>(
      decoration: InputDecoration(
          hintStyle: TextStyle(
                    fontSize: 14,color: AppColors.black1,fontFamily: AppFontfamily.poppinsRegular
                  ),
        isDense: true,
        
        fillColor:  AppColors.whiteColor,
        filled: true,
        contentPadding: EdgeInsetsDirectional.only(
            start: 15, end: 15, top: 15, bottom: 15),
      
         enabledBorder: textFormFieldEnabledBorder,
        disabledBorder: textFormFieldDisabledBorder,
        errorBorder: textFormFieldErrorBorder,
        focusedErrorBorder: textFormFieldFocusErrorBorder,
        focusedBorder: textFormFieldFocusBorder,
        border: const OutlineInputBorder(),
      ),
            isExpanded: true,
            validator: validator,
            hint: Row(
              children: [
                Expanded(
                    child: Text(
                        hintText,
                         style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.lightTextColor,
              fontFamily: AppFontfamily.poppinsRegular
            ),
           )),
              ],
            ),
          
            style: TextStyle(
              fontSize: 14,color: AppColors.black
            ),
            items: items,
            value: selectedValue,
            onChanged: onChanged,
            buttonStyleData:const ButtonStyleData(
              // height: 35,
              width: double.infinity,
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
              // width: MediaQuery.sizeOf(navigatorKey.currentContext!).width-0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              offset: const Offset(-8, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(20),
                thickness: MaterialStateProperty.all(2),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData:const  MenuItemStyleData(
              height: 25,
              padding: EdgeInsets.only(left: 16, right: 16,),
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
        borderSide:  BorderSide(color:AppColors.e2Color),
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