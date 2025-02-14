import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/documents_widget.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

class AddComplaintScreen extends StatefulWidget {
  const AddComplaintScreen({super.key});

  @override
  State<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  int selectedCustomerTypeIndex = 0;
  int selectedClaimTypeIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Complaints & Claim"),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 14,left: 18,right:18,bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customerTypeWidget(),
            const SizedBox(height: 15,),
            claimTypeWidget(),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Company Name"),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Contact Person Name"),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Contact",suffix: Container(
               decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.circular(6)
            ),
            child: Icon(Icons.add,color: AppColors.whiteColor,size: 30,),
            )),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "State"),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Town"),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Pincode"),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Item Name",suffix: Icon(Icons.expand_more)),
            const SizedBox(height: 15,),
            invoiceNoAndDateWidget(),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Complaint Item Quantity"),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Value of Goods"),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Batch no."),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "MFD"),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Expiry"),
            const SizedBox(height: 15,),
            textfieldWithTitleWidget(title: "Reason for Complaint"),
            const SizedBox(height: 15,),
            imageWidget(),
            const SizedBox(height: 40,),
            Center(child: AppButton(title: "Submit",color: AppColors.arcticBreeze,height: 40,width: 120,
            onPressed: (){
              AppRouter.pushCupertinoNavigation( SuccessScreen(
               title: 'Ticket #1324', des: "You have successfully created ticket", btnTitle: "Track", onTap: (){
                Navigator.pop(context);
                Navigator.pop(context);
               }));
            },
            ))
          ],
        ),
      ),
    );
  }

  Widget textfieldWithTitleWidget({required String title, Widget? suffix}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          LabelTextTextfield(title: title, isRequiredStar: false),
          const SizedBox(height: 10,),
          AppTextfield(fillColor: false,suffixWidget: suffix,),
                    
      ],
    );
  }

 Widget invoiceNoAndDateWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Invoice no & Date", isRequiredStar: false),
        const SizedBox(height: 15,),
        Row(
          children: [
            Expanded(child: AppTextfield(
              fillColor: false,
            )),
            const SizedBox(width: 30,),
            AppDateWidget(),
             SizedBox(width: MediaQuery.of(context).size.width*.2,)
          ],
        )
      ],
    );
  }

Widget imageWidget(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title: "Attach Image/Video",color: AppColors.lightTextColor,),
              AppText(title: "Upload or capture a clear photo or video",fontsize: 10,color: AppColors.lightTextColor,),
            ],
          ),
          
          Icon(Icons.add,color: AppColors.greenColor,size: 25,)
        ],
      ),
      const SizedBox(height: 20,),
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: DocumantWidget(
                  image: AppAssetPaths.cameraIcon,
                  title: "Camera",
                  subtitle: "Take a photo",
                )),
                SizedBox(width: 25,),
                Expanded(
                    child: DocumantWidget(
                  image: AppAssetPaths.uploadIcon,
                  title: "Upload",
                  subtitle: "PDF, JPG, PNG",
                )),
              ],
            ),

    ],
  );
}

  customerTypeWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Customer Type", isRequiredStar: false),
        const SizedBox(height: 15,),
        Row(
          children: [
            customRadioButton(isSelected: selectedCustomerTypeIndex==0? true:false, title: 'Primary'),
            const Spacer(),
            customRadioButton(isSelected: selectedCustomerTypeIndex==1? true:false, title: 'Secondary'),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 14,),
        LabelTextTextfield(title: "Date", isRequiredStar: false),
        const SizedBox(height: 15,),
        AppTextfield(hintText: "DD-MM-YYYY",),
      ],
    );
  }

  Widget claimTypeWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Claim Type", isRequiredStar: false),
        const SizedBox(height: 15,),
        Row(
          children: [
            customRadioButton(isSelected: selectedClaimTypeIndex==0? true:false, title: 'Transit',
            onTap: (){
              selectedClaimTypeIndex =0;
              setState(() {
                
              });
            }
            ),
            const Spacer(),
            customRadioButton(isSelected: selectedClaimTypeIndex==1? true:false, title: 'Quality'),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}