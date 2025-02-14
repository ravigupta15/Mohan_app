import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class CustomTabbar extends StatelessWidget {
  final String title1;
  final String title2;
  final int currentIndex;
  final void Function() onClicked1;
  final void Function() onClicked2;
  const CustomTabbar({
    required this.title1,
    required this.title2,
    required this.currentIndex,
    required this.onClicked1,
    required this.onClicked2,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.tabBarColor,
      child: Row(
        children: [
        tabBarItem(title: title1, img: AppAssetPaths.myVisitIcon, index: 0,onTap: onClicked1),
        Container(
          margin: EdgeInsets.only(right: currentIndex==1?14:0,left: currentIndex==0?14:0),
          height: 30,color: Color(0xff64748B).withValues(alpha: .3),width: 1,
        ),
        tabBarItem(title: title2, img: AppAssetPaths.visitIcon, index: 1,onTap: onClicked2),
        ],
      ),
    );
  }
   tabBarItem({required String title, required String img, required int index,Function()?onTap}){
    return  Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color:currentIndex==index? AppColors.whiteColor:AppColors.tabBarColor,
                boxShadow:currentIndex==index? [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: AppColors.black.withValues(alpha: .2),
                    blurRadius: 10
                  )
                ]:[]
              ),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(img,color:currentIndex==index?AppColors.greenColor:AppColors.lightTextColor ,),
                const SizedBox(width: 7,),
                  AppText(title:title,
                  color: currentIndex==index? AppColors.black1:AppColors.unselectedTabBarColor,
                  fontFamily:currentIndex==index? AppFontfamily.poppinsSemibold:AppFontfamily.poppinsRegular,),
                ],
               ),
            ),
          ),
        );
  }
}