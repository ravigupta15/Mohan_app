// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/app_navigation/riverpod/app_navigation_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 12,bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileWidget(),
            const SizedBox(height: 20,),
            profileTypesWidget(),
            const SizedBox(height: 26,),
            AppText(title: "More",fontsize: 16,fontFamily: AppFontfamily.poppinsSemibold,),
            const SizedBox(height: 20,),
            moreProfileTypesWidget(),
            const SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: AppTextButton(title: "Logout",color: AppColors.arcticBreeze,width: 120,height: 40,
              onTap: (){
                dialogBox();
              },
              ),
            )
          ],
        ),
      ),
    );
  }  

Widget profileTypesWidget(){
return Container(
  padding: EdgeInsets.only(left: 15,right: 15,bottom: 5),
  decoration: BoxDecoration(
    color: AppColors.whiteColor,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 0),
        color: AppColors.black.withValues(alpha: .2),
        blurRadius: 3
      )
    ]
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ProfileTypeActionWidget(title: "My Account", des: 'Make changes to your account', img: AppAssetPaths.personIcon),
       _ProfileTypeActionWidget(title: "Sales Target", des: 'See your sales performance', img: AppAssetPaths.starIcon),
       _ProfileTypeActionWidget(title: "Notifications/Alerts", des: 'Manage notifications and alerts', img: AppAssetPaths.notificationIcon),
       _ProfileTypeActionWidget(title: "Settings and Preferences", des: 'Manage settings and prefrences', img: AppAssetPaths.settingIcon,isDivider: false,),
    ],
  ),
);
}

Widget moreProfileTypesWidget(){
  return Container(
  padding: EdgeInsets.only(left: 15,right: 15,bottom: 5),
  decoration: BoxDecoration(
    color: AppColors.whiteColor,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 0),
        color: AppColors.black.withValues(alpha: .2),
        blurRadius: 3
      )
    ]
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _ProfileTypeActionWidget(title: "Help & Support", des: 'Need help?', img: AppAssetPaths.securityIcon),
       _ProfileTypeActionWidget(title: "About App", des: 'Learn more about app', img: AppAssetPaths.heartIcon,
       isDivider: false,
       ),
    ],
  ),
);
}

dialogBox() {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 20, right: 20, bottom: 33),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: "Logout",
                    color: AppColors.black,
                    fontsize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 25,),
                  Align(
                    alignment: Alignment.center,
                    child: AppText(
                      title:"Are you sure you want to logout?",
                      fontsize: 14,
                      fontFamily: AppFontfamily.poppinsMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Flexible(
                        child: AppTextButton(
                            title: "No",
                            height: 50,
                            width: double.infinity,
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ),
                      const SizedBox(width: 20,),
                      Flexible(
                        child: AppTextButton(
                            title: "Yes",
                            height: 50,
                            width: double.infinity,
                            onTap: (){
                              Navigator.pop(context);
                              ref.read(appNavigationProvider.notifier).logoutApiFunction(context);
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

}

class _ProfileWidget extends StatelessWidget {
  const _ProfileWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.greenColor
      ),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 11),
      child: Row(
        children: [
          Image.asset('assets/dummy/Ellipse 56 (1).png',height: 98,),
          const SizedBox(width: 5,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title: "Bryan Wolf",
              fontsize: 16,color: AppColors.whiteColor,fontFamily: AppFontfamily.poppinsSemibold,
              ),
              const SizedBox(height: 4,),
              AppText(title: 'Sales Executive',fontsize: 14,color: AppColors.whiteColor,fontFamily: AppFontfamily.poppinsMedium,),
              const SizedBox(height: 4,),
              AppText(title: 'bryanwolf@gmail.com',fontsize: 14,color: AppColors.whiteColor,fontFamily: AppFontfamily.poppinsMedium,)
            ],
          )
        ],
      ),
    );
  }
}

class _ProfileTypeActionWidget extends StatelessWidget {
  final String title;
  final String des;
  final String img;
  final bool isDivider;
   _ProfileTypeActionWidget({
   required this.title,
   required this.des,
   required  this.img,
    this.isDivider=true
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15,bottom: 10),
      decoration: BoxDecoration(
        border:isDivider ? Border(
          bottom:  BorderSide(color: AppColors.edColor,width: 1)
        ) : null
      ),
      child: Row(
        children: [
          Container(
            height: 40,width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.scaffoldBackgroundColor
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(img,colorFilter: ColorFilter.mode(AppColors.greenColor, BlendMode.srcIn),
            height: 20,
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(title: title,
            fontsize: 14,fontFamily: AppFontfamily.poppinsMedium,
            ),
                AppText(title: des,
            fontsize: 12,fontFamily: AppFontfamily.poppinsRegular,
            color: AppColors.abColor,
            ),
            
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios,color: AppColors.lightTextColor,size: 17,)
        ],
      ),
    );
  }
}