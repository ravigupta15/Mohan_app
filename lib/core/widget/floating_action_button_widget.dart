import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

Widget floatingActionButtonWidget({required Function()onTap}){
  return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,width: 50,
          decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Icon(Icons.add,color: AppColors.whiteColor,size: 35,),
        ),
      );
}