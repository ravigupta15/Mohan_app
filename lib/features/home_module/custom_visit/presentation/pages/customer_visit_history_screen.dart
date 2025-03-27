import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/customer_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/new_customer_visit_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/riverpod/customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/riverpod/customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/custom_visit/presentation/pages/visit_details_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/shimmer/list_shimmer.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';

class CustomerVisitHistoryScreen extends ConsumerStatefulWidget {
  const CustomerVisitHistoryScreen({super.key});

  @override
  ConsumerState<CustomerVisitHistoryScreen> createState() => _CustomerVisitHistoryScreenState();
}

class _CustomerVisitHistoryScreenState extends ConsumerState<CustomerVisitHistoryScreen> {
int selectedCustomerTypeIndex = -1;
int selectedVisitTypeIndex = -1;
int selectedKycIndex = -1;
int selectedProductTrialIndex = -1;
String filterCustomerType = '';
String filterVisitType = '';
String filterKycStatus = '';
String filterProductTrial = '';

resetValue(){
  selectedCustomerTypeIndex = -1;
  selectedKycIndex = -1;
  selectedProductTrialIndex = -1;
  selectedVisitTypeIndex = -1;
  filterCustomerType ='';
  filterKycStatus = '';
  filterProductTrial = '';
  filterVisitType = '';
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
    _scrollController.addListener(_scrollListener); 
    ref.read(customVisitProvider.notifier).resetValues();
   ref.read(customVisitProvider.notifier).customVisitApiFunction();
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
    final state = ref.watch(customVisitProvider);
    final notifier = ref.read(customVisitProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.customerVisitModel?.data?[0].records?.length??0) <
              int.parse((state.customerVisitModel?.data?[0].totalCount??0).toString())) {
        notifier.customVisitApiFunction(isLoadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(customVisitProvider.notifier);
    final refState = ref.watch(customVisitProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(title: 'Customer Visit History'),
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AppSearchBar(
                hintText: "Search by name, phone, etc.",
                onChanged: refNotifier.onChangedSearch,
                suffixWidget: Container(
                  alignment: Alignment.center,
                  width:  60,
                  child: 
                      Row(
                        children: [
                           SvgPicture.asset(AppAssetPaths.searchIcon,height: 20,),
                          Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
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
                ),
              ),
            ),
               Padding(
                padding: const EdgeInsets.only(top: 10, left: 18,right: 18),
                child: selectedFiltersWidget(refNotifier: refNotifier, refState: refState),
              ),           
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: CustomTabbar(
                currentIndex: refState.tabBarIndex,
                title1: "My Visit",
                title2: "Visit Draft",
                onClicked1: (){
                  if(refState.tabBarIndex!=0){
                    resetValue();
                  }
                  refNotifier.updateTabBarIndex(0);
                  setState(() {
                  });
                },
                onClicked2: (){
                  if(refState.tabBarIndex!=1){
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
            refState.tabBarIndex==0 ? 
            myVisitWidget(refState,refNotifier):
            visitDraftWidget(refState, refNotifier))
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: (){
        AppRouter.pushCupertinoNavigation( NewCustomerVisitScreen(route: '',)).then((val){
          if((val ?? false) == true){
            refNotifier.resetFilter();
            refNotifier.resetPageCount();
            refState.tabBarIndex = 0;
            refNotifier.customVisitApiFunction();
            setState(() {
              
            });
          }
        });
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

  Widget myVisitWidget(CustomerVisitState refState, CustomerVisitNotifier refNotifier){
    return refState.isLoading?
    CustomerVisitShimmer(isShimmer: refState.isLoading,isKyc: true,):
     (refState.customerVisitModel?.data?[0].records?.length??0)>0?
    ListView.separated(
       separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: (refState.customerVisitModel?.data?[0].records?.length??0),
      padding: EdgeInsets.only(top: 10,bottom: 20, left: 18, right: 18),
      shrinkWrap: true,
      controller: _scrollController,
      itemBuilder: (ctx,index){
        return Column(
          children: [
            _VisitItemsWidget(isKyc:  true,
            refNotifier: refNotifier,
            model: refState.customerVisitModel?.data?[0].records?[index],),
             index == (refState.customerVisitModel?.data?[0].records?.length??0) - 1 &&
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
    }): NoDataFound(title: "No visit orders found");
  }

Widget visitDraftWidget(CustomerVisitState refState, CustomerVisitNotifier refNotifier){
  return refState.isLoading?
    CustomerVisitShimmer(isShimmer: refState.isLoading,isKyc: false,):
    (refState.customerVisitModel?.data?[0].records?.length??0)>0?
  ListView.separated(
       separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      controller: _scrollController,
      itemCount: (refState.customerVisitModel?.data?[0].records?.length??0),
      padding: EdgeInsets.only(top: 10,bottom: 20, left: 18, right: 18),
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        return Column(
          children: [
            _VisitItemsWidget(isKyc: false,model:refState.customerVisitModel?.data?[0].records?[index] ,
            refNotifier: refNotifier,
            ),
             index == (refState.customerVisitModel?.data?[0].records?.length??0) - 1 &&
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
    }) : NoDataFound(title: "No draft orders found");
}


  filterBottomSheet(BuildContext context, CustomerVisitNotifier refNotifier,CustomerVisitState refState){
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
                      AppText(title: "Customer Type",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(refNotifier.customerTypeList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(isSelected:selectedCustomerTypeIndex==val? true:false, title: refNotifier.customerTypeList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedCustomerTypeIndex=val;
                               filterCustomerType = refNotifier.customerTypeList[val];
                                });
                                });
                              }
                              ),
                            );
                          }).toList() 
                        ),
                      ),
                    const SizedBox(height: 25,),
                      AppText(title: "Visit Type",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(refNotifier.visitTypeList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(isSelected:selectedVisitTypeIndex==val? true:false, title: refNotifier.visitTypeList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedVisitTypeIndex=val;
                               filterVisitType = refNotifier.visitTypeList[val];
                                });
                                });
                              }
                              ),
                            );
                          }).toList() 
                        ),
                      ),
                      const SizedBox(height: 25,),
                       AppText(title: "Kyc Status",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(refNotifier.kycStatusList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(isSelected:selectedKycIndex==val? true:false, title: refNotifier.kycStatusList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedKycIndex=val;
                               filterKycStatus = refNotifier.kycStatusList[val];
                                });
                                });
                              }
                              ),
                            );
                          }).toList() 
                        ),
                      ),
                    
                     const SizedBox(height: 25,),
                       AppText(title: "Product Trial",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(refNotifier.productTrialList.length, (val){
                            return  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(isSelected:selectedProductTrialIndex==val? true:false, title: refNotifier.productTrialList[val],
                              onTap: (){
                                setState(() {
                                  state(() {
                                  selectedProductTrialIndex=val;
                               filterProductTrial = refNotifier.productTrialList[val];
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
                    if(filterCustomerType.isEmpty && filterVisitType.isEmpty && filterKycStatus.isEmpty &&filterProductTrial.isEmpty){
                       MessageHelper.showToast("Select any filter");
                    }
                    else{
                        Navigator.pop(context);
                    refNotifier.updateFilterValues(
                      customerType: filterCustomerType,
                    kycStatus: filterKycStatus,
                    productTrial: filterProductTrial,
                    visitType: filterVisitType
                    );
                    setState(() {
                    });
                    refNotifier.customVisitApiFunction();
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

 Widget selectedFiltersWidget({required CustomerVisitNotifier refNotifier,required CustomerVisitState refState}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       refNotifier.customerTypeFilter.isNotEmpty? customFiltersUI(refNotifier.customerTypeFilter,
       (){
        refNotifier.customerTypeFilter='';
        filterCustomerType = '';
        selectedCustomerTypeIndex=-1;
        refNotifier.customVisitApiFunction();
        setState(() {
        });
       }
       ): EmptyWidget(),
        refNotifier.visitTypFilter.isNotEmpty? customFiltersUI(refNotifier.visitTypFilter,
        (){
          refNotifier.visitTypFilter='';
          filterVisitType = '';
          selectedVisitTypeIndex=-1;
          refNotifier.customVisitApiFunction();
        setState(() {
        });
        }
        ): EmptyWidget(),
        refNotifier.kycStatusFilter.isNotEmpty? customFiltersUI(refNotifier.kycStatusFilter,
        (){
          refNotifier.kycStatusFilter='';
          filterKycStatus = '';
          selectedKycIndex=-1;
          refNotifier.customVisitApiFunction();
        setState(() {
        });
        }
        ): EmptyWidget(),
        refNotifier.hasProductTrialFilter.isNotEmpty? customFiltersUI(refNotifier.hasProductTrialFilter=='0'?"No":"Yes",
        (){
          refNotifier.hasProductTrialFilter='';
          filterProductTrial = '';
          selectedProductTrialIndex=-1;
          refNotifier.customVisitApiFunction();
        setState(() {
        });
        }
        ): EmptyWidget(),
      ],
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

// ignore: must_be_immutable
class _VisitItemsWidget extends StatelessWidget {
 final bool isKyc;
 CustomerVisitRecords? model;
 final CustomerVisitNotifier refNotifier;
   _VisitItemsWidget({required this.isKyc, required this.model,required this.refNotifier});

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: (){
            AppRouter.pushCupertinoNavigation( VisitDetailsScreen(id: model?.name??'',)).then((val){
              if(val!=null){
                refNotifier.resetPageCount();
                refNotifier.customVisitApiFunction();
              }
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:(model?.imageUrl??'').isEmpty?
                        SizedBox():
                         AppNetworkImage(imgUrl: model?.imageUrl??'',height: 64,width: 70,boxFit: BoxFit.cover,),
                      ),
                      const SizedBox(width: 13,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          visitItem(title: 'Shop name', subTitle: model?.shopName??''),
                          const SizedBox(height: 9,),
                          visitItem(title:"Contact",subTitle: model?.contact??''),
                          const SizedBox(height: 9,),
                          visitItem(title:"Location",subTitle: model?.location??''),
                        ],
                      )
                    ],
                  ),
                ),
                isKyc && (model?.customerLevel ?? '').toString().toLowerCase() != 'secondary'?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Divider(
                    color: AppColors.edColor,
                  ),
                ),
                 kycWidget(model?.workflowState??'')
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
        AppText(title: "$title : ",fontsize: 12,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: subTitle,fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
      ],
    );
}

kycWidget(String status){
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
        AppText(title: "KYC : ",fontsize: 12,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: status,fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
      ],
    ),
  );
}


}