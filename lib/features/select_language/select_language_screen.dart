import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_logo.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/features/auth/sign-in/pages/sign_in_screen.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {

  bool isExpand = false;
  String selectedLanguage = 'Select Language';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
               appLogoWidget(),
                const SizedBox(height: 40,),
                AppText(title: "Select Language",fontsize: 22,fontFamily: AppFontfamily.poppinsSemibold,),
                const SizedBox(height: 31,),
                languageExapndableWidget(),
                const Spacer(),
                Padding(padding: EdgeInsets.only(left: 19,right: 19,bottom: 20),
                child: AppButton(title: "Next",onPressed: (){
                  AppRouter.pushCupertinoNavigation(const SignInScreen());
                },),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  languageExapndableWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              if(isExpand){
                isExpand=false;
              }
              else{
                isExpand=true;
              }
              setState(() {
                
              });
            },
            child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.edColor,
              borderRadius:isExpand?
              BorderRadius.only(
                topLeft: Radius.circular(10),topRight: Radius.circular(10),
              ):
               BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               AppText(title: selectedLanguage,fontsize: 14,color: AppColors.lightTextColor,),
               Icon( 
                Icons.keyboard_arrow_down,color: AppColors.lightTextColor,)
              ],
            )
          ),
          ),
          isExpand?
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  offset:const Offset(0, 2),
                  color: AppColors.black.withOpacity(.2),
                  blurRadius: 4
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                languageTextWidget('English'),
                Divider(color: AppColors.lightEBColor,),
                languageTextWidget('Hindi'),
                Divider(color: AppColors.lightEBColor,),
                languageTextWidget('Other languages'),
              ],
            ),
          ):Container()
        ],
      ),
    );
  }

  languageTextWidget(String title){
    return GestureDetector(
      onTap: (){
        selectedLanguage = title;
        isExpand=false;
        setState(() {
        });
      },
      child: SizedBox(
        height: 22,
        width: double.infinity,
        child: AppText(title: title,
        fontsize: 16,fontFamily: AppFontfamily.ibmPlexSansRegular,
        ),
      ),
    );
  }

}