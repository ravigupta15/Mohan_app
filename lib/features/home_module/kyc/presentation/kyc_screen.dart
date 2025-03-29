import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/add_kyc_screen.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/view_kyc_screen.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_notifier.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_state.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/kyc_item.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/res/shimmer/list_shimmer.dart';
import 'package:mohan_impex/utils/app_date_format.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';

class KycScreen extends ConsumerStatefulWidget {
  const KycScreen({super.key});

  @override
  ConsumerState<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends ConsumerState<KycScreen> {

int selectedCustomerTypeIndex = -1;
int selectedBusinessTypeIndex = -1;
int selectedSegmentTypeIndex = -1;
int selectedCategoryTypeIndex = -1;
String filterCustomerType = '';
String filterBusinessType = '';
String filterSegmentType = '';
String filterCategoryType = '';


resetValue(){
  selectedCustomerTypeIndex = -1;
  selectedBusinessTypeIndex = -1;
  selectedSegmentTypeIndex = -1;
  selectedCategoryTypeIndex = -1;
  filterCustomerType = '';
  filterBusinessType = '';
  filterSegmentType = '';
  filterCategoryType = '';
}

ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    resetValue();
    ref.read(kycProvider.notifier).resetValues();
    // ref.read(kycProvider.notifier).resetFilter();
     _scrollController.addListener(_scrollListener); 
   ref.read(kycProvider.notifier).kyclistApiFunction();
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
    final state = ref.watch(kycProvider);
    final notifier = ref.read(kycProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.kycModel?.data?[0].records?.length??0) <
              int.parse((state.kycModel?.data?[0].totalCount??0).toString())) {
        notifier.kyclistApiFunction(isLoadMore: true);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(kycProvider.notifier);
    final refState = ref.watch(kycProvider);
    return Scaffold(
      appBar: customAppBar(title: 'KYC'),
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AppSearchBar(
                hintText: "Search by ticket number",
                onChanged: refNotifier.onChangedSearch,
                controller: refNotifier.searchController,
                suffixWidget: Container(
                  alignment: Alignment.center,
                  width: refState.tabBarIndex==0?60: 60,
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssetPaths.searchIcon,width: 24,height: 24,),
                      Row(
                        children: [
                          Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 20,width: 1,color: AppColors.lightBlue62Color.withValues(alpha: .3),
                      ),
                       GestureDetector(
                        onTap: (){
                          TextfieldUtils.hideKeyboard();
                          filterBottomSheet(context, refNotifier, refState);
                        },
                        child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
             Padding(
                padding: const EdgeInsets.only(top: 10,left: 18, right: 18),
                child: selectedFiltersWidget(refNotifier: refNotifier, refState: refState),
              ),           
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTabbar(
                currentIndex: refState.tabBarIndex,
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
            approvedKycWidget(refNotifier: refNotifier,refState: refState,))
          ],
        ),
      ),
      floatingActionButton: floatingActionButtonWidget(
        onTap: (){
          AppRouter.pushCupertinoNavigation( AddKycScreen()).then((val){
            if(val == true){
              refNotifier.resetPageCount();
              refNotifier.updateTabBarIndex(1);
              refNotifier.kyclistApiFunction();
            }
          });
        }
      ),
    );
  }

Widget approvedKycWidget({required KycState refState, required KycNotifier refNotifier}){
  return refState.isLoading?
    CustomerVisitShimmer(isShimmer: refState.isLoading, isKyc: true):
    (refState.kycModel?.data?[0].records?.length ?? 0)>0?
    ListView.separated(
      separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      controller: _scrollController,
      itemCount: (refState.kycModel?.data?[0].records?.length ?? 0),
      padding: EdgeInsets.only(top: 10,bottom: 20,left: 18,right: 18),
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        var model = refState.kycModel?.data?[0].records?[index];
        return GestureDetector(
          onTap: (){
            AppRouter.pushCupertinoNavigation( ViewKycScreen(id: model?.name??''));
          },
          child: Column(
            children: [
              Container(
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
                              title: model?.name??'',
                              userIcon: AppAssetPaths.userIcon,
                              name: model?.customerName??'',
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
                     kycWidget(refState, model?.workflowState ??'', model?.statusDate??'')
                  ],
                ),
              ),
              index == (refState.kycModel?.data?[0].records?.length??0) - 1 &&
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
          ),
        );
    }): NoDataFound(title: "No ${refState.tabBarIndex ==0?"approved":"pending"} KYC found.");
 
}

kycWidget(KycState refState, String status, String date){
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Container(
          height: 5,width: 5,
          decoration: BoxDecoration(
            color:status.toLowerCase() == 'Approved'?
             AppColors.greenColor : AppColors.redColor,shape: BoxShape.circle
          ),
        ),
        const SizedBox(width: 4,),
        AppText(title: "$status : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: date,fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
      ],
    ),
  );
}


  filterBottomSheet(BuildContext context, KycNotifier refNotifier,KycState refState){
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
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppText(title: "Customer Type",fontFamily: AppFontfamily.poppinsSemibold,),
                      ),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: List.generate(AppConstants.companyTypeList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: customRadioButton(isSelected:selectedCustomerTypeIndex==val? true:false, title: AppConstants.companyTypeList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedCustomerTypeIndex=val;
                               filterCustomerType = AppConstants.companyTypeList[val];
                                });
                                });
                              }
                              ),
                            );
                          }).toList() 
                        ),
                      ),
                    const SizedBox(height: 25,),
                      Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppText(title: "Business Type",fontFamily: AppFontfamily.poppinsSemibold,),
                      ),
                      const SizedBox(height: 10,),

                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(AppConstants.businessList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: customRadioButton(isSelected:selectedBusinessTypeIndex==val? true:false, title: AppConstants.businessList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedBusinessTypeIndex=val;
                                 filterBusinessType = AppConstants.businessList[val];
                                });
                                });
                              }
                              ),
                            );
                          }).toList() 
                        ),
                      ),
                      const SizedBox(height: 25,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                         child: AppText(title: "Segment",fontFamily: AppFontfamily.poppinsSemibold,),
                       ),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: List.generate(AppConstants.segmentList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: customRadioButton(isSelected:selectedSegmentTypeIndex==val? true:false, title: AppConstants.segmentList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedSegmentTypeIndex=val;
                                 filterSegmentType = AppConstants.segmentList[val];
                                });
                                });
                              }
                              ),
                            );
                          }).toList() 
                        ),
                      ),
                    const SizedBox(height: 25,),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                         child: AppText(title: "Customer Category",fontFamily: AppFontfamily.poppinsSemibold,),
                       ),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: List.generate(AppConstants.customerCategoryList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: customRadioButton(isSelected:selectedCategoryTypeIndex==val? true:false, title: AppConstants.customerCategoryList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedCategoryTypeIndex=val;
                                 filterCategoryType = AppConstants.customerCategoryList[val];
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
                    if(filterCustomerType.isEmpty && filterBusinessType.isEmpty && filterSegmentType.isEmpty &&filterCategoryType.isEmpty){
                       MessageHelper.showToast("Select any filter");
                    }
                    else{
                        Navigator.pop(context);
                    refNotifier.updateFilterValues(
                      customerType: filterCustomerType,
                      businessType: filterBusinessType,
                      categoryType: filterCategoryType,
                      segmentType: filterSegmentType
                    );
                    setState(() {
                    });
                    refNotifier.kyclistApiFunction();
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

 Widget selectedFiltersWidget({required KycNotifier refNotifier,required KycState refState}){  
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         refNotifier.customerTypeFilter.isNotEmpty? customFiltersUI(refNotifier.customerTypeFilter,
         (){
          refNotifier.customerTypeFilter='';
          filterCustomerType = '';
          selectedCustomerTypeIndex=-1;
          refNotifier.kyclistApiFunction();
          setState(() {
          });
         }
         ): EmptyWidget(),
          refNotifier.businessTypeFilter.isNotEmpty? customFiltersUI(refNotifier.businessTypeFilter,
          (){
            refNotifier.businessTypeFilter='';
            filterBusinessType = '';
            selectedBusinessTypeIndex=-1;
            refNotifier.kyclistApiFunction();
          setState(() {
          });
          }
          ): EmptyWidget(),
          refNotifier.segmentFilter.isNotEmpty? customFiltersUI(refNotifier.segmentFilter,
          (){
            refNotifier.segmentFilter='';
            filterSegmentType = '';
            selectedSegmentTypeIndex=-1;
            refNotifier.kyclistApiFunction();
          setState(() {
          });
          }
          ): EmptyWidget(),
          refNotifier.customerCategoryFilter.isNotEmpty? customFiltersUI(refNotifier.customerCategoryFilter,
          (){
            refNotifier.customerCategoryFilter='';
            filterCategoryType = '';
            selectedCategoryTypeIndex=-1;
            refNotifier.kyclistApiFunction();
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