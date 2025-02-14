import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/product_items_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
      decoration: BoxDecoration(
        color:AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffE2E2E2)),
      ),
      child: Column(
        children: [
          _prodcutsWidget("Bread"),
          const SizedBox(height: 10,),
          _prodcutsWidget("Cake"),
        ],
      ),
    );
  }

  Widget _prodcutsWidget( String title){ 
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title: title,fontFamily: AppFontfamily.poppinsMedium,),
          Padding(padding: EdgeInsets.only(top: 9,bottom: 4),
          child: dotteDivierWidget(dividerColor:  AppColors.edColor,thickness: 1.6),),
          ProductItemsWidget(title: 'Item 1',),
          const SizedBox(height: 15,),
          ProductItemsWidget(title: 'Item 2',),
          const SizedBox(height: 15,),
          ProductItemsWidget(title: 'Item 3',),
        ],
      ),
    );
  }
}
