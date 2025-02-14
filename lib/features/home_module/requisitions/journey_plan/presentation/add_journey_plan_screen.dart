import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

class AddJourneyPlanScreen extends StatefulWidget {
  const AddJourneyPlanScreen({super.key});

  @override
  State<AddJourneyPlanScreen> createState() => _AddJourneyPlanScreenState();
}

class _AddJourneyPlanScreenState extends State<AddJourneyPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.lightEBColor,
      appBar: customAppBar(title: "Journey Plan",),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 19,right: 18,top: 12,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            visitDateWidget(),
            const SizedBox(height: 15,),
            LabelTextTextfield(title: "Nature of Travel", isRequiredStar: false),
            const SizedBox(height: 8,),
            AppTextfield(
            fillColor: false,
            suffixWidget: SizedBox(
              child: Icon(Icons.expand_more),
            ),
           ),
           const SizedBox(height: 15,),
            LabelTextTextfield(title: "Night Out Location", isRequiredStar: false),
            const SizedBox(height: 8,),
            AppTextfield(
            fillColor: false,
           ),
           const SizedBox(height: 15,),
            LabelTextTextfield(title: "Travel To State", isRequiredStar: false),
            const SizedBox(height: 8,),
            AppTextfield(
            fillColor: false,
           ),
           const SizedBox(height: 15,),
            LabelTextTextfield(title: "Travel To District", isRequiredStar: false),
            const SizedBox(height: 8,),
            AppTextfield(
            fillColor: false,
           ),
           const SizedBox(height: 15,),
            LabelTextTextfield(title: "Mode of travel", isRequiredStar: false),
            const SizedBox(height: 8,),
            AppTextfield(
            fillColor: false,
            
           ),
           const SizedBox(height: 15,),
            LabelTextTextfield(title: "Remarkds", isRequiredStar: false),
            const SizedBox(height: 8,),
            AppTextfield(
            fillColor: false,
            maxLines: 3,
           ),
           const SizedBox(height: 40,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextButton(title: "Cancel",color: AppColors.arcticBreeze,width: 100,height: 40,
              onTap: (){
                Navigator.pop(context);
              },
              ),
              AppTextButton(title: "Next",color: AppColors.arcticBreeze,width: 100,height: 40,onTap: (){
                AppRouter.pushCupertinoNavigation( SuccessScreen(
                  title: '',
                  des: "You have successfukky Submitted", btnTitle: "Track", onTap: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                }));
              },),
            ],
           )
          ],
        ),
      ),
    );
  }

  Widget visitDateWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "Visit Date",color: AppColors.lightTextColor),
            const SizedBox(height: 10,),
             Row(
                children: [
                  AppDateWidget(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: 8,height: 2,
                    color: AppColors.black,
                  ),
                   AppDateWidget(),
                ],
              ),
      ],
    );
  }

}