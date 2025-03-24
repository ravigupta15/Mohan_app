import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/home_module/schemes_management/model/scheme_model.dart';
import 'package:mohan_impex/features/home_module/schemes_management/riverpod/schemes_notifier.dart';
import 'package:mohan_impex/features/home_module/schemes_management/riverpod/schemes_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/render_html_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SchemesManagementScreen extends ConsumerStatefulWidget {
  const SchemesManagementScreen({super.key});

  @override
  ConsumerState<SchemesManagementScreen> createState() => _SchemesManagementScreenState();
}

class _SchemesManagementScreenState extends ConsumerState<SchemesManagementScreen> {

  int selectedRadio=0;
  String filterValue = '';

ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    ref.read(schemesProvider.notifier).resetValues();
    filterValue='';
     _scrollController.addListener(_scrollListener); 
   ref.read(schemesProvider.notifier).callApiFunction();
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
    final state = ref.watch(schemesProvider);
    final notifier = ref.read(schemesProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.schemeModel?.data?.length??0) <
              int.parse((state.schemeModel?.data?[0].totalCount??0).toString())) {
        notifier.callApiFunction(isLoadMore: true);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(schemesProvider);
    final refNotifier = ref.read(schemesProvider.notifier);
    return Scaffold(
       appBar: customAppBar(title: "Scheme Management"),
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: AppSearchBar(
                hintText: "Search scheme",
                onChanged: refNotifier.onChangedSearch,
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
                          filterBottomSheet(context, refNotifier);
                        },
                        child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                    ],
                  ),
                ),
              ),
            ),
         const SizedBox(height: 10,),
         selectedFiltersWidget(refNotifier: refNotifier, refState: refState),
         const SizedBox(height: 15,),
         Expanded(
           child: refState.isLoading?
           SchemsShimmer():
           (refState.schemeModel?.data?[0].records??[]).isEmpty? 
           NoDataFound(title: "No schemes data found"):
           ListView.separated(
            separatorBuilder: (ctx,sb){
              return const SizedBox(height: 15,);
            },
            controller: _scrollController,
            itemCount: (refState.schemeModel?.data?[0].records?.length??0),
            padding: EdgeInsets.only(top: 5,left: 17,right:  17,bottom: 30),
            shrinkWrap: true,
            itemBuilder: (ctx,index){
              var model = refState.schemeModel?.data?[0].records?[index];
            return Column(
              children: [
                schemeWidget(model!),
                 index == (refState.schemeModel?.data?[0].records?.length??0) - 1 &&
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
           }),
         )
        ],
       ),
    );
  }


  filterBottomSheet(BuildContext context, SchemesNotifier refNotifier){
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
                  padding: const EdgeInsets.only(left: 26,right: 26,top: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(title: "Scheme Category",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 28,),
                      Row(
                        children: [
                          customRadioButton(isSelected:selectedRadio==0? true:false, title: 'All',
                          onTap: (){
                            state(() {
                              selectedRadio=0;
                              filterValue = "";
                            });
                          }
                          ),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==1? true:false, title: 'Spot Scheme',
                          onTap: (){
                            state(() {
                              selectedRadio=1;
                              filterValue = "Spot";
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 30,),
                       Align(
                  alignment: Alignment.center,
                  child: AppTextButton(title: "Apply",height: 35,width: 150,color: AppColors.arcticBreeze,
                  onTap: (){
                      if(filterValue.isEmpty){
                       MessageHelper.showToast("Select any filter");
                    }
                    else{
                        Navigator.pop(context);
                    refNotifier.updateFilterValues(type: filterValue);
                    setState(() {
                    });
                    refNotifier.callApiFunction(isLoadMore: false);
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

Widget schemeWidget(SchemeRecord model){
  return ExpandableWidget(
      initExpanded: false,
      collapsedWidget: collapsedWidget(model, isExpanded: true), expandedWidget: expandedWidget(model, isExpanded: false));
  // Container(
  //      padding: EdgeInsets.only(bottom: 15),
  //         decoration: BoxDecoration(
  //           color: AppColors.whiteColor,
  //           borderRadius: BorderRadius.circular(5),
  //           boxShadow: [
  //             BoxShadow(
  //               offset: Offset(0, 0),
  //               color: AppColors.black.withValues(alpha: .2),
  //               blurRadius: 3
  //             )
  //           ]
  //         ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(left: 17,right: 5),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       AppText(title: model.title??'',fontsize: 20,fontFamily: AppFontfamily.poppinsMedium,),
  //                       const SizedBox(height: 10,),
  //                       AppText(title: model.description??'',fontsize: 10,fontWeight: FontWeight.w300,)
  //                     ],
  //                   ),
  //                 ),
  //                 AppText(title: "${(model.discountPercentage??'')}%".toString(),color: AppColors.greenColor,fontsize: 48,fontFamily: AppFontfamily.poppinsMedium,)
  //               ],
  //             ),
  //           ),
  //           Divider(
  //                 color: AppColors.edColor,
  //               ),
  //               const SizedBox(height: 5,),
  //               validWidget(model),
  //               termsConditionWidget(model)
  //         ],
  //       ),
  //   );

}



Widget collapsedWidget(SchemeRecord model,{required bool isExpanded}){
  return Container(
      padding:isExpanded? EdgeInsets.symmetric(horizontal: 10,vertical: 14):EdgeInsets.zero,
    child:    Padding(
              padding: const EdgeInsets.only(left: 15,right: 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(!isExpanded? Icons.expand_less:Icons.expand_more,color: AppColors.light92Color,)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(title: model.title??'',fontsize: 19,fontFamily: AppFontfamily.poppinsMedium,),
                            const SizedBox(height: 10,),
                            AppText(title: model.description??'',fontsize: 10,fontWeight: FontWeight.w300,)
                          ],
                        ),
                      ),
                      const SizedBox(width: 4,),
                      AppText(title: "${(model.discountPercentage??'')}%".toString(),color: AppColors.greenColor,fontsize: 46,fontFamily: AppFontfamily.poppinsMedium,),
                    ],
                  ),
                  
                ],
              ),
            ),
  
  );
}

Widget expandedWidget(SchemeRecord model,{required bool isExpanded}){
  return  Container(
       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(0, 0),
        //     color: AppColors.black.withValues(alpha: .2),
        //     blurRadius: 10
        //   )
        // ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       collapsedWidget(model, isExpanded: isExpanded),
                     Divider(
                  color: AppColors.edColor,
                ),
                const SizedBox(height: 5,),
                validWidget(model),
                termsConditionWidget(model)
  
            
        ],
      ),
    );
}





  validWidget(SchemeRecord model){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        children: [
          Row(
            children: [
              Container(
          height: 5,width: 5,
          decoration: BoxDecoration(
            color: AppColors.greenColor,shape: BoxShape.circle
          ),
        ),
        const SizedBox(width: 4,),
        AppText(title: "Valid till : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: model.validUpto??'',fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
        const Spacer(),
        AppText(title: "Min Order : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: (model.minQty??'').toString(),fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
            ],
          ),
          
        ],
      ),
    );
  }

  termsConditionWidget(SchemeRecord model){
    return Padding(
      padding: const EdgeInsets.only(left: 18,right: 8,top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title: "Terms Condition:",fontsize: 10,fontFamily: AppFontfamily.poppinsMedium,),
          const SizedBox(height: 6,),
         RandersHtmlWidget(text: model.termsAndConditions)
        ],
      ),
    );
  }


 Widget selectedFiltersWidget({required SchemesNotifier refNotifier,required SchemesState refState}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
         refNotifier.filterSchemeType.isNotEmpty? customFiltersUI(refNotifier.filterSchemeType,
         (){
          refNotifier.filterSchemeType='';
          filterValue = '';
          selectedRadio=0;
          refNotifier.callApiFunction();
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

class SchemsShimmer extends StatelessWidget {
  const SchemsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        separatorBuilder: (ctx,sb){
                return const SizedBox(height: 15,);
              },
              itemCount: 4,
              padding: EdgeInsets.only(top: 5,left: 17,right:  17,bottom: 30),
              shrinkWrap: true,
        itemBuilder: (ctx,index){
          return _SchemeWidgetForShimmer();
      }),
    );
  }
}

class _SchemeWidgetForShimmer extends StatelessWidget {

  const _SchemeWidgetForShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.only(bottom: 15),
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
              padding: const EdgeInsets.only(left: 17,right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(title: "SP1001",fontsize: 20,fontFamily: AppFontfamily.poppinsMedium,),
                        const SizedBox(height: 10,),
                        AppText(title: "Festive season discount",fontsize: 10,fontWeight: FontWeight.w300,)
                      ],
                    ),
                  ),
                  AppText(title: "10%",color: AppColors.greenColor,fontsize: 48,fontFamily: AppFontfamily.poppinsMedium,)
                ],
              ),
            ),
            Divider(
                  color: AppColors.edColor,
                ),
                const SizedBox(height: 5,),
                validWidget(),
                termsConditionWidget()
          ],
        ),
    );
  }

  validWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        children: [
          Row(
            children: [
              Container(
          height: 5,width: 5,
          decoration: BoxDecoration(
            color: AppColors.greenColor,shape: BoxShape.circle
          ),
        ),
        const SizedBox(width: 4,),
        AppText(title: "Valid till : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: "2025-10-20",fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
        const Spacer(),
        AppText(title: "Min Order : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: "10,000",fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
            ],
          ),
          
        ],
      ),
    );
  }

  termsConditionWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 18,right: 8,top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title: "Terms Condition:",fontsize: 10,fontFamily: AppFontfamily.poppinsMedium,),
          const SizedBox(height: 6,),
          termsConditionItems("Application on all products"),
          const SizedBox(height: 6,),
          termsConditionItems("Cannot be combined with other offers"),
          const SizedBox(height: 6,),
          termsConditionItems("Subject to available stock"),
        ],
      ),
    );
  }

  termsConditionItems(String title){
    return Row(
      children: [
        Container(
          height: 4,width:4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.light92Color
          ),
        ),
        const SizedBox(width: 5,),
        AppText(title: title,fontsize: 10,)
      ],
    );
  }
}