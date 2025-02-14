import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/features/home_module/seles_order/presentation/new_sales_order_screen.dart';
import 'package:mohan_impex/features/home_module/seles_order/widget/draft_order_widget.dart';
import 'package:mohan_impex/features/home_module/seles_order/widget/my_orders_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_router.dart';
import '../../../../res/app_colors.dart';

class SalesOrderHistoryScreen extends StatefulWidget {
  const SalesOrderHistoryScreen({super.key});

  @override
  State<SalesOrderHistoryScreen> createState() => _SalesOrderHistoryScreenState();
}

class _SalesOrderHistoryScreenState extends State<SalesOrderHistoryScreen> {
  int tabBarIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  customAppBar(title: 'Sales Order History'),
      body: Padding(
        padding: const EdgeInsets.only(left: 18,right: 19,top: 14),
        child: Column(
          children: [
            AppSearchBar(
              hintText: "Search by name, phone, etc.",
              suffixWidget: Container(
                alignment: Alignment.center,
                width:  60,
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssetPaths.searchIcon),
                        Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 20,width: 1,color: AppColors.lightBlue62Color.withValues(alpha: .3),
                    ),
                     SvgPicture.asset(AppAssetPaths.filterIcon),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16,),
            CustomTabbar(
              currentIndex: tabBarIndex,
              title1: "My Orders",
              title2: "Draft Order",
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
            tabBarIndex==0?MyOrdersWidget():
            DraftOrderWidget(
            ))
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: (){
        AppRouter.pushCupertinoNavigation(const NewSalesOrderScreen());
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