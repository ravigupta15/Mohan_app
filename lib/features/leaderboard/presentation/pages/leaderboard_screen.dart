import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Leaderboard",isBack: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            proflieWidget(),
            rankListWidget()
          ],
        ),
      ),
    );
  }

  proflieWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
                    alignment: Alignment.center,
                    child: userRandProfile(img:'assets/dummy/Ellipse 56.png',rank: '2',
                    title: "Bryan Walf",percentage: '43%'
                    )
                  ),
          ),
          SizedBox(
            height: 155,
            width: 100,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: userRandProfile(img:'assets/dummy/Ellipse 55.png',rank: '1',
                  title: "Bryan Walf",percentage: '43%'
                  )
                ),
                  Positioned(
                    top: 0,right: 0,left: 0,
                    child: SvgPicture.asset(AppAssetPaths.crownIcon),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
                    alignment: Alignment.center,
                    child: userRandProfile(img:'assets/dummy/Ellipse 57.png',rank: '3',
                    title: "Bryan Walf",percentage: '43%'
                    )
                  ),
          ),
        ],
      ),
    );
  }

userRandProfile({
  required String img,
  required String title,
  required String rank,
  required String percentage
}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
                  height: 78,
                  width: 70,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(img),
                        ),
                      ),
                      Positioned(
                        bottom: 0,left: 0,right: 0,
                        child: rankTitleWidget(rank))
                    ],
                  ),
                ),
                const SizedBox(height: 2,),
                AppText(title: title,fontFamily: AppFontfamily.poppinsSemibold,),
                const SizedBox(height: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssetPaths.workoutIcon),
                    const SizedBox(width: 5,),
                    AppText(title: percentage,fontsize: 13,)
                  ],
                ),
    ],
  );
}

  rankTitleWidget(String title){
    return Container(
      height: 18,width: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.greenColor
      ),
      alignment: Alignment.center,
      child: AppText(title: title,fontsize: 12,fontFamily: AppFontfamily.poppinsSemibold,),
    );
  }

  rankListWidget(){
    return ListView.separated(
      separatorBuilder: (context,sb){
        return const SizedBox(height: 10,);
      },
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 15,right: 16,top: 17),
      itemBuilder: (context,index){
        return Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withValues(alpha: .2),
                blurRadius: 2
              )
            ],
            borderRadius: BorderRadius.circular(6)
          ),
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
          child: Row(
            children: [
              AppText(title: "5",fontsize: 14,color: AppColors.rankColor,fontFamily: AppFontfamily.poppinsSemibold,),
              const SizedBox(width: 5,),
              Image.asset('assets/dummy/Ellipse 56 (1).png',height: 32,),
              const SizedBox(width: 6,),
              Expanded(child: AppText(title: "Marsha Fisher",
              color: AppColors.black,fontFamily: AppFontfamily.poppinsMedium,
              maxLines: 1,)),
              AppText(title: '36 %',color: AppColors.percentageColor,)
            ],
          ),
        );
    });
  }
}