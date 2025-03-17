import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/services/location_service.dart';
import 'package:mohan_impex/features/home_module/home/presentation/home_screen.dart';
import 'package:mohan_impex/features/leaderboard/presentation/pages/leaderboard_screen.dart';
import 'package:mohan_impex/features/profile/presentation/pages/profile_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/utils/message_helper.dart';

enum CheckInCheckOutType{IN, OUT}

class AppNavigationScreen extends ConsumerStatefulWidget {
  const AppNavigationScreen({super.key});

  @override
  ConsumerState<AppNavigationScreen> createState() => _AppNavigationScreenState();
}

class _AppNavigationScreenState extends ConsumerState<AppNavigationScreen> {
  int selectedIndex = 0;
  List list = [
    HomeScreen(),
    LeaderboardScreen(),
    Container(),
    ProfileScreen(),
  ];

LocationService locationService = LocationService();

  // Start location updates every 5 seconds
  void startLocationUpdates() async {
     locationService.startLocationUpdates(); 
  }

  // Stop location updates
  void stopLocationUpdates() {
    locationService.stopLocationUpdates(); 
  }

  @override
  void dispose() {
    // Make sure to stop the location updates when leaving the screen
    locationService.stopLocationUpdates();
    super.dispose();
  }


 @override
  void initState() {
    super.initState();
  }

DateTime? currentBackPressTime;


Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    // if (selectedIndex!=0) {
    //   selectedIndex = 0;
    //   setState(() {
        
    //   });
    //   return Future.value(false);
    //   // showTimerController.pauseAudioOnBack();
    // }
    // else {
    //   if(selectedIndex==1||selectedIndex==2){
    //     selectedIndex=0;
    //     setState(() {
          
    //     });
    //     return Future.value(false);
    //   }
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        MessageHelper.showToast('Press again to exit app');
        return Future.value(false);
      }
      setState(() {
        
      });
      exit(0);
    }
    // return true;
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: list[selectedIndex],
            bottomNavigationBar: bottomNavigationbarWidget()
      ),
    );
  }
bottomNavigationbarWidget(){
  return  CurvedNavigationBar(
            color: AppColors.whiteColor,
            height: 60,
            buttonBackgroundColor: AppColors.greenColor,
        backgroundColor: AppColors.edColor,
        items: <Widget>[
         SvgPicture.asset(AppAssetPaths.appNavigationIcon1,color: selectedIndex==0?AppColors.whiteColor:AppColors.light92Color,),
         SvgPicture.asset(AppAssetPaths.appNavigationIcon2,color: selectedIndex==1?AppColors.whiteColor:AppColors.light92Color,),
         SvgPicture.asset(AppAssetPaths.appNavigationIcon3,color: selectedIndex==2?AppColors.whiteColor:AppColors.light92Color,),
         SvgPicture.asset(AppAssetPaths.appNavigationIcon4,color: selectedIndex==3?AppColors.whiteColor:AppColors.light92Color,),
        ],
        onTap: (index) {
          selectedIndex = index;
          setState(() {
            
          });
          //Handle button tap
        },
      );
}


}