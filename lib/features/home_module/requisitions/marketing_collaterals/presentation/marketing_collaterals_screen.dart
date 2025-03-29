import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/presentation/add_marketing_collaterals_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/riverpod/collaterals_request_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/riverpod/collaterals_request_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/widget/marking_approved_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';

class MarketingCollateralsScreen extends ConsumerStatefulWidget {
  const MarketingCollateralsScreen({super.key});

  @override
  ConsumerState<MarketingCollateralsScreen> createState() => _MarketingCollateralsScreenState();
}

class _MarketingCollateralsScreenState extends ConsumerState<MarketingCollateralsScreen> {

ScrollController _scrollController = ScrollController();

int selectedStatusIndex = -1;
String filterStatus = '';
DateTime? createdDate;
String filterDate = '';

resetValue(){
  selectedStatusIndex = -1;
  filterDate = '';
  createdDate = null;
  filterStatus = '';
  setState(() {
    
  });
}

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
                         InkWell(
                          onTap: (){
                              TextfieldUtils.hideKeyboard();
                            filterBottomSheet(context,refState,refNotifier);
                          },
                          child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                      ],
                    ),
                  ),       
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: selectedFiltersWidget(refNotifier: refNotifier, refState: refState),
              ),
              const SizedBox(height: 16,),
           Padding(
               padding: const EdgeInsets.symmetric(horizontal: 25),
               child: CustomTabbar(
                currentIndex:refState.tabBarIndex,
                title1: "Approved",
                title2: "Pending",
                onClicked1: (){
                  if(refState.tabBarIndex !=0){
                    resetValue();
                  }
                  refNotifier.updateTabBarIndex(0);
                  setState(() {
                  });
                },
                onClicked2: (){
                  if(refState.tabBarIndex !=1){
                    resetValue();
                  }
                  refNotifier.updateTabBarIndex(1);
                  setState(() {
                  });
                },
                ),
             ),
               const SizedBox(height: 10,),
            Expanded(child:
            MarkingWidget(refNotifier: refNotifier,refState: refState,
            scrollController: _scrollController,
            index: refState.tabBarIndex,
            ))
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


filterBottomSheet(BuildContext context, CollateralsRequestState refState,
      CollateralsRequestNotifier refNotifier) {
    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(top: 14,bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                  padding: const EdgeInsets.only(right: 11),
                  child: Row(
                    children: [
                      const Spacer(),
                      AppText(title: "Filter",fontsize: 16,fontFamily: AppFontfamily.poppinsSemibold,),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 24,width: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.edColor,
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.close,size: 19,),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                 padding: const EdgeInsets.only(left: 25,right: 25,top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  AppText(
                    title: "Status",
                    fontFamily: AppFontfamily.poppinsSemibold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(refState.tabBarIndex == 0? 
                        AppConstants.approvedStatusList.length:
                         AppConstants.pendingStatusList.length,
                            (val) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: customRadioButton(
                            isSelected:
                                selectedStatusIndex == val ? true : false,
                            title: refState.tabBarIndex == 0?AppConstants.approvedStatusList[val]:  AppConstants.pendingStatusList[val],
                            onTap: () {
                              setState(() {
                                state(() {
                                  selectedStatusIndex = val;
                                  filterStatus =refState.tabBarIndex == 0?AppConstants.approvedStatusList[val]:
                                      AppConstants.pendingStatusList[val];
                                });
                              });
                            }),
                      );
                    }).toList()),
                  ),
                  const SizedBox(height: 25,),
                  AppText(
                    title: "Created Date",
                    fontFamily: AppFontfamily.poppinsSemibold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                 AppDateWidget(
                        onTap: () {
                          DatePickerService.datePicker(context,
                                  selectedDate: createdDate)
                              .then((picked) {
                            if (picked != null) {
                              var day = picked.day < 10
                                  ? '0${picked.day}'
                                  : picked.day;
                              var month = picked.month < 10
                                  ? '0${picked.month}'
                                  : picked.month;
                              filterDate = "${picked.year}-$month-$day";
                              state(() {
                                createdDate = picked;
                                
                              });
                            }
                          });
                        },
                        title: filterDate,
                      ),
                     
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AppTextButton(
                      title: "Apply",
                      height: 35,
                      width: 150,
                      color: AppColors.arcticBreeze,
                      onTap: () {
                        TextfieldUtils.hideKeyboard();
                        if (filterDate.isEmpty &&
                            filterStatus.isEmpty) {
                          MessageHelper.showToast("Select any filter");
                        } else {
                          Navigator.pop(context);
                          refNotifier.updateFilterValues(
                            date: filterDate,
                            status: filterStatus  
                          );  
                              
                              
                          setState(() {});
                          refNotifier.collateralListApiFunction();
                        }
                      },
                    ),
                  )
               
                    ],
                  ),
                )
                  ],
              ),
            );
          });
        });
  }


 Widget selectedFiltersWidget({required CollateralsRequestNotifier refNotifier,required CollateralsRequestState refState}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
         refNotifier.filterDateValue.isNotEmpty? customFiltersUI(refNotifier.filterDateValue,
         (){
          refNotifier.filterDateValue='';
          filterDate = '';
          createdDate = null;
          refNotifier.collateralListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
          refNotifier.filterStatusValue.isNotEmpty? customFiltersUI(refNotifier.filterStatusValue,
         (){
          refNotifier.filterStatusValue='';
          filterStatus = '';
          selectedStatusIndex = -1;
          refNotifier.collateralListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
        ],
      ),
    );
  }
  
  customFiltersUI(String title, Function()?onTap){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greenColor),
            borderRadius: BorderRadius.circular(15)
          ),
          padding: EdgeInsets.symmetric(horizontal: 9,vertical: 2),
          child: Row(
            children: [
              AppText(title: title,fontFamily: AppFontfamily.poppinsSemibold,fontsize: 13,),
              const SizedBox(width: 5,),
              Icon(Icons.close,size: 15,)
            ],
          ),
        ),
      ),
    );
  }

}