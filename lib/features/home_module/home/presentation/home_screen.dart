import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/services/location_service.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/indicator_widget.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/presentation/complaint_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/presentation/pages/customer_visit_history_screen.dart';
import 'package:mohan_impex/features/home_module/digital_marking_collaterals/presentation/digital_marking_collaterals_screen.dart';
import 'package:mohan_impex/features/home_module/home/model/dashboard_model.dart';
import 'package:mohan_impex/features/home_module/home/riverpod/home_state.dart';
import 'package:mohan_impex/features/home_module/home/widgets/header_widget.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/kyc_screen.dart';
import 'package:mohan_impex/features/home_module/my_customers/presentation/my_customer_screen.dart';
import 'package:mohan_impex/features/home_module/price_list/presentation/price_list_screen.dart';
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
  int selectedSliderIndex = 0;
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
    notifier.dashboardApiFunction(context);
    locationService.startLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(homeProvider.notifier);
    final refState = ref.watch(homeProvider);
    return Column(
      children: [
        HeaderWidget(homeNotifier: refNotifier,homeState: refState,lastLog:
        (refState.dashboardModel?.data?[0].lastLog ?? []).isEmpty?
        null :refState.dashboardModel?.data?[0].lastLog?[0]
        ,),
        Expanded(
            child: ListView(
          padding: EdgeInsets.only(bottom: 30),
          children: [
            const SizedBox(
              height: 30,
            ),
            sliderWidget(refState),
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
                          img: model?.imgUrl ??'',
                          isBoxShadow: true,
                          onTap: (){
                            _onClick(model?.name??'');
                          });
  });
}


sliderWidget(HomeState refState){
  return (refState.dashboardModel?.data?[0].bannerInfo??[]).isEmpty?
  Container():
   Column(
    children: [
      SizedBox(height: 150,
                      child: CarouselSlider.builder(
                        itemCount: (refState.dashboardModel?.data?[0].bannerInfo?.length??0),
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                              var model = refState.dashboardModel?.data?[0].bannerInfo?[itemIndex];
                          return Container(
                            margin: const EdgeInsets.only(
                              right: 15,
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:Image.network(model?.bannerImage??'',fit: BoxFit.cover,)),
                          );
                        },
                        options: CarouselOptions(
                            autoPlay:(refState.dashboardModel?.data?[0].bannerInfo?.length??0)>1? true:false,
                            scrollDirection: Axis.horizontal,
                            viewportFraction: 1,
                            aspectRatio: 2.0,
                            initialPage: 0,
                            autoPlayCurve: Curves.ease,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 400),
                            autoPlayInterval: const Duration(seconds: 2),
                            onPageChanged: (val, _) {
                              selectedSliderIndex = val;
                              setState(() {
                                
                              });
                            }),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate((refState.dashboardModel?.data?[0].bannerInfo?.length??0), (index) {
          return selectedSliderIndex == index
              ? indicatorWidget(isActive:  true,activeWidth: 26,inactiveWidth: 26)
              : indicatorWidget(isActive: false,activeWidth: 26,inactiveWidth: 26);
        }))
    ],
  );
}


  otherUserCustomContainer(
      {required String title,
      bool isBoxShadow = false,
      required String img,
      required Function() onTap}) {
    return GestureDetector(
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
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 35,width: 35,decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greenColor.withValues(alpha: .2)
              ),
              child: AppNetworkImage(imgUrl: img,height: 20,width: 20,)),
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
    print(title);
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
        case AppConstants.requisitions||AppConstants.requisition:
        AppRouter.pushCupertinoNavigation(const RequisitionsScreen());
        break;
        case AppConstants.complaint:
        AppRouter.pushCupertinoNavigation(const ComplaintScreen());
        break;
        case AppConstants.scheme:
        AppRouter.pushCupertinoNavigation(const SchemesManagementScreen());
        break;
        case AppConstants.digital:
        AppRouter.pushCupertinoNavigation(const DigitalMarkingCollateralsScreen());
        break;
        case AppConstants.specialReport:
        AppRouter.pushCupertinoNavigation(const SpecialReportScreen());
        break;
      default:
    }
  }
}
