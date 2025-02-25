import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';

Widget customRadioButton({required bool isSelected,required String title, Function()?onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            height: 20,width: 20,
            decoration: BoxDecoration(
              border: Border.all(color:isSelected?AppColors.greenColor: AppColors.light92Color,width: 1.4),
              color: isSelected?AppColors.greenColor:null,
              shape: BoxShape.circle
            ),
            alignment: Alignment.center,
            child:isSelected? Icon(Icons.check,color: AppColors.whiteColor,size: 17,):SizedBox.shrink(),
          ),
          const SizedBox(width: 6,),
          AppText(title: title,)
        ],
      ),
    ),
  );
}