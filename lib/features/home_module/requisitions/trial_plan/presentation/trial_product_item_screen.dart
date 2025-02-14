import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class TrialProductItemScreen extends StatefulWidget {
  const TrialProductItemScreen({super.key});

  @override
  State<TrialProductItemScreen> createState() => _TrialProductItemScreenState();
}

class _TrialProductItemScreenState extends State<TrialProductItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Trial #124"),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 25,right: 25),
        child: Column(
          children: [
            Center(
              child: AppText(title: "Item 1",fontFamily: AppFontfamily.poppinsSemibold,),
            ),
            const SizedBox(height: 14,),
            LabelTextTextfield(title: "Value 1", isRequiredStar: false),
            const SizedBox(height: 14,),
            AppTextfield(fillColor: false,),
            const SizedBox(height: 14,),
            LabelTextTextfield(title: "Value 2", isRequiredStar: false),
            const SizedBox(height: 14,),
            AppTextfield(fillColor: false,),
            const SizedBox(height: 14,),
            LabelTextTextfield(title: "Value 3", isRequiredStar: false),
            const SizedBox(height: 14,),
            AppTextfield(fillColor: false,),
            
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppTextButton(title: "Submit",color: AppColors.arcticBreeze,height: 40,width: 110,),
    );
  }
}