import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/kyc_page_number.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/app_text.dart';
import '../../../../core/widget/app_text_field/app_textfield.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/app_text_field/label_text_textfield.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_fontfamily.dart';
import '../../../../res/app_router.dart';
import 'kyc_documant_upload_screen.dart';

class AddKycScreen extends StatefulWidget {
  const AddKycScreen({super.key});

  @override
  State<AddKycScreen> createState() => _AddKycScreenState();
}

class _AddKycScreenState extends State<AddKycScreen> {
  bool isExpand = false;
  String selectedLanguage = '';
  int selectedBusinessType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'KYC'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18,right: 19,top: 14,bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDividerWidget(number: '1',),
              const SizedBox(height: 5,),
              Align(
                alignment: Alignment.center,
                child: AppText(title: 'Customer information',fontFamily: AppFontfamily.poppinsSemibold,),
              ),
              const SizedBox(height: 25),
              LabelTextTextfield(title: 'Customer name', isRequiredStar: true),
              const SizedBox(height: 5),
              commonDropDownWidget("John Doe", "Jane Smith", "Alice Johnson"),
              const SizedBox(height: 15),
              LabelTextTextfield(title: 'Contact', isRequiredStar: true,),
              const SizedBox(height: 5),
              AppTextfield(hintText: "Enter contact", fillColor: false,
              suffixWidget: Container(
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8)
              )
            ),child: Icon(Icons.add,color: AppColors.whiteColor,size: 30,),)),

              const SizedBox(height: 15),
              LabelTextTextfield(title: 'Address', isRequiredStar: true),
              const SizedBox(height: 5),
              AppTextfield(hintText: "Enter address", fillColor: false),
              const SizedBox(height: 15),
              LabelTextTextfield(title: 'Email', isRequiredStar: true),
              const SizedBox(height: 5),
              AppTextfield(hintText: "Enter email", fillColor: false),

              const SizedBox(height: 15),
              LabelTextTextfield(title: 'Business name', isRequiredStar: true),
              const SizedBox(height: 5),
              AppTextfield(hintText: "Enter business name", fillColor: false),

              const SizedBox(height: 15),
              LabelTextTextfield(title: 'Customer Type', isRequiredStar: true),
              const SizedBox(height: 5),
              commonDropDownWidget("Primary", "Basic", "Economic"),

              const SizedBox(height: 15),
              LabelTextTextfield(title: 'Segment', isRequiredStar: true),
              const SizedBox(height: 5),
              commonDropDownWidget("Segment A", "Segment B", "Segment C"),

              const SizedBox(height: 15),
              LabelTextTextfield(
                  title: 'Billing Address', isRequiredStar: true),
              const SizedBox(height: 5),
              AppTextfield(hintText: "Enter billing address", fillColor: false),
              const SizedBox(height: 15),
              LabelTextTextfield(
                  title: 'Shipping Address', isRequiredStar: true),
              const SizedBox(height: 5),
              AppTextfield(hintText: "", fillColor: false),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    customCheckbox(),
                    AppText(title: "Same as billing address",color: AppColors.lightTextColor,fontFamily: AppFontfamily.poppinsMedium,fontsize: 11,)
                  ],
                ),
              ),
              const SizedBox(height: 15),
              businessTypeWidget(),
              const SizedBox(height: 15),
              LabelTextTextfield(title:selectedBusinessType==0? 'GST NO.':"PAN No.", isRequiredStar: false),
              const SizedBox(height: 5),
              AppTextfield(hintText: "", fillColor: false),
              const SizedBox(height: 15),
              LabelTextTextfield(
                title: 'Proposed Credit Limit.',
                isRequiredStar: false,
              ),
              const SizedBox(height: 5),
              AppTextfield(hintText: "", fillColor: false),

              const SizedBox(height: 15),
              LabelTextTextfield(
                title: 'Proposed Credit Days',
                isRequiredStar: false,
              ),
              const SizedBox(height: 10),
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
            const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: AppButton(
                      width: 95,
                      height: 40,
                      color: Colors.black,
                      onPressed: () {
                        //AppRouter.pushReplacementNavigation(const KycScreen());
                      },
                      title: "Back",
                    ),
                  ),
                  Spacer(),
                  Flexible(
                      child: AppButton(
                          width: 95,
                          color: Colors.black,
                          onPressed: () {
                            AppRouter.pushCupertinoNavigation(const KycDocumentUploadScreen());
                          },
                          height: 40,
                          title: "Next")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget businessTypeWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "Business Type",color: AppColors.lightBlue62Color,fontsize: 13,),
        const SizedBox(height: 10,),
        Row(
          children: [
            customRadioButton(isSelected: selectedBusinessType==0? true:false, title: 'Registered',
            onTap: (){
              selectedBusinessType=0;
              setState(() {
                
              });
            }),
            const Spacer(),
            customRadioButton(isSelected:selectedBusinessType==1?true: false, title: 'Unregistered',
            onTap: (){
              selectedBusinessType=1;
              setState(() {
                
              });
            }),
            const Spacer(),
          ],
        )
      ],
    );
  }

  commonDropDownWidget(String value1, String value2, String value3) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: isExpand
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
              border: Border.all(color: AppColors.e2Color, width: 1.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  title: selectedLanguage,
                  fontsize: 14,
                  color: AppColors.black,
                ),
                Icon(Icons.expand_more)
              ],
            ),
          ),
        ),
        if (isExpand)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  color: AppColors.black.withOpacity(.2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                languageTextWidget(value1),
                Divider(color: AppColors.lightEBColor),
                languageTextWidget(value2),
                Divider(color: AppColors.lightEBColor),
                languageTextWidget(value3),
              ],
            ),
          ),
      ],
    );
  }

  languageTextWidget(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = title;
          isExpand = false;
        });
      },
      child: SizedBox(
        height: 22,
        width: double.infinity,
        child: AppText(
          title: title,
          fontsize: 16,
          fontFamily: AppFontfamily.ibmPlexSansRegular,
        ),
      ),
    );
  }

}
