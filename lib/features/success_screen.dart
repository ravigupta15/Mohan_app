import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class SuccessScreen extends StatelessWidget {
 final String title;
 final String des;
 final String btnTitle;
 final void Function()onTap;
  const SuccessScreen({
    required this.title,
    required this.btnTitle,
    required this.onTap,
  required this.des
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 40,bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: AppColors.black.withValues(alpha: .2),
                      blurRadius: 6
                    )
                  ]
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(AppAssetPaths.successIcon),
                    const SizedBox(height: 21,),
                     AppText(title: title,fontsize: 25,fontFamily: AppFontfamily.poppinsBold,),
                    SizedBox(height: 5),
                    AppText(title: des,
                    textAlign: TextAlign.center,fontsize: 15,
                    ),
                    const SizedBox(height: 26,),
                    AppTextButton(title: btnTitle,width: 122,height: 40,color: AppColors.arcticBreeze,
                    onTap: onTap
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}