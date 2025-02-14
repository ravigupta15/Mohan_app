import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class CaptureImageScreen extends StatefulWidget {
  const CaptureImageScreen({super.key});

  @override
  State<CaptureImageScreen> createState() => _CaptureImageScreenState();
}

class _CaptureImageScreenState extends State<CaptureImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:customAppBar(title:
       "Submit",
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
          decoration: ShapeDecoration(
            color: AppColors.edColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )),
            child: AppText(title: "1:30:22",fontFamily: AppFontfamily.poppinsMedium,),
        )
      ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssetPaths.captureIcon),
          const SizedBox(height: 10,),
          AppText(title: 'Please Capture Photo With Customer',
          fontsize: 34,fontFamily: AppFontfamily.poppinsSemibold,
          textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40,),
          Align(
            alignment: Alignment.center,
            child: AppTextButton(title: "Capture",color: AppColors.arcticBreeze,
            height: 40,width: 120,
            ),
          )
        ],
      ),
    );
  }
}