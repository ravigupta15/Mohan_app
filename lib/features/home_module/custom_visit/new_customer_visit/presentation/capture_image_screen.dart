import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohan_impex/core/services/image_picker_service.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/timer_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

import '../riverpod/new_customer_visit_state.dart';

class CaptureImageScreen extends StatelessWidget {
     final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
  const CaptureImageScreen({super.key, required this.refNotifer,required this.refState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:customAppBar(title:
       "Submit",
      actions: [
        timerWidget(refState.currentTimer)
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
            height: 40,width: 120,onTap: (){
              ImagePickerService.imagePicker(ImageSource.camera).then((val){
                if(val!=null){
                  Navigator.pop(context, val);
                }
              });
            },
            ),
          )
        ],
      ),
    );
  }
}