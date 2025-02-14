import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';


class BookTrialScreen extends StatefulWidget {
  const BookTrialScreen({super.key});

  @override
  State<BookTrialScreen> createState() => _BookTrialScreenState();
}

class _BookTrialScreenState extends State<BookTrialScreen> {
  int selectedTrialType = 0;
  bool isAddedItems = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Product Trial",
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
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 14,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            selectItemWidget(),
            const SizedBox(height: 15,),
            _BookAppointmentWidget(),
            const SizedBox(height: 15,),
            trialTypeWidget(),
            const SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: AppButton(title: "Submit",color: AppColors.arcticBreeze,
              height: 44,width: 150,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectItemWidget(){
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: 'Selected Items',fontFamily:AppFontfamily.poppinsSemibold,fontsize: 12,),
              GestureDetector(
                onTap: (){
                  isAddedItems=true;
                  setState(() {
                    
                  });
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
          isAddedItems?
           Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.e2Color,width: .5),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.symmetric(horizontal: 21,vertical: 15),
            child: Column(
              children: [
                _ProductItemsWidget(title: "Item1"),
                const SizedBox(height: 10,),
                _ProductItemsWidget(title: "Item2"),
                const SizedBox(height: 10,),
                _ProductItemsWidget(title: "Item3"),

              ],
            ),
          ):
          AppTextfield(
            fillColor: false,
            isReadOnly: true,
            hintText: "Please add items",
          )
        ],
      ),
    );
  }

Widget trialTypeWidget(){
  return Container(
     padding: EdgeInsets.only(left: 15,right: 15,top: 9,bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           AppText(title: "Select Trial Type",fontFamily: AppFontfamily.poppinsSemibold,),
          const SizedBox(height: 10,),
           Row(
          children: [
            customRadioButton(isSelected: selectedTrialType==0? true:false, title: 'Self',
            onTap: (){
              selectedTrialType =0;
              setState(() {
                
              });
            }),
            const Spacer(),
            customRadioButton(isSelected: selectedTrialType==1? true:false, title: 'TSM Required',
            onTap: (){
              selectedTrialType=1;
              setState(() {
              });
            }
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 15,),
        selectedTrialType==0?
        selfWidget():
        tsmRequiredWidget()
        ],
      ),
  );
}

Widget tsmRequiredWidget(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelTextTextfield(title: "Trial Location", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: false,
      suffixWidget: Icon(Icons.expand_more),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Customer Type", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: false,
      suffixWidget: Icon(Icons.expand_more),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Customer Name", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: false,
      suffixWidget: Icon(Icons.expand_more),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Business Name", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: true,
      isReadOnly: true,
      suffixWidget: Icon(Icons.expand_more),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Contact No.", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: true,
      isReadOnly: true,
      suffixWidget: Container(
              height: 33,width: 33,
              decoration:BoxDecoration(
                color: AppColors.greenColor,
                borderRadius: BorderRadius.circular(5)
              ) ,
              child: Icon(Icons.add,color: AppColors.whiteColor,size: 20,),
            ),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Location", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: true,
      isReadOnly: true,
      suffixWidget: Icon(Icons.expand_more),
      ),
    ],
  );
}



Widget selfWidget(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelTextTextfield(title: "Trial Location", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: false,
      suffixWidget: Icon(Icons.expand_more),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Customer Type", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: false,
      suffixWidget: Icon(Icons.expand_more),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Customer Name", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: false,
      suffixWidget: Icon(Icons.expand_more),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Business Name", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: false,
      suffixWidget: Icon(Icons.expand_more),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Contact No.", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: false,
      suffixWidget: Container(
              height: 33,width: 33,
              decoration:BoxDecoration(
                color: AppColors.greenColor,
                borderRadius: BorderRadius.circular(5)
              ) ,
              child: Icon(Icons.add,color: AppColors.whiteColor,size: 20,),
            ),
      ),
      const SizedBox(height: 15,),

      LabelTextTextfield(title: "Location", isRequiredStar: false,fontFamily: AppFontfamily.poppinsSemibold,
      textColor: AppColors.black1,
      ),
      const SizedBox(height: 12,),
      AppTextfield(fillColor: false,
      suffixWidget: Icon(Icons.expand_more),
      ),
    ],
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

class _BookAppointmentWidget extends StatelessWidget {
  const _BookAppointmentWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
 padding: EdgeInsets.only(left: 15,right: 15,top: 9,bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title: "Book Appointment",fontFamily: AppFontfamily.poppinsSemibold,),
          const SizedBox(height: 10,),
          AppTextfield(
            fillColor: false,
            suffixWidget: Container(
              height: 33,width: 33,
              margin: EdgeInsets.all(8),
              decoration:BoxDecoration(
                color: AppColors.greenColor,
                borderRadius: BorderRadius.circular(5)
              ) ,
              child: Icon(Icons.add,color: AppColors.whiteColor,size: 20,),
            ),
          )
        ],
      ),
    );
  }
}
class _ProductItemsWidget extends StatelessWidget {
 final String title;
   _ProductItemsWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: AppText(title: title,)), 
        SvgPicture.asset(AppAssetPaths.deleteIcon)
      ],
    );
  }
   Widget customContainer({required bool isAdd}){
    return InkWell(
      onTap: (){},
      child: Container(
        height: 18,width: 18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.edColor,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Icon(isAdd? Icons.add:Icons.remove,
        size: 16,
        color: isAdd?AppColors.greenColor:AppColors.redColor,
        ),
      ),
    );
  }
}