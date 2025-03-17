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
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/presentation/add_sample_requisitions_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/riverpod/sample_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/riverpod/sample_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/widget/sample_approved_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/widget/sample_pending_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/utils/message_helper.dart';

import '../../../../../res/app_router.dart';

class SampleRequisitionsScreen extends ConsumerStatefulWidget {
  const SampleRequisitionsScreen({super.key});

  @override
  ConsumerState<SampleRequisitionsScreen> createState() => _SampleRequisitionsScreenState();
}

class _SampleRequisitionsScreenState extends ConsumerState<SampleRequisitionsScreen> {
  int selectedRadio = -1;
DateTime? seleceDate;
String filterDate = '';
String filterStatus = '';

ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    ref.read(sampleProvider.notifier).resetValues();
    ref.read(sampleProvider.notifier).resetFilter();
     _scrollController.addListener(_scrollListener); 
   ref.read(sampleProvider.notifier).sampleRequisitionsListApiFunction();
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
    final state = ref.watch(sampleProvider);
    final notifier = ref.read(sampleProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.collateralsReqestModel?.data?[0].records?.length??0) <
              int.parse((state.collateralsReqestModel?.data?[0].totalCount??0).toString())) {
        notifier.sampleRequisitionsListApiFunction(isLoadMore: true);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final refNotifer = ref.read(sampleProvider.notifier);
    final refState = ref.watch(sampleProvider);
    return Scaffold(
       appBar: customAppBar(title: "Sample Requisitions",),
       body: Padding(
         padding: const EdgeInsets.only(top: 14),
         child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: AppSearchBar(
                  hintText: "Search by name or status",
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
                            filterBottomSheet(context, refNotifer, refState);
                            // filterBottomSheet(context);
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
                currentIndex: refState.tabBarIndex,
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
               Expanded(child: RefreshIndicator(
                onRefresh: ()async{
                  callInitFunction();
                },
                 child: refState.tabBarIndex==0?
                             SampleApprovedWidget(refState: refState,refNotifier: refNotifer,
                             scrollController: _scrollController
                             ):SamplePendingWidget(
                               refState: refState,refNotifier: refNotifer,
                               scrollController: _scrollController,
                              ),
               )
            ) 
          ],
         ),
       ),
       floatingActionButton: floatingActionButtonWidget(onTap: (){
        refNotifer.resetPageCount();
        AppRouter.pushCupertinoNavigation(const AddSampleRequisitionsScreen());
      }),
    );
  }


  filterBottomSheet(BuildContext context, SampleNotifier refNotifier,SampleState refState){
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
                      const SizedBox(height: 15,),
                      AppText(title: "Status",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(refNotifier.filterStatusList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(isSelected:selectedRadio==val? true:false, title: refNotifier.filterStatusList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedRadio=val;
                               filterStatus = refNotifier.filterStatusList[val];
                               print(filterStatus);
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
                    if(filterDate.isEmpty && filterStatus.isEmpty){
                       MessageHelper.showToast("Select any filter");
                    }
                    else{
                        Navigator.pop(context);
                    refNotifier.updateFilterValues(date: filterDate, type: filterStatus);
                    setState(() {
                    });
                    refNotifier.sampleRequisitionsListApiFunction();
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

 Widget selectedFiltersWidget({required SampleNotifier refNotifier,required SampleState refState}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
         refNotifier.filterDateValue.isNotEmpty? customFiltersUI(refNotifier.filterDateValue,
         (){
          refNotifier.filterDateValue='';
          filterDate = '';
          refNotifier.sampleRequisitionsListApiFunction();
          setState(() {
            
          });
         }
         ): EmptyWidget(),
          refNotifier.filterStatusValue.isNotEmpty? customFiltersUI(refNotifier.filterStatusValue,
          (){
            refNotifier.filterStatusValue='';
            filterStatus = '';
            selectedRadio=-1;
            refNotifier.sampleRequisitionsListApiFunction();
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
      child: Container(
        margin: EdgeInsets.only(left: 15),
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
    );
  }


}