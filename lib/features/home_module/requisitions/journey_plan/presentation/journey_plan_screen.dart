import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/presentation/add_journey_plan_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/riverpod/journey_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/riverpod/journey_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/widgets/journey_approved_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/widgets/journey_pending_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/utils/message_helper.dart';

class JourneyPlanScreen extends ConsumerStatefulWidget {
  const JourneyPlanScreen({super.key});

  @override
  ConsumerState<JourneyPlanScreen> createState() => _JourneyPlanScreenState();
}

class _JourneyPlanScreenState extends ConsumerState<JourneyPlanScreen> {

  int selectedRadio = -1;
  int selectedModeTravelindex = -1;
DateTime? seleceDate;
String filterModeTravel = '';
String filterDate = '';
String filterTravel = '';
ScrollController _scrollController = ScrollController();
 @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    ref.read(journeyProvider.notifier).resetValues();
    ref.read(journeyProvider.notifier).searchText = '';
    ref.read(journeyProvider.notifier).resetFilter();
     _scrollController.addListener(_scrollListener);
      ref.read(journeyProvider.notifier).journeyPlanListApiFunction();
    setState(() {      
    });
  
  }

  resetValues(){
   filterDate = '';
   filterModeTravel = '';
   selectedRadio = -1;
   selectedModeTravelindex = -1;
   filterTravel = ''; 
   seleceDate = null;
  }

@override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final state = ref.watch(journeyProvider);
    final notifier = ref.read(journeyProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.collateralsReqestModel?.data?[0].records?.length??0) <
              int.parse((state.collateralsReqestModel?.data?[0].totalCount??0).toString())) {
        notifier.journeyPlanListApiFunction(isLoadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
     final refNotifier = ref.read(journeyProvider.notifier);
    final refState = ref.watch(journeyProvider);
    return Scaffold(
      appBar: customAppBar(title: "Journey Plan"),
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: AppSearchBar(
                  hintText: "Search by name or status",
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
                            filterBottomSheet(context, refNotifier,refState);
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
                currentIndex: refState.tabBarIndex,
                title1: "Approved",
                title2: "Pending",
                onClicked1: (){
                  if(refState.tabBarIndex !=0){
                    resetValues();
                  }
                   refNotifier.updateTabBarIndex(0);
                  
                  setState(() {
                  });
                },
                onClicked2: (){
                  if(refState.tabBarIndex !=1){
                    resetValues();
                  }
                  refNotifier.updateTabBarIndex(1);
                  setState(() {
                  });
                },
                ),
             ),
              const SizedBox(height: 10,),
            Expanded(child: refState.tabBarIndex==0?
            JourneyApprovedWidget(refState: refState,refNotifier: refNotifier,
            scrollController: _scrollController,
            ):JourneyPendingWidget(
              refState: refState,refNotifier: refNotifier,
              scrollController: _scrollController,
              )
            )
          ],
        ),
      ),
      floatingActionButton: floatingActionButtonWidget(onTap: (){
        refNotifier.resetPageCount();
        AppRouter.pushCupertinoNavigation(const AddJourneyPlanScreen());
      }),
    );
  }


  filterBottomSheet(BuildContext context, JourneyNotifier refNotifier,JourneyState refState){
  showModalBottomSheet(
    backgroundColor: AppColors.whiteColor,
    context: context, builder: (context){
    return Container(
       padding: EdgeInsets.only(top: 14,bottom: 20),
      child: StatefulBuilder(
        builder: (context,state) {
          return Column(
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
                      AppText(title: "Select Date",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),
                      AppDateWidget(
                        title:filterDate,
                        onTap: (){
                           DatePickerService.datePicker(context, selectedDate: seleceDate)
                    .then((picked) {
                  if (picked != null) {
                    state(() {
                    var day = picked.day < 10 ? '0${picked.day}' : picked.day;
                    var month =
                        picked.month < 10 ? '0${picked.month}' : picked.month;
                        filterDate = "${picked.year}-$month-$day";
                    setState(() {
                      seleceDate = picked;
                    });
  
                    });
                    }
                });
                        },
                      ),
                        const SizedBox(height: 25,),
                      AppText(title: "Mode of Travel",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(refNotifier.modelTravelList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(isSelected:selectedModeTravelindex==val? true:false, title: refNotifier.modelTravelList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedModeTravelindex=val;
                               filterModeTravel =   refNotifier.modelTravelList[val];
                                });
                                });
                              }
                              ),
                            );
                          }).toList() 
                        ),
                      ),
                      const SizedBox(height: 25,),
                      AppText(title: "Nature of Travel",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(refNotifier.naturalTravelList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(isSelected:selectedRadio==val? true:false, title: refNotifier.naturalTravelList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedRadio=val;
                               filterTravel =   refNotifier.naturalTravelList[val];
                                });
                                });
                              }
                              ),
                            );
                          }).toList() 
                        ),
                      ),
                      const SizedBox(height: 25,),
                       Align(
                  alignment: Alignment.center,
                  child: AppTextButton(title: "Apply",height: 35,width: 150,color: AppColors.arcticBreeze,
                  onTap: (){
                    if(filterDate.isEmpty && filterTravel.isEmpty && filterModeTravel.isEmpty){
                       MessageHelper.showToast("Select any filter");
                    }
                    else{
                        Navigator.pop(context);
                    refNotifier.updateFilterValues(date: filterDate, type: filterTravel, modeTravel: filterModeTravel);
                    setState(() {
                    });
                    refNotifier.journeyPlanListApiFunction();
                    }
                  },
                  ),
                 )
                    ],
                  ),
                ),
            ],
          );
        }
      ),
    );
  });
}

 Widget selectedFiltersWidget({required JourneyNotifier refNotifier,required JourneyState refState}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
         refNotifier.filterDateValue.isNotEmpty? customFiltersUI(refNotifier.filterDateValue,
         (){
          refNotifier.filterDateValue='';
          filterDate = '';
          refNotifier.journeyPlanListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
         refNotifier.filterModeTravelValue.isNotEmpty? customFiltersUI(refNotifier.filterModeTravelValue,
         (){
          refNotifier.filterModeTravelValue='';
          filterModeTravel = '';
          selectedModeTravelindex = -1;
          refNotifier.journeyPlanListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
          refNotifier.filterNatureOfTravelValue.isNotEmpty? customFiltersUI(refNotifier.filterNatureOfTravelValue,
          (){
            refNotifier.filterNatureOfTravelValue='';
            filterTravel = '';
            selectedRadio = -1;
            refNotifier.journeyPlanListApiFunction();
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