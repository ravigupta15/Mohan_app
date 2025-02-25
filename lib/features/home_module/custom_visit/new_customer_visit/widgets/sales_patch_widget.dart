import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/search/presentation/search_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/add_remove_container_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/customer_information_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';

// ignore: must_be_immutable
class SalesPatchWidget extends StatefulWidget {
  final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
   SalesPatchWidget({super.key, required this.refNotifer,required this.refState});

  @override
  State<SalesPatchWidget> createState() => _SalesPatchWidgetState();
}

class _SalesPatchWidgetState extends State<SalesPatchWidget> {
  // int index =0;
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
            AppRouter.pushCupertinoNavigation(const SearchScreen(route: 'product')).then((value){
            widget.refNotifer.productItemApiFunction(context, productItem: value).then((val){
              if(val!=null){
                productBottomSheet(context,value);
              }
            });
            });

          },
        ),
        const SizedBox(height: 20,),
        CustomerInfoWidget(
          name: widget.refNotifer.customerNameController.text,
          location: LocalSharePreference.currentAddress,
          shopName: widget.refNotifer.shopNameController.text,
          number: widget.refNotifer.numberController.text,
          contactList: widget.refState.contactNumberList,
        ),
        const SizedBox(height: 20,),
        RemarksWidget(controller: widget.refNotifer.remarksController,),
        const SizedBox(height: 20,),
        addedProductWidget(),
        ],
    );
  }

Widget addedProductWidget(){
  return ListView.builder(
    itemCount: widget.refState.selectedProductList.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (ctx,index){
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
        collapsedWidget: collapsedWidget(isExpanded: true,index:index), expandedWidget: expandWidget(isExpanded: false,index: index))
    );
  });
}

  collapsedWidget({required bool isExpanded,required int index}){
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
              AppText(title: widget.refState.selectedProductList[index].productType,fontFamily:AppFontfamily.poppinsSemibold,),
            Icon(!isExpanded? Icons.expand_less:Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
      );
  }

  expandWidget({required bool isExpanded, required int index}){
    return Container(
         decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 20),
      child: Column(
            children: [
              collapsedWidget(isExpanded: isExpanded,index: index),
              Padding(padding: EdgeInsets.only(top: 9,bottom: 6),
          child: dotteDivierWidget(dividerColor:  AppColors.edColor,thickness: 1.6),),
          ListView.separated(
            separatorBuilder: (ctx,sb){
              return const SizedBox(height: 15,);
            },
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.refState.selectedProductList[index].list.length,
            shrinkWrap: true,
            itemBuilder: (ctx,sbIndex){
              var model = widget.refState.selectedProductList[index].list[sbIndex];
              return Row(
      children: [
        Expanded(child: AppText(title: (model.name??''),)),
        customContainerForAddRemove(isAdd: false,onTap: (){
           if((model.quantity)>0){
                model.quantity = model.quantity-1;
              setState(() {
              });
              }
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AppText(title: (model.quantity).toString(),),
        ),
        customContainerForAddRemove(isAdd: true,onTap: (){
                model.quantity = model.quantity+1;
              setState(() {
              });
        }),
        const SizedBox(width: 30,),
        InkWell(
          onTap: (){
            widget.refState.selectedProductList.removeAt(index);
            if(sbIndex>0){
              widget.refState.selectedProductList.clear();
            }
            else{

            }
            setState(() {
              
            });
          },
          child: SvgPicture.asset(AppAssetPaths.deleteIcon))
      ],
    );
          }),
            ],
          ),
      );
  }


productBottomSheet(BuildContext context, String title){
  showModalBottomSheet(
    backgroundColor: AppColors.whiteColor,
    isScrollControlled: true,
    context: context, builder: (context){
      return _ProductBottomSheetWidget(refNotifer: widget.refNotifer,refState: widget.refState, title: title);
  });
}
}


class _ProductBottomSheetWidget extends StatefulWidget {
   final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
  final String title;
  const _ProductBottomSheetWidget({required this.refNotifer, required this.refState, required this.title});

  @override
  State<_ProductBottomSheetWidget> createState() => __ProductBottomSheetWidgetState();
}

class __ProductBottomSheetWidgetState extends State<_ProductBottomSheetWidget> {

int selectedProductCategoryIndex = 0;

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
                  AppText(title: widget.title,fontsize: 16,fontFamily: AppFontfamily.poppinsSemibold,),
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
            const SizedBox(height: 5,),
            productItemsWidget(),
            const SizedBox(height: 20,),
            (widget.refState.itemModel?.selectedList??[]).isEmpty?EmptyWidget():
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
                  AppText(title: "${widget.refState.itemModel?.selectedList.length} Items Selected",fontFamily: AppFontfamily.poppinsSemibold,),
                  AppTextButton(title: "Add items",color: AppColors.arcticBreeze,height: 30,width: 100,
                  onTap: (){
                    widget.refState.selectedProductList.add(
                      ProductSendModel(list: widget.refState.itemModel!.selectedList, productType: widget.title)
                    );
                    Navigator.pop(context);
                    setState(() {
                    });
                  },
                  )
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
          selectedProductCategoryIndex=index;
          setState(() {
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selectedProductCategoryIndex==index? AppColors.whiteColor:null,
            borderRadius: BorderRadius.circular(5),
            boxShadow:selectedProductCategoryIndex==index? [
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

String productCategoryTitle(int index){
  switch (index) {
    case 0:
      return "MP";
      case 1:
      return "BP";
      case 2:
      return "FP";
      case 3:
      return "TP";
    default:
    return '';
  }
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
        selectedProductCategoryIndex==2 ? SizedBox( width: 80,):
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
    return const SizedBox(height: 20,);
  },
  itemCount: (widget.refState.itemModel?.data?.length??0),
  shrinkWrap: true,
  padding: EdgeInsets.only(left: 25,right: 25,top: 12),
  itemBuilder: (ctx,index){
    var model = widget.refState.itemModel?.data?[index];
  return Row(
    children: [
     SizedBox(
      width: 60,
      child:  AppText(title: (model?.name??''),fontFamily: AppFontfamily.poppinsMedium,),),
     selectedProductCategoryIndex==2 ? SizedBox(width: 80,):
      GestureDetector(
        onTap: (){
          // selectedIndex==0 ? _variationModelBottomSheet():
          _competetorModelBottomSheet(index);
        },
        child: Container(
          width: 64,
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.edColor),
            borderRadius: BorderRadius.circular(5)
          ),
          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
          child:(model?.seletedCompetitor ?? "").isEmpty? Row(
            children: [
              AppText(title: "Select",fontsize: 10,color: AppColors.lightTextColor,),
              const SizedBox(width: 4,),
              Icon(Icons.arrow_forward_ios,size: 10,)
            ],
          ):  AppText(title: (model?.seletedCompetitor??''),fontsize: 10,color: AppColors.lightTextColor,maxLines: 1,),
        ),
      ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customContainerForAddRemove(isAdd: false,onTap: (){
              if((model?.quantity??0)>0){
                model!.quantity = model.quantity-1;
              setState(() {
              });
              }
            }),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 20,width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.greenColor)
              ),
              child: AppText(title: (model?.quantity??0)==0? '':(model?.quantity).toString(),fontsize: 13,),
            ),
            customContainerForAddRemove(isAdd: true,onTap: (){
              model!.quantity = model.quantity+1;
              setState(() {
                
              });
            }),
            const SizedBox(width: 3,),
            AppText(title: "kg",fontsize: 10,)
          ],
        ),
      ),
      Container(
        width: 45,
        padding: EdgeInsets.only(),
      child: customCheckbox(
        isCheckbox: (model?.isSelected??false),
        onChanged: (val){
          model?.isSelected=val!;
          model?.productCategory= productCategoryTitle(selectedProductCategoryIndex);
          model?.productType = widget.title;
          if((model?.isSelected??false)==false){
             for(int i=0;i<(widget.refState.itemModel?.selectedList.length??0);i++){
            if((widget.refState.itemModel?.selectedList[i].isSelected==false)){
            widget.refState.itemModel?.selectedList.removeAt(i);
          }
          }
          }
          else{
            widget.refState.itemModel?.selectedList.add(model!);
          }
          setState(() {
            
          });
        }
      ),)
    ],
  );
});
}


  _competetorModelBottomSheet(int itemIndex){
    showModalBottomSheet(
      isScrollControlled: true,
       backgroundColor: AppColors.whiteColor,
      context: context, builder: (context){
      return StatefulBuilder(
        builder: (context, state) {
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
                  itemCount: (widget.refState.competitorModel?.data?.length ??0),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 20),
                  itemBuilder: (ctx,index){
                    var model = widget.refState.competitorModel?.data?[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.pop(context,);
                        widget.refState.itemModel?.data?[itemIndex].seletedCompetitor = (model?.name??'');
                        setState(() {
                        });
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppColors.edColor))
                        ),
                        child: AppText(title: (model?.name ?? ''),fontsize: 14,fontFamily: AppFontfamily.poppinsSemibold,),
                      ),
                    );
                })
              ],
            ),
          );
        }
      );
    });
  }

  //  _variationModelBottomSheet(){
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //      backgroundColor: AppColors.whiteColor,
  //     context: context, builder: (context){
  //     return Container(
  //       padding: EdgeInsets.only(top: 14),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           headingForCompetetorAndVariation("Variation"),
  //           const SizedBox(height: 15,),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 25),
  //             child: AppSearchBar(
  //               hintText: "Search by name",
  //               suffixWidget: Padding(
  //                 padding: const EdgeInsets.only(right: 10),
  //                 child: SvgPicture.asset(AppAssetPaths.searchIcon),
  //               ),
  //             ),
  //           ),
  //           ListView.builder(
  //             itemCount: 8,
  //             shrinkWrap: true,
  //             padding: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 20),
  //             itemBuilder: (ctx,index){
  //               return Container(
  //                 height: 40,
  //                 alignment: Alignment.centerLeft,
  //                 decoration: BoxDecoration(
  //                   border: Border(bottom: BorderSide(color: AppColors.edColor))
  //                 ),
  //                 child: AppText(title: "Variation ${index+1}",fontsize: 14,fontFamily: AppFontfamily.poppinsSemibold,),
  //               );
  //           })
  //         ],
  //       ),
  //     );
  //   });
  // }

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


