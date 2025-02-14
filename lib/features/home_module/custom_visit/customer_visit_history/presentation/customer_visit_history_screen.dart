import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/customer_visit_history/widget/my_visit_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/customer_visit_history/widget/visit_draft_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/new_customer_visit_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

class CustomerVisitHistoryScreen extends StatefulWidget {
  const CustomerVisitHistoryScreen({super.key});

  @override
  State<CustomerVisitHistoryScreen> createState() => _CustomerVisitHistoryScreenState();
}

class _CustomerVisitHistoryScreenState extends State<CustomerVisitHistoryScreen> {
  int tabBarIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Customer Visit History'),
      body: Padding(
        padding: const EdgeInsets.only(left: 18,right: 18,top: 14),
        child: Column(
          children: [
            AppSearchBar(
              hintText: "Search by name, phone, etc.",
              suffixWidget: Container(
                alignment: Alignment.center,
                width: tabBarIndex==0?40: 60,
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssetPaths.searchIcon),
                    tabBarIndex==0?SizedBox.shrink():
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
              title1: "My Visit",
              title2: "Visit Draft",
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
            tabBarIndex==0?MyVisitWidget():
            VisitDraftWidget())
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: (){
        AppRouter.pushCupertinoNavigation(const NewCustomerVisitScreen());
        },
        child: Container(
          height: 50,width: 50,
          decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Icon(Icons.add,color: AppColors.whiteColor,size: 35,),
        ),
      ),
    );
  }

  
}