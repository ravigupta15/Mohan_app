import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/add_kyc_screen.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_notifier.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_state.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/kyc_item.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/res/shimmer/list_shimmer.dart';
import 'package:mohan_impex/utils/app_date_format.dart';

class KycScreen extends ConsumerStatefulWidget {
  const KycScreen({super.key});

  @override
  ConsumerState<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends ConsumerState<KycScreen> {
  int tabBarIndex=0;

@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(kycProvider.notifier);
    refNotifier.kyclistApiFunction(context);
  }

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(kycProvider.notifier);
    final refState = ref.watch(kycProvider);
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
            approvedKycWidget(refNotifier: refNotifier,refState: refState,):
            pendingKycWidget(refNotifier: refNotifier,refState: refState,))
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

Widget approvedKycWidget({required KycState refState, required KycNotifier refNotifier}){
  return refState.isLoading?
    CustomerVisitShimmer(isShimmer: refState.isLoading, isKyc: true):
    (refState.kycModel?.data?[0].approved?.length ?? 0)>0?
    ListView.separated(
      separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: (refState.kycModel?.data?[0].approved?.length ?? 0),
      padding: EdgeInsets.only(top: 10,bottom: 20),
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        var model = refState.kycModel?.data?[0].approved?[index];
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withValues(alpha: .2),
                blurRadius: 3
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KycItem(
                        title:"Ticket #${model?.name??''}",
                        userIcon: AppAssetPaths.userIcon,
                        name: model?.username??'',
                        dateIcon: AppAssetPaths.dateIcon,
                        date: AppDateFormat.formatDateYYMMDD((model?.date??'')),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Divider(
                  color: AppColors.edColor,
                ),
              ),
               kycWidget()
            ],
          ),
        );
    }): NoDataFound(title: "No approved KYC found.");
 
}

Widget pendingKycWidget({required KycState refState, required KycNotifier refNotifier}){
  return refState.isLoading?
    CustomerVisitShimmer(isShimmer: refState.isLoading, isKyc: false):
(refState.kycModel?.data?[0].pending?.length ?? 0)>0?
    ListView.separated(
        separatorBuilder: (ctx,sb){
          return const SizedBox(height: 15,);
        },
        itemCount: (refState.kycModel?.data?[0].pending?.length ?? 0),
        padding: EdgeInsets.only(top: 10,bottom: 20),
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          var model = refState.kycModel?.data?[0].pending?[index];
          return Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KycItem(
                        title:"Ticket #${model?.name??''}",
                        userIcon: AppAssetPaths.userIcon,
                        name: model?.username??'',
                        dateIcon: AppAssetPaths.dateIcon,
                        date: AppDateFormat.formatDateYYMMDD((model?.date??'')),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Divider(
                    color: AppColors.edColor,
                  ),
                ),
                kycWidget()
              ],
            ),
          );
        }): NoDataFound(title: "No pending KYC found.");
  
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
        AppText(title: "Pending : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: "ASM Review",fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
      ],
    ),
  );
}

  
}