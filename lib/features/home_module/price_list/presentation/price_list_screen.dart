import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class PriceListScreen extends StatefulWidget {
  const PriceListScreen({super.key});

  @override
  State<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreen> {
  int selectedRadio = 0;
  @override
  Widget build(BuildContext context) {
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
                            filterBottomSheet(context);
                          },
                          child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                       
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              Expanded(child: _PriceListItems())
          ],
         ),
       ),
    );
  }
  


  filterBottomSheet(BuildContext context){
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
                            });
                          }
                          ),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==1? true:false, title: 'MP',
                          onTap: (){
                            state(() {
                              selectedRadio=1;
                            });
                          }),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==2? true:false, title: 'BP',
                          onTap: (){
                            state(() {
                              selectedRadio=2;
                            });
                          }),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==2? true:false, title: 'FP',
                          onTap: (){
                            state(() {
                              selectedRadio=2;
                            });
                          }),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==2? true:false, title: 'TP',
                          onTap: (){
                            state(() {
                              selectedRadio=2;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 70,),
                       Align(
                  alignment: Alignment.center,
                  child: AppTextButton(title: "Apply",height: 35,width: 150,color: AppColors.arcticBreeze,),
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

}

class _PriceListItems extends StatelessWidget {
  const _PriceListItems();

  @override
  Widget build(BuildContext context) {
    return tableWidget();
  }


  tableWidget(){
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
                ...List.generate(15, (val){
                  return  TableRow(
                  children: [
                    _buildTableCell('MP001',fontSize: 10,isBGColor: false),
                    _buildTableCell('Product A',fontSize: 10,isBGColor: false),
                    _buildTableCell('1200.00',fontSize: 10,isBGColor: false),
                    _buildTableCell('TP',fontSize: 10,isBGColor: false),
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

}