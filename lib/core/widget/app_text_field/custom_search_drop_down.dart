import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';


// ignore: must_be_immutable
class CustomSearchDropDown extends StatefulWidget {
  //  final ValueChanged<List<String>>? onChanged;
   final ValueChanged<String>? onChanged;
   String selectedValues;
  final String hintText;
  List<DropdownMenuItem<String>>? items;
  String? Function(String?)? validator;
  TextEditingController? searchController;
 double height;
 bool isfillColor;
 Color hintColor;
   CustomSearchDropDown({required this.items,
    required this.selectedValues,
    this.onChanged,
    this.hintText = '',
    this.validator,
    this.searchController,this.height = double.infinity,
    this.isfillColor = false,this.hintColor = AppColors.lightTextColor
    });

  @override
  State<CustomSearchDropDown> createState() => _CustomSearchDropDownState();
}

class _CustomSearchDropDownState extends State<CustomSearchDropDown> {
  // final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return customDropDown();
  }

   Widget customDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<String>(
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: 14,
            color: AppColors.black1,
            fontFamily: AppFontfamily.poppinsRegular,
          ),
          isDense: true,
          fillColor:widget.isfillColor?AppColors.edColor: AppColors.whiteColor,
          filled: true,
          contentPadding: EdgeInsetsDirectional.only(start: 15, end: 15, top: 15, bottom: 15),
          enabledBorder: textFormFieldEnabledBorder,
          disabledBorder: textFormFieldDisabledBorder,
          errorBorder: textFormFieldErrorBorder,
          focusedErrorBorder: textFormFieldFocusErrorBorder,
          focusedBorder: textFormFieldFocusBorder,
          border: const OutlineInputBorder(),
        ),
        isExpanded: true,
        validator: widget.validator,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                widget.hintText,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: widget.hintColor,
                  fontFamily: AppFontfamily.poppinsRegular,
                ),
              ),
            ),
          ],
        ),
        style: TextStyle(
          fontSize: 14,
          color: AppColors.black,
        ),
        items: widget.items,
        value: widget.selectedValues.isEmpty ? null : widget.selectedValues,
        // value: widget.selectedValues.isEmpty ? null : widget.selectedValues.first,  // Select the first value by default
        onChanged: (String? newValue) {
          print(newValue);
           widget.selectedValues = newValue!;
           if(widget.onChanged != null){
            widget.onChanged!(widget.selectedValues);
           }
          // if (newValue != null) {
            // setState(() {
            //   // Add or remove the selected value from the list
            //   if (widget.selectedValues.contains(newValue)) {
            //     widget.selectedValues.remove(newValue);
            //   } else {
            //     widget.selectedValues.add(newValue);
            //   }
            // });
            // if (widget.onChanged != null) {
            //   widget.onChanged!(widget.selectedValues);
            // }
          // }
        },
        buttonStyleData: const ButtonStyleData(
          width: double.infinity,
          height: 18,
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
          maxHeight: widget.height,
          // width: MediaQuery.sizeOf(navigatorKey.currentContext!).width - 30,
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
        menuItemStyleData: const MenuItemStyleData(
          height: 25,
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: widget.searchController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 60,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
                expands: true,
                maxLines: null,
                controller: widget.searchController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(fontSize: 12),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.greenColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder get textFormFieldErrorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.redColor),
      );

  OutlineInputBorder get textFormFieldFocusBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.e2Color),
      );

  OutlineInputBorder get textFormFieldFocusErrorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.e2Color),
      );

  OutlineInputBorder get textFormFieldEnabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.e2Color),
      );

  OutlineInputBorder get textFormFieldDisabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.e2Color),
      );
}
