import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AppDropDown extends StatelessWidget {
 final ValueChanged? onChanged;
 final String? selectedValue;
 final  String hintText;
final List<DropdownMenuItem<String>>? items;
final double height;
   AppDropDown({this.height= 220,this.items, this.onChanged,this.selectedValue,this.hintText = ''});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
    child: DropdownButton2<String>(
            isExpanded: true,
            hint: Row(
              children: [
                Expanded(
                    child: Text(
                        hintText,
                         style:const TextStyle(
              fontSize: 12,
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
              height: 35,
              width: double.infinity,
              elevation: 0,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                  color: AppColors.edColor
                ))
              )
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.expand_more),
              iconSize: 20,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: height,elevation: 4,
              // useSafeArea: true,
              width: MediaQuery.sizeOf(navigatorKey.currentContext!).width-25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              offset: const Offset(-10, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(2),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData:const  MenuItemStyleData(
              height: 30,
              padding: EdgeInsets.only(left: 14, right: 14,),
            ),
            
          ),
  );
  }
}
