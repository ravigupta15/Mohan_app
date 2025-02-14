import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/core/widget/product_items_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class SalesPatchWidget extends StatefulWidget {
  const SalesPatchWidget({super.key});

  @override
  State<SalesPatchWidget> createState() => _SalesPatchWidgetState();
}

class _SalesPatchWidgetState extends State<SalesPatchWidget> {
  int index =0;
  final selectedTabBarIndex= 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSearchBar(
          hintText: 'Search by name, phone, etc.',
          isReadOnly: true,
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(AppAssetPaths.searchIcon),
          ),
          onTap: (){
            productBottomSheet();
          },
        ),
        const SizedBox(height: 20,),
        _CustomInfoWidget(),
        const SizedBox(height: 20,),
        RemarksWidget(),
        const SizedBox(height: 20,),
        _AddedProductWidget(),
        ],
    );
  }


  tabbarWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _roundedContainer(bgColor: AppColors.greenColor,borderColor: AppColors.greenColor),
        Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: _divider(AppColors.greenColor),),
        _roundedContainer(bgColor: AppColors.black,borderColor:  AppColors.black),
        Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: _divider(AppColors.lightTextColor),),
        _roundedContainer(bgColor: AppColors.whiteColor,borderColor: AppColors.lightTextColor),
      ],
    );
  }

  _divider(Color color){
  return Container(
width: 50,color: color,height: 1,
  );
}
 _roundedContainer({required Color bgColor, required Color borderColor}){
    return Container(
      height: 16,width: 16,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: bgColor,
        shape: BoxShape.circle
      ),
    );
  }

productBottomSheet(){
  showModalBottomSheet(
    backgroundColor: AppColors.whiteColor,
    isScrollControlled: true,
    context: context, builder: (context){
      return _ProductBottomSheetWidget();
  });
}

}


class _CustomInfoWidget extends StatelessWidget {
  const _CustomInfoWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: false,
      collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false));
  }

Widget collapsedWidget({required bool isExpanded}){
  return Container(
      padding:isExpanded? EdgeInsets.symmetric(horizontal: 10,vertical: 12):EdgeInsets.zero,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(title: "Customer Information",fontFamily:AppFontfamily.poppinsSemibold,),
          Icon(!isExpanded? Icons.expand_less:Icons.expand_more,color: AppColors.light92Color,),
      ],
    ),
  );
}

Widget expandedWidget({required bool isExpanded}){
  return  Container(
       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       collapsedWidget(isExpanded: isExpanded),
            const SizedBox(height: 10,),
            itemsWidget("Vendor Name", "Ramesh"),
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
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        AppText(title: subTitle,
        fontsize: 13,
        fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
      ],
    );
  }
}

class _ProductBottomSheetWidget extends StatefulWidget {
  const _ProductBottomSheetWidget();

  @override
  State<_ProductBottomSheetWidget> createState() => __ProductBottomSheetWidgetState();
}

class __ProductBottomSheetWidgetState extends State<_ProductBottomSheetWidget> {

int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                  AppText(title: "Bread",fontsize: 16,fontFamily: AppFontfamily.poppinsSemibold,),
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
            const SizedBox(height: 25,),
            tabBar(),
            const SizedBox(height: 15,),
            headersForTabBarItems(),
            productItemsWidget(),
            const SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.edColor),
                borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical:5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(title: "3 Items Selected",fontFamily: AppFontfamily.poppinsSemibold,),
                  AppTextButton(title: "Add items",color: AppColors.arcticBreeze,height: 30,width: 100,)
                ],
              ),
            )
          ],
        ),
      );
  }

  Widget tabBar(){
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.tabBarColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          customTabBarContainer(title:'MP',index:0),
          verticalDivider(),
          customTabBarContainer(title:'BP',index:1),
          verticalDivider(),
          customTabBarContainer(title:'FP',index:2),
          verticalDivider(),
          customTabBarContainer(title:'TP',index:3),
        ],
      ),
    );
  }

  verticalDivider(){
    return Container(
      height: 30,width: 1,
      color: AppColors.edColor,
    );
  }

  customTabBarContainer({required String title, required int index}){
    return Expanded(
      child: InkWell(
        onTap: (){
          selectedIndex=index;
          setState(() {
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selectedIndex==index? AppColors.whiteColor:null,
            borderRadius: BorderRadius.circular(5),
            boxShadow:selectedIndex==index? [
              BoxShadow(
                offset: Offset(0, -2),
                blurRadius: 12,
                color: AppColors.black.withValues(alpha: .2)
              ),
            ]:[]
          ),
          child: AppText(title: title,fontFamily: AppFontfamily.poppinsSemibold,),
        ),
      ),
    );
  }


headersForTabBarItems(){
  return Container(
    // height: 30,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppColors.edColor,width: .5)
      )
    ),
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: AppText(title: "Item",fontsize: 11,color: AppColors.lightTextColor,)),
        selectedIndex==2 ? SizedBox( width: 80,):
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.symmetric(vertical: BorderSide(
              color: AppColors.e2Color
            ))
          ),
          child: AppText(title: "Competetor",fontsize: 11,color: AppColors.lightTextColor),
        ),
        Expanded(child: Center(child: AppText(title: "Quantity",fontsize: 11,color: AppColors.lightTextColor))),
       Container(
        padding: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(
              color: AppColors.e2Color
            ))
          ),
        child:  AppText(title: "Select",fontsize: 11,color: AppColors.lightTextColor),
       )
      ],
    ),
  );
}

productItemsWidget(){
return ListView.separated(
  separatorBuilder: (ctx,sb){
    return const SizedBox(height: 13,);
  },
  itemCount: 10,
  shrinkWrap: true,
  padding: EdgeInsets.only(left: 25,right: 25,top: 12),
  itemBuilder: (ctx,index){
  return Row(
    children: [
     SizedBox(
      width: 60,
      child:  AppText(title: "Item ${index+1}",fontFamily: AppFontfamily.poppinsMedium,),),
     selectedIndex==2 ? SizedBox(width: 80,):
      GestureDetector(
        onTap: (){
          selectedIndex==0 ? _variationModelBottomSheet():
          _competetorModelBottomSheet();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.edColor),
            borderRadius: BorderRadius.circular(5)
          ),
          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
          child: Row(
            children: [
              AppText(title: "Select",fontsize: 10,color: AppColors.lightTextColor,),
              const SizedBox(width: 4,),
              Icon(Icons.arrow_forward_ios,size: 10,)
            ],
          ),
        ),
      ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customContainerForAddRemove(isAdd: false),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 15,width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.greenColor)
              ),
            ),
            customContainerForAddRemove(isAdd: true),
            const SizedBox(width: 3,),
            AppText(title: "kg",fontsize: 10,)
          ],
        ),
      ),
      Container(
        width: 45,
        padding: EdgeInsets.only(),
      child: customCheckbox(),)
    ],
  );
});
}


  Widget customContainerForAddRemove({required bool isAdd}){
    return InkWell(
      onTap: (){},
      child: Container(
        height: 18,width: 18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.edColor,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Icon(isAdd? Icons.add:Icons.remove,
        size: 16,
        color: isAdd?AppColors.greenColor:AppColors.redColor,
        ),
      ),
    );
  }

  _competetorModelBottomSheet(){
    showModalBottomSheet(
      isScrollControlled: true,
       backgroundColor: AppColors.whiteColor,
      context: context, builder: (context){
      return Container(
        padding: EdgeInsets.only(top: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             headingForCompetetorAndVariation("Competetor"),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: AppSearchBar(
                hintText: "Search by name",
                suffixWidget: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(AppAssetPaths.searchIcon),
                ),
              ),
            ),
            ListView.builder(
              itemCount: 8,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 20),
              itemBuilder: (ctx,index){
                return Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.edColor))
                  ),
                  child: AppText(title: "Competetor ${index+1}",fontsize: 14,fontFamily: AppFontfamily.poppinsSemibold,),
                );
            })
          ],
        ),
      );
    });
  }

   _variationModelBottomSheet(){
    showModalBottomSheet(
      isScrollControlled: true,
       backgroundColor: AppColors.whiteColor,
      context: context, builder: (context){
      return Container(
        padding: EdgeInsets.only(top: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headingForCompetetorAndVariation("Variation"),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: AppSearchBar(
                hintText: "Search by name",
                suffixWidget: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(AppAssetPaths.searchIcon),
                ),
              ),
            ),
            ListView.builder(
              itemCount: 8,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 20),
              itemBuilder: (ctx,index){
                return Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.edColor))
                  ),
                  child: AppText(title: "Variation ${index+1}",fontsize: 14,fontFamily: AppFontfamily.poppinsSemibold,),
                );
            })
          ],
        ),
      );
    });
  }

headingForCompetetorAndVariation(String title){
  return Padding(
              padding: const EdgeInsets.only(right: 11,left: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new)),
                  AppText(title: title,fontsize: 16,fontFamily: AppFontfamily.poppinsSemibold,),
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
            );
}

}


class _AddedProductWidget extends StatelessWidget {
  const _AddedProductWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
      decoration: BoxDecoration(
        color:AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffE2E2E2)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .1),
            blurRadius: 10
          ),
        ]
      ),
      child: ExpandableWidget(
        initExpanded: true,
        collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandWidget(isExpanded: false))
    );
  }

  collapsedWidget({required bool isExpanded}){
    return Container(
         decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      alignment: Alignment.center,
      padding:isExpanded? EdgeInsets.symmetric(horizontal: 15,vertical: 12):EdgeInsets.zero,
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: "Bread",fontFamily:AppFontfamily.poppinsSemibold,),
            Icon(!isExpanded? Icons.expand_less:Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
      );
  }

  expandWidget({required bool isExpanded}){
    return Container(
         decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 20),
      child: Column(
            children: [
              collapsedWidget(isExpanded: isExpanded),
              Padding(padding: EdgeInsets.only(top: 9,bottom: 6),
          child: dotteDivierWidget(dividerColor:  AppColors.edColor,thickness: 1.6),),
          ProductItemsWidget(title: 'Item 1',),
          const SizedBox(height: 15,),
          ProductItemsWidget(title: 'Item 2',),
          const SizedBox(height: 15,),
          ProductItemsWidget(title: 'Item 3',),
            ],
          ),
      );
  }
}
