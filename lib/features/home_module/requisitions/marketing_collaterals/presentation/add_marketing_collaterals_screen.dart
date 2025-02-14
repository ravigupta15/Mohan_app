import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';

class AddMarketingCollateralsScreen extends StatefulWidget {
  const AddMarketingCollateralsScreen({super.key});

  @override
  State<AddMarketingCollateralsScreen> createState() => _AddMarketingCollateralsScreenState();
}

class _AddMarketingCollateralsScreenState extends State<AddMarketingCollateralsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: customAppBar(title: "Marketing Collaterals"),
       body: Padding(
          padding: const EdgeInsets.only(top: 14,left: 17,right: 17,bottom: 20),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelTextTextfield(title: "Material", isRequiredStar: false),
                      const SizedBox(height: 15,),
                      AppTextfield(
                        fillColor:false,suffixWidget: Icon(Icons.expand_more),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelTextTextfield(title: "Quantity", isRequiredStar: false),
                      const SizedBox(height: 15,),
                      AppTextfield(
                        fillColor:false,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14,),
            AppText(title: "Added Items",color: AppColors.mossGreyColor,fontWeight: FontWeight.w400,),
            const SizedBox(height: 10,),
            addedItemWidget(),
            const SizedBox(height: 19,),
            LabelTextTextfield(title: "Remarks", isRequiredStar: false),
            const SizedBox(height: 15,),
            AppTextfield(fillColor: false,maxLines: 3,)
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

  addedItemWidget(){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.edColor),
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.symmetric(horizontal: 21,vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductItemsWidget(title: "T-shirts"),
          const SizedBox(height: 19,),
          _ProductItemsWidget(title: "Total bags"),
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