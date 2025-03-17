import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/widgets/journey_plan_items_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/presentation/add_trial_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/presentation/view_trial_plan_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/res/shimmer/list_shimmer.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';

class TrialPlanScreen extends ConsumerStatefulWidget {
  const TrialPlanScreen({super.key});

  @override
  ConsumerState<TrialPlanScreen> createState() => _TrialPlanScreenState();
}

class _TrialPlanScreenState extends ConsumerState<TrialPlanScreen> {
int selectedConductTypeIndex = -1;
  int selectedTrialLocationIndex = -1;
  int selectedTrialTypeIndex = -1;
  int selectedVisitTypeIndex = -1;
  
  String filterConductType = '';
  String filterTrialLocationType = '';
  String filterTrialType ='';
   String filterVisitType = '';
  String filterFromDate = '';
  String filterToDate = '';
  DateTime? fromDate;
  DateTime? todDate;
  String selectedState = '';
  String selectedDistrict = '';
  final stateSearchController = TextEditingController();
  final districtSearchController = TextEditingController();

  resetValue() {
    selectedConductTypeIndex = -1;
    selectedTrialLocationIndex = -1;
   selectedTrialTypeIndex = -1;
   selectedVisitTypeIndex  = -1;
   filterConductType = '';
   filterTrialLocationType = '';
   filterTrialType ='';
  filterVisitType = '';
    fromDate = null;
    todDate = null;
    filterFromDate = '';
    filterToDate = '';
    selectedState = '';
    selectedDistrict = '';
  }

  @override
  void initState() {
    Future.microtask(() {
      callInitFunction();
    });
    super.initState();
  }

  ScrollController _scrollController = ScrollController();

  callInitFunction() {
    final refNotifier = ref.read(trialPlanProvider.notifier);
    refNotifier.searchText = '';
    refNotifier.resetValues();
    refNotifier.resetFilter();
    _scrollController.addListener(_scrollListener);
    refNotifier.trialPlanListApiFunction();
    setState(() {});
  }

   @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final state = ref.watch(trialPlanProvider);
    final notifier = ref.read(trialPlanProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.trialPlanModel?.data?[0].records?.length??0) <
              int.parse((state.trialPlanModel?.data?[0].totalCount??0).toString())) {
        notifier.trialPlanListApiFunction(isLoadMore: true);
      }
    }
  }

@override
  Widget build(BuildContext context) {
      final refNotifer = ref.read(trialPlanProvider.notifier);
    final refState = ref.watch(trialPlanProvider);
    return Scaffold(
      appBar: customAppBar(title: 'Trial Plan'),
      body: Padding(
         padding: const EdgeInsets.only(top: 14),
        child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: AppSearchBar(
                  hintText: "Search by name, status, etc",
                  controller: refNotifer.searchController,
                  onChanged: refNotifer.onChangedSearch,
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
                            filterBottomSheet(context,refState,refNotifer);
                          },
                          child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                      ],
                    ),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 10),
                child: selectedFiltersWidget(refNotifier: refNotifer, refState: refState),
              ),
              const SizedBox(height: 16,),
           Padding(
               padding: const EdgeInsets.symmetric(horizontal: 25),
               child: CustomTabbar(
                currentIndex:refState.tabBarIndex,
                title1: "Approved",
                title2: "Pending",
                onClicked1: (){
                refNotifer.updateTabBarIndex(0);
                  setState(() {
                  });
                },
                onClicked2: (){
                  refNotifer.updateTabBarIndex(1);
                  setState(() {
                  });
                },
                ),
             ),
               const SizedBox(height: 10,),
            Expanded(child: trialPlanWidget(refState: refState, refNotifier: refNotifer)
            ) 
          ],
        ),
      ),
      floatingActionButton: floatingActionButtonWidget(onTap: (){
        AppRouter.pushCupertinoNavigation( AddTrialScreen(route: "trial",));
      }),
    );
    
  }

  trialPlanWidget({required TrialPlanState  refState, required TrialPlanNotifier refNotifier}){
    return refState.isLoading?
    CustomerVisitShimmer(isKyc: true,isShimmer: refState.isLoading):
    (refState.trialPlanModel?.data?[0].records?.length??0)>0?ListView.separated(
      separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: (refState.trialPlanModel?.data?[0].records?.length??0),
      padding: EdgeInsets.only(top: 10,bottom: 20,left: 13,right: 13),
      shrinkWrap: true,
      controller: _scrollController,
      itemBuilder: (ctx,index){
           var model = refState.trialPlanModel?.data?[0].records?[index];
        return Column(
          children: [
            GestureDetector(
              onTap: (){
                  AppRouter.pushCupertinoNavigation( ViewTrialPlanScreen(id: (model?.name ?? ''),)).then((val){
                    refNotifier.trialPlanListApiFunction();
                  });
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
                      blurRadius: 3
                    )
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JourneyPlanItemsWidget(
                      title:"Ticket #${model?.name??''}",
                      status: refState.tabBarIndex == 0? "Pending" : "Approved",
                      statusDes: model?.workflowState??'',
                      ),
                    ],
                  ),
                ),
              ),
            ),
             index == (refState.trialPlanModel?.data?[0].records?.length??0) - 1 &&
                              refState.isLoadingMore
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              width: 37,
                              height: 37,
                              child: const CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            )
                          : SizedBox.fromSize()
          ],
        );
    }): NoDataFound(title:refState.tabBarIndex == 0? "Apporved trial plan not found" : "Pending trial plan not found");
 
  }

filterBottomSheet(BuildContext context, TrialPlanState refState,
      TrialPlanNotifier refNotifier) {
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
                    title: "Conduct Type",
                    fontFamily: AppFontfamily.poppinsSemibold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            AppConstants.conductByList.length, (val) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: customRadioButton(
                            isSelected:
                                selectedConductTypeIndex == val ? true : false,
                            title: AppConstants.conductByList[val],
                            onTap: () {
                              setState(() {
                                state(() {
                                  selectedConductTypeIndex = val;
                                  filterConductType =
                                      AppConstants.conductByList[val];
                                });
                              });
                            }),
                      );
                    }).toList()),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AppText(
                    title: "Trial Location",
                    fontFamily: AppFontfamily.poppinsSemibold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(AppConstants.triaLocList.length,
                            (val) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: customRadioButton(
                            isSelected:
                                selectedTrialLocationIndex == val ? true : false,
                            title: AppConstants.triaLocList[val],
                            onTap: () {
                              setState(() {
                                state(() {
                                  selectedTrialLocationIndex = val;
                                  filterTrialLocationType =
                                      AppConstants.triaLocList[val];
                                });
                              });
                            }),
                      );
                    }).toList()),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AppText(
                    title: "Trial Type",
                    fontFamily: AppFontfamily.poppinsSemibold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(AppConstants.trailTypeList.length,
                            (val) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: customRadioButton(
                            isSelected:
                                selectedTrialTypeIndex == val ? true : false,
                            title: AppConstants.trailTypeList[val],
                            onTap: () {
                              setState(() {
                                state(() {
                                  selectedTrialTypeIndex = val;
                                  filterTrialType =
                                      AppConstants.trailTypeList[val];
                                });
                              });
                            }),
                      );
                    }).toList()),
                  ),
                  const SizedBox(height: 25,),
                  AppText(
                    title: "Visit Type",
                    fontFamily: AppFontfamily.poppinsSemibold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(AppConstants.visitTypeList.length,
                            (val) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: customRadioButton(
                            isSelected:
                                selectedVisitTypeIndex  == val ? true : false,
                            title: AppConstants.visitTypeList[val],
                            onTap: () {
                              setState(() {
                                state(() {
                                  selectedVisitTypeIndex  = val;
                                  filterVisitType =
                                      AppConstants.visitTypeList[val];
                                });
                              });
                            }),
                      );
                    }).toList()),
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      AppDateWidget(
                        onTap: () {
                          DatePickerService.datePicker(context,
                                  selectedDate: fromDate)
                              .then((picked) {
                            if (picked != null) {
                              var day = picked.day < 10
                                  ? '0${picked.day}'
                                  : picked.day;
                              var month = picked.month < 10
                                  ? '0${picked.month}'
                                  : picked.month;
                              filterFromDate = "${picked.year}-$month-$day";
                              state(() {
                                fromDate = picked;
                              });
                            }
                          });
                        },
                        title: filterFromDate,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        width: 8,
                        height: 2,
                        color: AppColors.black,
                      ),
                      AppDateWidget(
                        onTap: () {
                          DatePickerService.datePicker(context,
                                  selectedDate: todDate)
                              .then((picked) {
                            if (picked != null) {
                              var day = picked.day < 10
                                  ? '0${picked.day}'
                                  : picked.day;
                              var month = picked.month < 10
                                  ? '0${picked.month}'
                                  : picked.month;
                              filterToDate = "${picked.year}-$month-$day";
                              state(() {
                                todDate = picked;
                              });
                            }
                          });
                        },
                        title: filterToDate,
                      ),
                    ],
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
                        if (filterConductType.isEmpty &&
                            filterTrialLocationType.isEmpty &&
                            filterTrialType.isEmpty &&
                            filterVisitType.isEmpty &&
                            filterFromDate.isEmpty &&
                            filterToDate.isEmpty) {
                          MessageHelper.showToast("Select any filter");
                        } else {
                          Navigator.pop(context);
                          refNotifier.updateFilterValues(
                              conductType: filterConductType,
                              trialLocType: filterTrialLocationType,
                              trialType: filterTrialType,
                              visitType: filterVisitType,
                              fromDate: filterFromDate,
                              toDate: filterToDate,);
                          setState(() {});
                          refNotifier.trialPlanListApiFunction();
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


 Widget selectedFiltersWidget({required TrialPlanNotifier refNotifier,required TrialPlanState refState}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
         refNotifier.conductByTypeFilter.isNotEmpty? customFiltersUI(refNotifier.conductByTypeFilter,
         (){
          refNotifier.conductByTypeFilter='';
          filterConductType = '';
          selectedConductTypeIndex = -1;
          refNotifier.trialPlanListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
          // const SizedBox(width: 15,),
          refNotifier.trialLocTypeFilter.isNotEmpty? customFiltersUI(refNotifier.trialLocTypeFilter,
         (){
          refNotifier.trialLocTypeFilter='';
          filterTrialLocationType = '';
          selectedTrialLocationIndex = -1;
          refNotifier.trialPlanListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
        //  const SizedBox(width: 15,),
         refNotifier.trailTypeFilter.isNotEmpty? customFiltersUI(refNotifier.trailTypeFilter,
         (){
          refNotifier.trailTypeFilter='';
          filterTrialType = '';
          selectedTrialTypeIndex = -1;
          refNotifier.trialPlanListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
        //  const SizedBox(width: 15,),
         refNotifier.visitTypeFilter.isNotEmpty? customFiltersUI(refNotifier.visitTypeFilter,
         (){
          refNotifier.visitTypeFilter='';
          filterVisitType = '';
          selectedVisitTypeIndex = -1;
          refNotifier.trialPlanListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
// const SizedBox(width: 15,),
          refNotifier.fromDateFilter.isNotEmpty? customFiltersUI(refNotifier.fromDateFilter,
         (){
          refNotifier.fromDateFilter='';
          filterFromDate = '';
          refNotifier.trialPlanListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
        //  const SizedBox(width: 15,),
          refNotifier.toDateFilter.isNotEmpty? customFiltersUI(refNotifier.toDateFilter,
         (){
          refNotifier.toDateFilter='';
          filterToDate = '';
          refNotifier.trialPlanListApiFunction();
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