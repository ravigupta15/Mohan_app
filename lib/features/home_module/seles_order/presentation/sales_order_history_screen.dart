import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/sales_order_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/presentation/new_sales_order_screen.dart';
import 'package:mohan_impex/features/home_module/seles_order/presentation/view_order_screen.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/sales_order_notifier.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/sales_order_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/res/shimmer/list_shimmer.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';
import '../../../../res/app_colors.dart';

class SalesOrderHistoryScreen extends ConsumerStatefulWidget {
  const SalesOrderHistoryScreen({super.key});

  @override
  ConsumerState<SalesOrderHistoryScreen> createState() => _SalesOrderHistoryScreenState();
}

class _SalesOrderHistoryScreenState extends ConsumerState<SalesOrderHistoryScreen> {

String filterFromDate = '';
  String filterToDate = '';
  DateTime? fromDate;
  DateTime? todDate;

  
resetValue(){
  filterFromDate = '';
  filterFromDate = '';
  fromDate = null;
    todDate = null;
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
    ref.read(salesOrderProvider.notifier).resetValues();
   ref.read(salesOrderProvider.notifier).salesOrderApiFunction();
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
    final state = ref.watch(salesOrderProvider);
    final notifier = ref.read(salesOrderProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.salesOrderModel?.data?[0].records?.length??0) <
              int.parse((state.salesOrderModel?.data?[0].totalCount??0).toString())) {
        notifier.salesOrderApiFunction(isLoadMore: true);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(salesOrderProvider);
    final refNotifier = ref.read(salesOrderProvider.notifier);
    return Scaffold(
     appBar:  customAppBar(title: 'Sales Order History'),
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AppSearchBar(
                hintText: "Search by name, phone, etc.",
                onChanged: refNotifier.onChangedSearch,
                controller:refNotifier.searchController,
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
                       GestureDetector(
                        onTap: (){
                          TextfieldUtils.hideKeyboard();
                             filterBottomSheet(context, refNotifier, refState);
                        },
                        child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                    ],
                  ),
                ),
              ),
            ),

               Padding(
                padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
                child: selectedFiltersWidget(refNotifier: refNotifier, refState: refState),
              ), 
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: CustomTabbar(
                currentIndex: refState.tabBarIndex,
                title1: "My Orders",
                title2: "Draft Order",
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
            Expanded(child: 
           refState.tabBarIndex==0?myOrderWidget(refState):
            draftOrderWidget(refState
            ))
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: (){
        AppRouter.pushCupertinoNavigation( NewSalesOrderScreen(route: '',)).then((val){
          print("val...$val");
          if((val??false)==true){
            refNotifier.updateTabBarIndex(0);
            refNotifier.salesOrderApiFunction();
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

  
  Widget myOrderWidget(SalesOrderState refState){
    return refState.isLoading?
    CustomerVisitShimmer(isShimmer: refState.isLoading,isKyc: true,):
     (refState.salesOrderModel?.data?[0].records?.length??0)>0?
    ListView.separated(
       separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: (refState.salesOrderModel?.data?[0].records?.length??0),
      padding: EdgeInsets.only(top: 10,bottom: 20,left: 18,right: 18),
      controller: _scrollController,
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        return Column(
          children: [
            _VisitItemsWidget(model: refState.salesOrderModel?.data?[0].records?[index],isDraft: false,),
             index == (refState.salesOrderModel?.data?[0].records?.length??0) - 1 &&
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
    }): NoDataFound(title: "No orders found");
  }

Widget draftOrderWidget(SalesOrderState refState){
  return refState.isLoading?
    CustomerVisitShimmer(isShimmer: refState.isLoading,isKyc: false,):
    (refState.salesOrderModel?.data?[0].records?.length??0)>0?
  ListView.separated(
       separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      controller: _scrollController,
      itemCount: (refState.salesOrderModel?.data?[0].records?.length??0),
      padding: EdgeInsets.only(top: 10,bottom: 20, left: 18, right: 18),
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        return Column(
          children: [
            _VisitItemsWidget(model:refState.salesOrderModel?.data?[0].records?[index], isDraft: true,),
             index == (refState.salesOrderModel?.data?[0].records?.length??0) - 1 &&
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
    }) : NoDataFound(title: "Visit draft data not found");
}




  filterBottomSheet(BuildContext context, SalesOrderNotifier refNotifier,SalesOrderState refState){
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
                      const SizedBox(height: 25,),
                       Align(
                  alignment: Alignment.center,
                  child: AppTextButton(title: "Apply",height: 35,width: 150,color: AppColors.arcticBreeze,
                  onTap: (){
                    if(filterFromDate.isEmpty && filterToDate.isEmpty ){
                       MessageHelper.showToast("Select any filter");
                    }
                    else{
                        Navigator.pop(context);
                    refNotifier.updateFilterValues(
                      fromDate: filterFromDate,
                      toDate: filterToDate
                    );
                    setState(() {
                    });
                    refNotifier.salesOrderApiFunction();
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

 Widget selectedFiltersWidget({required SalesOrderNotifier refNotifier,required SalesOrderState refState}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       refNotifier.fromDateFilter.isNotEmpty? customFiltersUI(refNotifier.fromDateFilter,
       (){
        refNotifier.fromDateFilter='';
        filterFromDate = '';
        refNotifier.salesOrderApiFunction();
        setState(() {
        });
       }
       ): EmptyWidget(),
        refNotifier.toDateFilter.isNotEmpty? customFiltersUI(refNotifier.toDateFilter,
        (){
          refNotifier.toDateFilter='';
          filterToDate = '';
          refNotifier.salesOrderApiFunction();
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
 SalesRecords? model;
 final bool isDraft;
   _VisitItemsWidget({required this.model,required this.isDraft});

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: (){
            // id: model?.name??'',
            AppRouter.pushCupertinoNavigation( ViewOrderScreen(id: model?.name??'',isDraft: isDraft,));
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      visitItem(title: 'Shop name', subTitle: model?.customShopName??''),
                      const SizedBox(height: 9,),
                      visitItem(title:"Contact",subTitle: model?.contact??''),
                      const SizedBox(height: 9,),
                      visitItem(title:"Location",subTitle: model?.location??''),
                    ],
                  ),
                ),
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
}