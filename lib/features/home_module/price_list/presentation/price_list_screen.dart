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

class PriceListScreen extends ConsumerStatefulWidget {
  const PriceListScreen({super.key});

  @override
  ConsumerState<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends ConsumerState<PriceListScreen> {
  int selectedRadio = 0;
  String filterValue = '';

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
    refNotifier.priceApiFunction(context);
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
              Expanded(child: priceListItems())
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
                    refNotifier.priceApiFunction(context);
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
                ...List.generate((refState.priceListModel?.data?.length ?? 0), (val){
                  var model = refState.priceListModel?.data![val];
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
    );
  }



Widget _buildTableCell(String text,{bool isBGColor = true,double fontSize =11}) {
    return TableCell(
      child: Container(
        height: 30,
        color:isBGColor? AppColors.greenColor:null,
        child: Center(child: AppText(title: text,fontsize:fontSize,fontFamily: AppFontfamily.poppinsMedium,)),
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
            refNotifier.priceApiFunction(context);
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
