import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class AddSampleRequisitionsScreen extends StatefulWidget {
  const AddSampleRequisitionsScreen({super.key});

  @override
  State<AddSampleRequisitionsScreen> createState() => _AddSampleRequisitionsScreenState();
}

class _AddSampleRequisitionsScreenState extends State<AddSampleRequisitionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Sample Requisitions",),
      body: Padding(
        padding: const EdgeInsets.only(left:19,top: 14,right: 18,bottom: 20),
        child: Column(
          children: [
            _AddedItemsWidget(),
            const SizedBox(height: 15,),
            _DateWidget(),
            const SizedBox(height: 15,),
            RemarksWidget()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 20,left: 120,right: 120
       ),
       child: AppTextButton(title: "Submit",color: AppColors.arcticBreeze,height: 38,width: 100,),
       ),
    );
  }
}

class _AddedItemsWidget extends StatelessWidget {
  const _AddedItemsWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
             BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
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
                    border: Border.all(color: AppColors.edColor)
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
          const SizedBox(height: 12,),
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
          ),
          // AppTextfield(
          //   fillColor: false,
          //   isReadOnly: true,
          //   hintText: "Please add items",
          // )
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

class _DateWidget extends StatelessWidget {
  const _DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           AppText(title: 'Sample Required date',fontFamily:AppFontfamily.poppinsSemibold,fontsize: 12,),
           const SizedBox(height: 12,),
           AppTextfield(
            fillColor: false,
            isReadOnly: true,
            suffixWidget: Container(
              margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.circular(6)
            ),
            child: Icon(Icons.add,color: AppColors.whiteColor,size: 30,),
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
        customContainer(isAdd: false),
         Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.edColor
                )
              ),
              child: AppText(title: "2",fontsize: 12,),
            ),
        customContainer(isAdd: true),
        const SizedBox(width: 30,),
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