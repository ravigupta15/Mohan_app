import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  final String title;
  VoidCallback?onPressed;
  Color color;
   double height;
   double? width;
   bool isLoading;
   AppButton({required this.title,this.onPressed, this.color = AppColors.greenColor,
   this.height =56.0,this.width ,this.isLoading=false
   });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading?color.withOpacity(.4): 
       color,
       disabledBackgroundColor: isLoading?color.withOpacity(.4): 
       color,
        fixedSize: Size(width??MediaQuery.sizeOf(context).width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      onPressed: onPressed,
     child:isLoading?
    const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        backgroundColor: AppColors.whiteColor,
      strokeWidth: 2,
     ),
     ):
       AppText(title: title,
      color: AppColors.whiteColor,
      fontFamily: AppFontfamily.poppinsMedium,
      fontsize: 18
          ));
  }
}