import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class ViewCustomerScreen extends StatefulWidget {
  const ViewCustomerScreen({super.key});

  @override
  State<ViewCustomerScreen> createState() => _ViewCustomerScreenState();
}

class _ViewCustomerScreenState extends State<ViewCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'My Customers'),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 12,left: 18,right: 18,bottom: 25),
        child: Column(
          children: [
            _CustomInfoWidget(),
            const SizedBox(height: 15,),
            _LedgerHistory()
          ],
        ),
      ),
    );
  }
}


class _CustomInfoWidget extends StatelessWidget {
  const _CustomInfoWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true),
     expandedWidget: expandedWidget(isExpanded: false));
  }
  

  collapsedWidget({required bool isExpanded}){
    return Container(
      padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:!isExpanded?[]: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: 'Customer Information',fontFamily: AppFontfamily.poppinsSemibold,
              ),
            Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
    );
  }

   expandedWidget({required bool isExpanded}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 9,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 6,),
            itemsWidget("Customer Name", "Ramesh"),
            const SizedBox(height: 10,),
            itemsWidget("Shop Name", "Ammas"),
            const SizedBox(height: 10,),
            itemsWidget("Contact", "7049234489"),
            const SizedBox(height: 10,),
            itemsWidget("Location", "123, Market Street"),
        ],
      ),
    );
  }




  Widget itemsWidget(String title, String subTitle){
    return Row(
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsMedium,),
        AppText(title: subTitle,
        fontsize: 13,
        fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
      ],
    );
  }
}

class _LedgerHistory extends StatelessWidget {
  const _LedgerHistory();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collpasedWidget(context, isExpanded: true), expandedWidget: expandedWidget(context,isExpanded: false));
  }

  collpasedWidget(BuildContext context,{required bool isExpanded}){
    return Container(
      padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:!isExpanded?[]: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: 'Ledger History',fontFamily: AppFontfamily.poppinsSemibold,
              ),
            Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
    );
  }

  expandedWidget(BuildContext context, {required bool isExpanded,}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collpasedWidget(context, isExpanded: isExpanded),
            const SizedBox(height: 9,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 15,),
           Row(
            children: [
              customBalanceContainer("Outstanding Balance", "120000.65"),
              const SizedBox(width: 10,),
              customBalanceContainer("Last Billing rate", "120000.65"),
            ],
           ),
            const SizedBox(height: 15,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
          const SizedBox(height: 15,),
          AppSearchBar(
                hintText: "Search",
                suffixWidget: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(AppAssetPaths.searchIcon),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    filtersWidget("Filters",context, isFilterIcon: true),
                    const SizedBox(width: 5,),
                    filtersWidget('Date',context,),
                  ],
                ),
              ),
              tableWidget()
        ],
      ),
    );
  }

filtersWidget(String title, BuildContext context, {bool isFilterIcon=false}){
  return InkWell(
    onTap: (){
      if(isFilterIcon){
        filterBottomSheet(context);
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
          border: Border.all(color: AppColors.greenColor),
          borderRadius: BorderRadius.circular(15)
        ),
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
        // alignment: Alignment.center,
        child: Row(
          children: [
            isFilterIcon?
            SvgPicture.asset(AppAssetPaths.filterIcon,height: 14,):SizedBox.shrink(),
            const SizedBox(width: 4,),
            AppText(title: title,fontFamily: AppFontfamily.poppinsSemibold,fontsize: 11,),
          ],
        ),
    ),
  );
}

  tableWidget(){
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Table(
              border: TableBorder.all(color: AppColors.e2Color),  // Adds borders to the table
              children: [
                TableRow(
                  children: [
                    _buildTableCell('Date'),
                    _buildTableCell('Description'),
                    _buildTableCell('Amount'),
                    _buildTableCell('Balance'),
                  ],
                ),
                TableRow(
                  children: [
                    _buildTableCell('12-10-2025',fontSize: 10,isBGColor: false),
                    _buildTableCell('#445',fontSize: 10,isBGColor: false),
                    _buildTableCell('1200.00',fontSize: 10,isBGColor: false),
                    _buildTableCell('800.00',fontSize: 10,isBGColor: false),
                  ],
                ),
                TableRow(
                  children: [
                    _buildTableCell('12-10-2025',fontSize: 10,isBGColor: false),
                    _buildTableCell('#445',fontSize: 10,isBGColor: false),
                    _buildTableCell('1200.00',fontSize: 10,isBGColor: false),
                    _buildTableCell('800.00',fontSize: 10,isBGColor: false),
                  ],
                ),
      
                TableRow(
                  children: [
                    _buildTableCell('12-10-2025',fontSize: 10,isBGColor: false),
                    _buildTableCell('#445',fontSize: 10,isBGColor: false),
                    _buildTableCell('1200.00',fontSize: 10,isBGColor: false),
                    _buildTableCell('800.00',fontSize: 10,isBGColor: false),
                  ],
                ),
      
                TableRow(
                  children: [
                    _buildTableCell('12-10-2025',fontSize: 10,isBGColor: false),
                    _buildTableCell('#445',fontSize: 10,isBGColor: false),
                    _buildTableCell('1200.00',fontSize: 10,isBGColor: false),
                    _buildTableCell('800.00',fontSize: 10,isBGColor: false),
                  ],
                ),
      
                TableRow(
                  children: [
                    _buildTableCell('12-10-2025',fontSize: 10,isBGColor: false),
                    _buildTableCell('#445',fontSize: 10,isBGColor: false),
                    _buildTableCell('1200.00',fontSize: 10,isBGColor: false),
                    _buildTableCell('800.00',fontSize: 10,isBGColor: false),
                  ],
                ),
              ],
            ),
    );
  }


Widget _buildTableCell(String text,{bool isBGColor = true,double fontSize =11}) {
    return TableCell(
      child: Container(
        height: 30,
        color:isBGColor? AppColors.edColor:null,
        child: Center(child: AppText(title: text,fontsize:fontSize,fontFamily: AppFontfamily.poppinsMedium,)),
      ),
    );
  }

  customBalanceContainer(String title, String subTitle){
    return Expanded(
      child: Container(
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10,offset: Offset(0, 0))
          ]
        ),
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(title: title,fontsize: 10,fontFamily: AppFontfamily.poppinsMedium,),
            const SizedBox(height: 8,),
             AppText(title: subTitle,fontsize: 16,fontFamily: AppFontfamily.poppinsSemibold,),
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
            const SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: AppText(title: "Select Date",fontFamily: AppFontfamily.poppinsSemibold,),
            ),
             Padding(
               padding: const EdgeInsets.only(left: 25,top: 15),
               child: Row(
                children: [
                  AppDateWidget(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: 8,height: 2,
                    color: AppColors.black,
                  ),
                   AppDateWidget(),
                ],
             ),
             ),
             const SizedBox(height: 70,),
             Align(
              alignment: Alignment.center,
              child: AppTextButton(title: "Apply",height: 35,width: 150,color: AppColors.arcticBreeze,),
             )
        ],
      ),
    );
  });
}

}
