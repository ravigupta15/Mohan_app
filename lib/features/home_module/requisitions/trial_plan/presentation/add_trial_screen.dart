import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import '../../../../../res/app_fontfamily.dart';

class AddTrialScreen extends StatefulWidget {
  const AddTrialScreen({super.key});

  @override
  State<AddTrialScreen> createState() => _AddTrialScreenState();
}

class _AddTrialScreenState extends State<AddTrialScreen> {
  bool isExpand = false;
  String selectedLanguage = '';
  int selectedBusinessType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(title: 'Trial Plan'),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 18,right: 19,top: 14,bottom: 30),
        child:Column(
          children: [
            screenContentWidget(),
            const SizedBox(height: 30,),
            selectItemWidget(),
            const SizedBox(height: 30,),
            RemarksWidget(),
            const SizedBox(height: 30,),
            
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
                // AppRouter.pushCupertinoNavigation( SuccessScreen(
                //   title: '',
                //   des: "You have successfukky Submitted", btnTitle: "Track", onTap: (){
                //   Navigator.pop(context);
                //   Navigator.pop(context);
                // }));
              },),
            ],
           )
          
          ],
        )
      ),
    );
  }

  Widget screenContentWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .1),
            blurRadius: 1
          )
        ]
      ),
      child: Column(
        children: [
         businessTypeWidget(),
         const SizedBox(height: 20,),
          dateTimeWidget(),
          const SizedBox(height: 19,),
          LabelTextTextfield(title: 'Trial location', isRequiredStar: false),
          const SizedBox(height: 12,),
          AppTextfield(fillColor: false,
            suffixWidget: Icon(Icons.expand_more),
          ),
          const SizedBox(height: 19,),
          LabelTextTextfield(title: 'Trial Type', isRequiredStar: false),
          const SizedBox(height: 12,),
          AppTextfield(fillColor: false,
            suffixWidget: Icon(Icons.expand_more),
          ),

          const SizedBox(height: 19,),
          LabelTextTextfield(title: 'Customer Type', isRequiredStar: false),
          const SizedBox(height: 12,),
          AppTextfield(fillColor: false,
            suffixWidget: Icon(Icons.expand_more),
          ),

          const SizedBox(height: 19,),
          LabelTextTextfield(title: 'Customer Name', isRequiredStar: false),
          const SizedBox(height: 12,),
          AppTextfield(fillColor: false,
            suffixWidget: Icon(Icons.expand_more),
          ),

          const SizedBox(height: 19,),
          LabelTextTextfield(title: 'Business Name', isRequiredStar: false),
          const SizedBox(height: 12,),
          AppTextfield(fillColor: false,
            suffixWidget: Icon(Icons.expand_more),
          ),

          const SizedBox(height: 19,),
          LabelTextTextfield(title: 'ContactNo.', isRequiredStar: false),
          const SizedBox(height: 12,),
          AppTextfield(fillColor: false,
            suffixWidget: Icon(Icons.expand_more),
          ),
          
          const SizedBox(height: 19,),
          LabelTextTextfield(title: 'Location', isRequiredStar: false),
          const SizedBox(height: 12,),
          AppTextfield(fillColor: false,
            suffixWidget: Icon(Icons.expand_more),
          ),
          
        ],
      ),
    );
  }

  dateTimeWidget(){
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelTextTextfield(title: "Date", isRequiredStar: false),
            const SizedBox(height: 10,),
            AppDateWidget()
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelTextTextfield(title: "Time", isRequiredStar: false),
            const SizedBox(height: 10,),
            AppDateWidget()
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget businessTypeWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Select Trial Type", isRequiredStar: false),
        const SizedBox(height: 10,),
        Row(
          children: [
            customRadioButton(isSelected: selectedBusinessType==0? true:false, title: 'Self',
            onTap: (){
              selectedBusinessType=0;
              setState(() {
                
              });
            }),
            const Spacer(),
            customRadioButton(isSelected:selectedBusinessType==1?true: false, title: 'TSM Required',
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

  selectItemWidget(){
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
         border: Border.all(color: AppColors.e2Color),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .1),
            blurRadius: 1
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: 'Selected Items',fontFamily:AppFontfamily.poppinsSemibold,fontsize: 12,),
              GestureDetector(
                onTap: (){
                  addItemBottomSheet(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.lightBlue62Color,width: .5)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                  child: Row(
                    children: [
                      Icon(Icons.add,color: AppColors.lightBlue62Color,size: 15,),
                      AppText(title: "Add Items",fontsize: 12,)
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          AppTextfield(
            fillColor: false,
            isReadOnly: true,
            hintText: "Please add items",
          )
        ],
      ),
    );
  }

addItemBottomSheet(BuildContext context){
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context, builder: (context){
      return Container(
         padding: EdgeInsets.only(top: 14,bottom: 50),
        child: Column(
           mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
                  padding: const EdgeInsets.only(right: 11),
                  child: Row(
                    children: [
                      const Spacer(),
                      AppText(title: "Search Item",fontsize: 16,fontFamily: AppFontfamily.poppinsSemibold,),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 24,width: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.edColor,
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.close,size: 19,),
                        ),
                      )
                    ],
                  ),
                ),
               const SizedBox(height: 15,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 15),
                 child: AppTextfield(
                  fillColor: false,
                  suffixWidget: Container(
                    padding: EdgeInsets.all(6),
                    child: SvgPicture.asset(AppAssetPaths.searchIcon),
                  ),
                 ),
               )
          ],
        ),
      );
    });
  }
}
class LabelTextTextfield extends StatelessWidget {
  final String title;
  final bool isRequiredStar;
  const LabelTextTextfield({required this.title, required this.isRequiredStar});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(title: title,color: AppColors.black,fontFamily: AppFontfamily.poppinsMedium,),
      ],
    );
  }
}
