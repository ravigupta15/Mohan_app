import 'package:flutter/material.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/app_navigation/pages/app_navigation_screen.dart';
import 'package:mohan_impex/features/auth/sign-in/pages/sign_in_screen.dart';
import 'package:mohan_impex/features/onboarding/onboarding_screen.dart';
import 'package:mohan_impex/res/app_router.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


@override
  void initState() {
    Future.delayed(Duration(seconds: 1),(){
      if(LocalSharePreference.isFirstTime){
        if(LocalSharePreference.token.isNotEmpty){
     AppRouter.pushReplacementNavigation(const AppNavigationScreen());     
      }
      else{
    AppRouter.pushReplacementNavigation(const SignInScreen());
      }
      }
      else{
   AppRouter.pushReplacementNavigation(const OnboardingScreen());
      }
      
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}