import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/features/home_module/price_list/riverpod/price_list_notifier.dart';
import 'package:mohan_impex/features/home_module/price_list/riverpod/price_list_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PriceListScreen extends ConsumerStatefulWidget {
  const PriceListScreen({super.key});

  @override
  ConsumerState<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends ConsumerState<PriceListScreen> {
  int selectedRadio = 0;
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
    final refNotifier = ref.read(priceListProvider.notifier);
    refNotifier.resetFilter();
    refNotifier.resetValues();
      _scrollController.addListener(_scrollListener); 
   refNotifier.priceApiFunction();
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
    final state = ref.watch(priceListProvider);
    final notifier = ref.read(priceListProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if ((state.priceListModel?.data?[0].records?.length??0) <
              int.parse((state.priceListModel?.data?[0].totalCount??0).toString())) {
        notifier.priceApiFunction(isLoadMore: true);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(priceListProvider.notifier);
    final refState = ref.watch(priceListProvider);
    return Scaffold(
       appBar: customAppBar(title: "Price List"),
       body: Padding(
         padding: const EdgeInsets.only(top: 14),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: AppSearchBar(
                  hintText: "Search by SKU or product",
                  onChanged: (val){
                    refNotifier.onChangedSearch(context, val: val);
                  },
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: selectedFiltersWidget(refNotifier: refNotifier, refState: refState),
              ),
              const SizedBox(height: 16,),
              Expanded(child:refState.isLoading?
              priceListShimmer():
               priceListItems())
          ],
         ),
       ),
    );
  }
  


  filterBottomSheet(BuildContext context, PriceListNotifier refNotifier){
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
                      const SizedBox(height: 15,),
                      AppText(title: "Product Category",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          customRadioButton(isSelected:selectedRadio==0? true:false, title: 'All',
                          onTap: (){
                            state(() {
                              selectedRadio=0;
                               filterValue =   'All';
                            });
                          }
                          ),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==1? true:false, title: 'MP',
                          onTap: (){
                            state(() {
                              selectedRadio=1;
                              filterValue =   'MP';
                            });
                          }),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==2? true:false, title: 'BP',
                          onTap: (){
                            state(() {
                              selectedRadio=2;
                              filterValue =   'BP';
                            });
                          }),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==3? true:false, title: 'FP',
                          onTap: (){
                            state(() {
                              selectedRadio=3;
                              filterValue =   'FP';
                            });
                          }),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==4? true:false, title: 'TP',
                          onTap: (){
                            state(() {
                              selectedRadio=4;
                              filterValue =   'TP';
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 70,),
                       Align(
                  alignment: Alignment.center,
                  child: AppTextButton(title: "Apply",height: 35,width: 150,color: AppColors.arcticBreeze,
                  onTap: (){
                        Navigator.pop(context);
                    refNotifier.updateFilterValues( type: filterValue);
                    setState(() {
                    });
                    refNotifier.priceApiFunction();
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

  priceListItems(){
     final refState = ref.watch(priceListProvider);
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15,right:15,bottom: 20),
       controller: _scrollController,
      child: Column(
        children: [
          headerWidget(),
          Table(
                  border: TableBorder(
                 bottom: BorderSide(color: Color(0xff929292).withValues(alpha: .7)),
                 left: BorderSide(color: Color(0xff929292).withValues(alpha: .7)),
                 right: BorderSide(color: Color(0xff929292).withValues(alpha: .7)),
                 horizontalInside: BorderSide(color: Color(0xff929292).withValues(alpha: .7)),
                 verticalInside: BorderSide(color: Color(0xff929292).withValues(alpha: .7))
                  ),  // Adds borders to the table
                  children: [
                      ...List.generate((refState.priceListModel?.data?[0].records?.length ?? 0), (val){
                      var model = refState.priceListModel?.data?[0].records?[val];
                      return   TableRow(
                      children: [
                        _buildTableCell(model?.itemCode??'',fontSize: 10,isBGColor: false),
                        _buildTableCell(model?.itemName ?? "",fontSize: 10,isBGColor: false),
                        _buildTableCell(double.parse(model!.priceListRate.toString()).toStringAsFixed(2) ,fontSize: 10,isBGColor: false),
                        _buildTableCell(model.itemCategory ?? '',fontSize: 10,isBGColor: false),
                      ],
                    );
                    }).toList(),
                   
                                 ],
                ),
        ],
      ),
    );
  }

headerWidget(){
  return Container(
    height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6)
                    ),
                    border: Border(left: BorderSide(
                      color: Color(0xff929292).withValues(alpha: .7)
                    ),right: BorderSide(
                      color: Color(0xff929292).withValues(alpha: .7)
                    ))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        AppText(title: 'SKU',fontsize:11,fontFamily: AppFontfamily.poppinsSemibold,),
                    AppText(title: 'Product Name',fontsize:11,fontFamily: AppFontfamily.poppinsSemibold,),
                    AppText(title: "Unit Price",fontsize:11,fontFamily: AppFontfamily.poppinsSemibold,),
                    AppText(title: "Type",fontsize:11,fontFamily: AppFontfamily.poppinsSemibold,)
                    ],
                  ),
                );
}

Widget _buildTableCell(String text,{bool isBGColor = true,double fontSize =11}) {
    return TableCell(
      child: Container(
        height: 34,
        padding: EdgeInsets.symmetric(horizontal: 4),
        child:  Center(child: AppText(title: text,fontsize:10,fontFamily: AppFontfamily.poppinsRegular,)),
      ),
    );
  }


 Widget selectedFiltersWidget({required PriceListNotifier refNotifier,required PriceListState refState}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          refNotifier.filerValue.isNotEmpty? customFiltersUI(refNotifier.filerValue,
          (){
            refNotifier.filerValue='';
            filterValue = '';
            selectedRadio = 0;
            refState.currentPage = 1;
            refNotifier.priceApiFunction();
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


 priceListShimmer(){
  return Skeletonizer(
    enabled: true,
    child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8,right:8,bottom: 20),
        child: Table(
                border: TableBorder.all(color: AppColors.e2Color),  // Adds borders to the table
                children: [
                  TableRow(
                    children: [
                      _buildTableCell('SKU'),
                      _buildTableCell('Product Name'),
                      _buildTableCell('Unit Price'),
                      _buildTableCell('Type'),
                    ],
                  ),
                  ...List.generate(10, (val){
                    // var model = refState.priceListModel?.data?[0].records?[val];
                    return   TableRow(
                    children: [
                      _buildTableCell('SKU',fontSize: 10,isBGColor: false),
                      _buildTableCell( "Item",fontSize: 10,isBGColor: false),
                      _buildTableCell('19' ,fontSize: 10,isBGColor: false),
                      _buildTableCell('BP',fontSize: 10,isBGColor: false),
                    ],
                  );
                  }).toList(),
                 
                               ],
              ),
      ),
  );
 
 }


}
