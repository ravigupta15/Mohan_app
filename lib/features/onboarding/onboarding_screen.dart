import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/indicator_widget.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/select_language/select_language_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController; // Add a PageController
  List list = [
    {
      'image': AppAssetPaths.onboarding1Image,
      'title': "Trusted by millions of people, part of one part",
    },
    {
      'image': AppAssetPaths.onboarding2Image,
      'title': "Empowering Your Sales Journey, One Click at a Time!",
    },
    {
      'image': AppAssetPaths.onboarding3Image,
      'title': "Smart Sales, Smarter Profits.",
    },
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            itemCount: list.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return screenContent(index);
            }));
  }

  Widget screenContent(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19, bottom: 30),
      child: Column(
        children: [
          const Spacer(),
          SvgPicture.asset(list[index]['image']),
          const Spacer(),
          indicator(),
          const SizedBox(height: 22,),
          AppText(
            title: list[index]['title'],
            fontsize: 34,
            fontFamily: AppFontfamily.poppinsSemibold,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          AppButton(
            title: "Next",
            onPressed: () {
              _updateIndex(index);
            },
          )
        ],
      ),
    );
  }

  Widget indicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(list.length, (index) {
          return selectedIndex == index
              ? indicatorWidget(isActive:  true)
              : indicatorWidget(isActive: false);
        }));
  }

  _updateIndex(index) {
    if (selectedIndex < list.length - 1) {
      setState(() {
        selectedIndex = index + 1;
      });
      _pageController.animateToPage(
        selectedIndex,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      ); //
    }
    else{
      LocalSharePreference.setIsFirstTime = true;
      AppRouter.pushCupertinoNavigation(const SelectLanguageScreen());
    }
  }
}
