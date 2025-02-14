import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';

Widget indicatorWidget( {required bool isActive,double activeWidth = 16, double inactiveWidth = 35}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 7,
      width: isActive?activeWidth:inactiveWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: isActive ? AppColors.greenColor : AppColors.unselectedIndicatorColor,
      ),
    );
  }