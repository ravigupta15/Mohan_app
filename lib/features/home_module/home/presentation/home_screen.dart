import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/services/location_service.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/presentation/complaint_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/customer_visit_history/presentation/customer_visit_history_screen.dart';
import 'package:mohan_impex/features/home_module/home/model/dashboard_model.dart';
import 'package:mohan_impex/features/home_module/home/riverpod/home_state.dart';
import 'package:mohan_impex/features/home_module/home/widgets/header_widget.dart';
import 'package:mohan_impex/features/home_module/home/widgets/slider_widget.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/kyc_screen.dart';
import 'package:mohan_impex/features/home_module/my_customers/presentation/my_customer_screen.dart';
import 'package:mohan_impex/features/home_module/price_list/presentation/price_list_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/presentation/marketing_collaterals_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/presentation/requisitions_screen.dart';
import 'package:mohan_impex/features/home_module/schemes_management/presentation/schemes_management_screen.dart';
import 'package:mohan_impex/features/home_module/seles_order/presentation/sales_order_history_screen.dart';
import 'package:mohan_impex/features/home_module/special_report/special_report_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List list = [
    {
      'title1': AppConstants.salesOrder,
      'img1': AppAssetPaths.salesOrderIcon,
      'title2': AppConstants.customerVisit,
      'img2': AppAssetPaths.profileIcon,
    },
    {
      'title1': AppConstants.myCustomer,
      'img1': AppAssetPaths.myCustomerIcon,
      'title2': AppConstants.kyc,
      'img2': AppAssetPaths.kycIcon,
    },
    {
      'title1': AppConstants.priceList,
      'img1': AppAssetPaths.priceIcon,
      'title2': AppConstants.requisitions,
      'img2': AppAssetPaths.requisitionsIcon,
    },
    {
      'title1': AppConstants.complaint,
      'img1': AppAssetPaths.complaintIcon,
      'title2': AppConstants.scheme,
      'img2': AppAssetPaths.schemeIcon,
    },
    {
      'title1': AppConstants.digital,
      'img1': AppAssetPaths.digitalIcon,
      'title2': AppConstants.specialReport,
      'img2': AppAssetPaths.specialIcon,
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      callInitFunction();
    });
  }

LocationService locationService = LocationService();

  callInitFunction(){
    final notifier = ref.read(homeProvider.notifier);
    notifier.dashboardApiFunction();
    locationService.startLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(homeProvider.notifier);
    final refState = ref.watch(homeProvider);
    return Column(
      children: [
        HeaderWidget(homeNotifier: refNotifier,homeState: refState,lastLog: refState.dashboardModel?.data?[0].lastLog?[0],),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(bottom: 30),
          children: [
            const SizedBox(
              height: 30,
            ),
            sliderWidget(),
            const SizedBox(
              height: 14,
            ),
            dotteDivierWidget(dividerColor: AppColors.greenColor),
            scoreDashboardWidget(refState.dashboardModel?.data?[0].scoreDashboard),
            const SizedBox(
              height: 14,
            ),
            dotteDivierWidget(dividerColor: AppColors.greenColor),
            dashboardWidget(refState.dashboardModel?.data?[0].dashboard)
          ],
        ))
      ],
    );
  }

  scoreDashboardWidget(List<ScoreDashboard>? scoreModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.center,
              child: AppText(
                title: "Score Dashboard",
                fontsize: 14,
                fontFamily: AppFontfamily.poppinsSemibold,
              )),
          const SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                customScore(
                    title: "Trial",
                    subTitle: (scoreModel?[0].count ?? 0).toString(),
                    img: AppAssetPaths.tiralIcon),
                const SizedBox(
                  width: 7,
                ),
                customScore(
                    title: "Orders",
                    subTitle: (scoreModel?[1].count ?? 0).toString(),
                    img: AppAssetPaths.orderIcon),
                const SizedBox(
                  width: 7,
                ),
                customScore(
                    title: "Visits",
                    subTitle: (scoreModel?[2].count ?? 0).toString(),
                    img: AppAssetPaths.myCustomerIcon),
              ],
            ),
          )
        ],
      ),
    );
  }

  customScore(
      {required String title, required String subTitle, required String img}) {
    return Expanded(
      child: Container(
        height: 76,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.greenColor, width: .5),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  color: AppColors.black.withOpacity(.2),
                  blurRadius: 3)
            ]),
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.greenColor.withOpacity(.2),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(
                img,
                height: 20,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  title: title,
                  fontsize: 13,
                  color: AppColors.light92Color,
                  fontFamily: AppFontfamily.poppinsMedium,
                ),
                AppText(
                  title: subTitle,
                  fontsize: 20,
                  fontFamily: AppFontfamily.poppinsSemibold,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

dashboardWidget(List<Dashboard>? scoreDashboard){
  return GridView.builder(
    itemCount: scoreDashboard?.length??0,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.only(left: 18, right: 18),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    crossAxisSpacing: 15,
    childAspectRatio: 16/9
    ), itemBuilder: (ctx,index){
      var model = scoreDashboard?[index];
    return otherUserCustomContainer(
                          title: model?.name??"",
                          img: model?.url ??'',
                          isBoxShadow: true,
                          onTap: (){
                            _onClick(model?.name??'');
                          });
  });
}

  // otherUserWidget(List<Dashboard>? scoreDashboard) {
  //   return ListView.builder(
  //       itemCount: scoreDashboard?.length??0,
  //       padding: const EdgeInsets.only(left: 18, right: 18),
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemBuilder: (ctx, index) {
  //         var model = scoreDashboard?[index];
  //         return Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Expanded(
  //                     child: otherUserCustomContainer(
  //                         title: model?.name??"",
  //                         img: list[index]['img1'],
  //                         isBoxShadow: true,
  //                         onTap: (){
  //                           _onClick(list[index]['title1']);
  //                         })),
  //                 Container(
  //                   margin: EdgeInsets.only(left: 12, right: 12, ),
  //                   height: 90,
  //                   width: 1,
  //                   color: Color(0xff64748B).withOpacity(.1),
  //                 ),
  //                 Expanded(
  //                     child: otherUserCustomContainer(
  //                         title: list[index]['title2'],
  //                         img: list[index]['img2'],
  //                         onTap: (){
  //                           _onClick(list[index]['title2']);
  //                         })),
  //               ],
  //             ),
  //             index==list.length-1?Container():
  //             Container(
  //               height: 1,
  //               color: Color(0xff64748B).withValues(alpha: .1),
  //             ),
  //           ],
  //         );
  //       });
  // }

  otherUserCustomContainer(
      {required String title,
      bool isBoxShadow = false,
      required String img,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.e2Color, width: 2),
            boxShadow: isBoxShadow
                ? [
                    BoxShadow(
                        offset: Offset(32, -12),
                        color: Colors.yellow.withOpacity(.2),
                        blurRadius: 86)
                  ]
                : []),
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            AppNetworkImage(imgUrl: img,height: 30,),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                child: AppText(
              title: title,
              fontsize: 13,
              fontFamily: AppFontfamily.poppinsMedium,
            )),
          ],
        ),
      ),
    );
  }

  _onClick(title){
    switch (title.toString().toLowerCase()) {
      case AppConstants.salesOrder:
      AppRouter.pushCupertinoNavigation(const SalesOrderHistoryScreen());
        break;
        case AppConstants.customerVisit:
        AppRouter.pushCupertinoNavigation(const CustomerVisitHistoryScreen());
        break;
        case AppConstants.myCustomer:
        AppRouter.pushCupertinoNavigation(const MyCustomerScreen());
        break;
        case AppConstants.kyc:
        AppRouter.pushCupertinoNavigation(const KycScreen());
        break;
        case AppConstants.priceList:
        AppRouter.pushCupertinoNavigation(const PriceListScreen());
        break;
        case AppConstants.requisitions:
        AppRouter.pushCupertinoNavigation(const RequisitionsScreen());
        break;
        case AppConstants.complaint:
        AppRouter.pushCupertinoNavigation(const ComplaintScreen());
        break;
        case AppConstants.scheme:
        AppRouter.pushCupertinoNavigation(const SchemesManagementScreen());
        break;
        case AppConstants.digital:
        AppRouter.pushCupertinoNavigation(const MarketingCollateralsScreen());
        break;
        case AppConstants.specialReport:
        AppRouter.pushCupertinoNavigation(const SpecialReportScreen());
        break;
      default:
    }
  }
}
