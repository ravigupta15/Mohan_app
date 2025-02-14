
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';

class ProductItemsWidget extends StatelessWidget {
  final String title;
  const ProductItemsWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: AppText(title: title,)),
        customContainer(isAdd: false),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AppText(title: "2",),
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

