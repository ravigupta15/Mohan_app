

  import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/services/location_service.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/home/model/dashboard_model.dart';
import 'package:mohan_impex/features/home_module/home/riverpod/home_notifier.dart';
import 'package:mohan_impex/features/home_module/home/riverpod/home_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_google_map.dart';
import 'package:mohan_impex/utils/app_date_format.dart';
import 'package:mohan_impex/utils/extension.dart';




class HeaderWidget extends StatelessWidget {
  final HomeNotifier homeNotifier;
  final HomeState homeState;
  final DashboardLastLog? lastLog;
   HeaderWidget({super.key, required this.homeNotifier, required this.homeState,
   required this.lastLog
   });

    

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 210,
            child: Stack(
              children: [
                header(),
                Positioned(
                  bottom: 0,left: 0,right: 0,
                  child: checkInCheckOutWidget(context),
                )
              ],
            ),
          );
  }

  header(){
    return Container(
            height: 180,
            width: double.infinity,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 65,left: 25,right: 15),
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(150),
                bottomRight: Radius.circular(150)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                AppText(title: "Home",color: AppColors.whiteColor,fontsize: 18,fontFamily: AppFontfamily.poppinsSemibold,),
                const Spacer(),
                SvgPicture.asset(AppAssetPaths.notificationIcon)
              ],
            ),
          );
  }

  checkInCheckOutWidget(BuildContext context){
    return Container(
      width: double.infinity,
      height: 97,
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(title: "Hey, ${LocalSharePreference.userName.capitalizeFirstLetter()}",
          color: AppColors.black,fontFamily: AppFontfamily.poppinsSemibold,
          ),
          (lastLog?.lastLogType??'').isNotEmpty?
          AppText(title: "Last check-${(lastLog?.lastLogType??'').isNotEmpty? lastLog?.lastLogType.toString().toLowerCase() : ''} was at ${AppDateFormat.formatDateToRelative((lastLog?.lastLogTime ??''))}",color: AppColors.mossGreyColor,fontsize: 12,
          textAlign: TextAlign.center,
          ) : Container(),
          AppTextButton(title: "Check-${(lastLog?.lastLogType=="IN" ? "Out" : "In")}",
          width: 112,
          height: 30,color: AppColors.arcticBreeze,
          onTap: (){
            LocationService().startLocationUpdates();
            showMapBottomSheet(context);
          },   
          )
        ],
      ),
    );
  }

showMapBottomSheet(BuildContext context){
  showModalBottomSheet(
    backgroundColor: AppColors.scaffoldBackgroundColor,
    isScrollControlled: true,
    context: context, builder: (ctx){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 13,vertical: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 24,width: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.edColor
                  ),
                  child: Icon(Icons.close,size: 19,),
                ),
              ),
            ),
            const SizedBox(height: 6,),
            AppText(title: AppDateFormat.timeWithMilisecond(DateTime.now().toString()),
            fontsize: 14,fontFamily: AppFontfamily.poppinsSemibold,
            ),
            const SizedBox(height: 3,),
            AppText(title: AppDateFormat.formatDate(DateTime.now().toString()),fontsize: 12,color: AppColors.lightTextColor,),
            const SizedBox(height: 4,),
            AppText(title: 'Latitude: ${LocalSharePreference.currentLatitude}, Longitude: ${LocalSharePreference.currentLongitude}',fontsize: 12,color: AppColors.lightTextColor,),
            const SizedBox(height: 24,),
            SizedBox(
              height: 150,
              child: AppGoogleMap(),
            ),
            const SizedBox(height:17),
            AppTextButton(title: "Confirm Check ${(lastLog?.lastLogType=="OUT"||(lastLog?.lastLogType??'').isEmpty ? "In" : "Out")}",height: 35,width: 190,color: AppColors.arcticBreeze,
            onTap: (){
              print((lastLog?.lastLogType=="OUT" ||(lastLog?.lastLogType??'').isEmpty ? "IN" : "OUT"));
              Navigator.pop(context);
              homeNotifier.checkInApiFunction(context, type: (lastLog?.lastLogType=="OUT" ||(lastLog?.lastLogType??'').isEmpty ? "IN" : "OUT"));
            },
            )
          ],
        ),
      );
  });
}
}