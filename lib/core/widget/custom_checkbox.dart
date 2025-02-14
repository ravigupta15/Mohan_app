import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';

customCheckbox({bool isCheckbox=false,Function(bool?)?onChanged, Color borderColor = AppColors.lightTextColor,double width =1}){
  return  SizedBox(
        width: 30,
        height: 22,
        child: Checkbox(
          splashRadius: 10,
          activeColor: AppColors.greenColor,
          side: BorderSide(
            color: borderColor,width: width
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          value: isCheckbox,
         onChanged: onChanged
         ),
      );
}