import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/customer_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/new_customer_visit_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/riverpod/customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_details/presentation/visit_details_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/shimmer/list_shimmer.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';

class CustomerVisitHistoryScreen extends ConsumerStatefulWidget {
  const CustomerVisitHistoryScreen({super.key});

  @override
  ConsumerState<CustomerVisitHistoryScreen> createState() => _CustomerVisitHistoryScreenState();
}

class _CustomerVisitHistoryScreenState extends ConsumerState<CustomerVisitHistoryScreen> {
  int tabBarIndex=0;

@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    ref.read(customVisitProvider.notifier).customVisitApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    // final refNotifier = ref.read(customVisitProvider.notifier);
    print(LocalSharePreference.token);
    final refState = ref.watch(customVisitProvider);
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
            tabBarIndex==0 ? 
            myVisitWidget(refState):
            visitDraftWidget(refState))
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

  Widget myVisitWidget(CustomerVisitState refState){
    return refState.isLoading?
    CustomerVisitShimmer(isShimmer: refState.isLoading,isKyc: true,):
     (refState.customerVisitModel?.data?[0].myVisit?.length??0)>0?
    ListView.separated(
       separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: (refState.customerVisitModel?.data?[0].myVisit?.length??0),
      padding: EdgeInsets.only(top: 10,bottom: 20),
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        return _VisitItemsWidget(isKyc: true,myVisit: refState.customerVisitModel?.data?[0].myVisit?[index],);
    }): NoDataFound(title: "No data available");
  }

Widget visitDraftWidget(CustomerVisitState refState){
  return refState.isLoading?
    CustomerVisitShimmer(isShimmer: refState.isLoading,isKyc: false,):
    (refState.customerVisitModel?.data?[0].visitDraft?.length??0)>0?
  ListView.separated(
       separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: (refState.customerVisitModel?.data?[0].visitDraft?.length??0),
      padding: EdgeInsets.only(top: 10,bottom: 20),
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        return _VisitItemsWidget(isKyc: false,myVisit:refState.customerVisitModel?.data?[0].visitDraft?[index] ,);
    }) : NoDataFound(title: "No data available");
}

}

// ignore: must_be_immutable
class _VisitItemsWidget extends StatelessWidget {
 final bool isKyc;
 MyVisit? myVisit;
   _VisitItemsWidget({required this.isKyc, required this.myVisit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: (){
            AppRouter.pushCupertinoNavigation(const VisitDetailsScreen());
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  color: AppColors.black.withValues(alpha: .2),
                  blurRadius: 6
                )
              ]
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    children: [
                      Image.asset('assets/dummy/shop.png',height: 64,),
                      const SizedBox(width: 13,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          visitItem(title: 'Shop name', subTitle: 'Ammas Bakery'),
                          const SizedBox(height: 9,),
                          visitItem(title:"Contact",subTitle: '7019405678'),
                          const SizedBox(height: 9,),
                          visitItem(title:"Location",subTitle: 'Bangalore 560044'),
                        ],
                      )
                    ],
                  ),
                ),
                isKyc?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Divider(
                    color: AppColors.edColor,
                  ),
                ),
                 kycWidget()
                  ],
                ):Container()
              ],
            ),
          ),
        );
  }

Widget visitItem({required String title, required String subTitle}){
  return Row(
      children: [
        AppText(title: "$title : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: subTitle,fontsize: 8,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
      ],
    );
}

kycWidget(){
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Container(
          height: 5,width: 5,
          decoration: BoxDecoration(
            color: AppColors.greenColor,shape: BoxShape.circle
          ),
        ),
        const SizedBox(width: 4,),
        AppText(title: "KYC : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: "Pending",fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
      ],
    ),
  );
}

}