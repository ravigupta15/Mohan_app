import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';

class RoundedTabBarWidget extends StatelessWidget {
  const RoundedTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _roundedContainer(AppColors.greenColor),
        Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: _divider(),),
        _roundedContainer(AppColors.greenColor),
        Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: _divider(),),
        _roundedContainer(AppColors.black),
      ],
    );
  }

_divider(){
  return Container(
width: 50,color: AppColors.greenColor,height: 1,
  );
}

  _roundedContainer(Color bgColor){
    return Container(
      height: 16,width: 16,
      decoration: BoxDecoration(
        // border: Border.all(color: AppColors.lightTextColor),
        color: bgColor,
        shape: BoxShape.circle
      ),
    );
  }
}