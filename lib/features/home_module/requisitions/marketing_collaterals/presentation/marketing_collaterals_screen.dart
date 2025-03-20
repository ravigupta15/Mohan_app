import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/presentation/add_marketing_collaterals_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/riverpod/collaterals_request_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/widget/marking_approved_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/widget/marking_pending_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_router.dart';

class MarketingCollateralsScreen extends ConsumerStatefulWidget {
  const MarketingCollateralsScreen({super.key});

  @override
  ConsumerState<MarketingCollateralsScreen> createState() => _MarketingCollateralsScreenState();
}

class _MarketingCollateralsScreenState extends ConsumerState<MarketingCollateralsScreen> {

ScrollController _scrollController = ScrollController();
@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(collateralRequestProvider.notifier);
    refNotifier.resetValues();
    _scrollController.addListener(_scrollListener); refNotifier.collateralListApiFunction();
    setState(() {      
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final state = ref.watch(collateralRequestProvider);
    final notifier = ref.read(collateralRequestProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.collateralsReqestModel?.data?[0].records?.length??0) <
              int.parse((state.collateralsReqestModel?.data?[0].totalCount??0).toString())) {
        notifier.collateralListApiFunction(isLoadMore: true);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(collateralRequestProvider.notifier);
    final refState= ref.watch(collateralRequestProvider);
    print(LocalSharePreference.token);
    return Scaffold(
      appBar: customAppBar(title: "Marketing Collaterals"),
      body: Padding(
         padding: const EdgeInsets.only(top: 14),
        child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: AppSearchBar(
                  hintText: "Search by name, status, etc",
                  onChanged: refNotifier.onChangedSearch,
                  controller: refNotifier.searchController,
                  suffixWidget: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(AppAssetPaths.searchIcon),
                ),
                        
                ),
              ),
              const SizedBox(height: 16,),
           Padding(
               padding: const EdgeInsets.symmetric(horizontal: 25),
               child: CustomTabbar(
                currentIndex:refState.tabBarIndex,
                title1: "Approved",
                title2: "Pending",
                onClicked1: (){
                  refNotifier.updateTabBarIndex(0);
                  setState(() {
                  });
                },
                onClicked2: (){
                  refNotifier.updateTabBarIndex(1);
                  setState(() {
                  });
                },
                ),
             ),
               const SizedBox(height: 10,),
            Expanded(child:refState.tabBarIndex==0?
            MarkingApprovedWidget(refNotifier: refNotifier,refState: refState,
            scrollController: _scrollController,
            ):MarkingPendingWidget(
             refNotifier: refNotifier,refState: refState,scrollController: _scrollController  ,)
            ) 
          ],
        ),
      ),
      floatingActionButton: floatingActionButtonWidget(onTap: (){
        AppRouter.pushCupertinoNavigation(const AddMarketingCollateralsScreen()).then((val){
          refNotifier.resetPageCount();
          refNotifier.collateralListApiFunction();
        });
      }),
    );
    
  }
}