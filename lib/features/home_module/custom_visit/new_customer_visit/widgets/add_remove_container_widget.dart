
  import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';

Widget customContainerForAddRemove({required bool isAdd, Function()?onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 20,width: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.edColor,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Icon(isAdd? Icons.add:Icons.remove,
        size: 16,
        color: isAdd?AppColors.greenColor:AppColors.redColor,
        ),
      ),
    );
  }
