import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/add_kyc_screen.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/approved_widget.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/pending_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  int tabBarIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'KYC'),
      body: Padding(
        padding: const EdgeInsets.only(left: 18,right: 18,top: 14),
        child: Column(
          children: [
            AppSearchBar(
              hintText: "Search by ticket number",
              suffixWidget: Container(
                alignment: Alignment.center,
                width: tabBarIndex==0?60: 60,
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssetPaths.searchIcon,width: 24,height: 24,),
                    Row(
                      children: [
                        Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 20,width: 1,color: AppColors.lightBlue62Color.withValues(alpha: .3),
                    ),
                     SvgPicture.asset(AppAssetPaths.filterIcon),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16,),
            CustomTabbar(
              currentIndex: tabBarIndex,
              title1: "Approved",
              title2: "Pending",
              onClicked1: (){
                tabBarIndex=0;
                setState(() {
                });
              },
              onClicked2: (){
                tabBarIndex=1;
                setState(() {
                });
              },
            ),
            const SizedBox(height: 10,),
            Expanded(child: 
            tabBarIndex==0?
            ApprovedWidget():
            PendingWidget())
          ],
        ),
      ),
      floatingActionButton: floatingActionButtonWidget(
        onTap: (){
          AppRouter.pushCupertinoNavigation(const AddKycScreen());
        }
      ),
    );
  }

  
}