import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/add_remove_container_widget.dart';
import 'package:mohan_impex/features/home_module/search/presentation/search_screen.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/item_template_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_notifier.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';

class ItemSelectionWidget extends ConsumerStatefulWidget {
  const ItemSelectionWidget({super.key});

  @override
  ConsumerState<ItemSelectionWidget> createState() => _ItemSelectionWidgetState();
}

class _ItemSelectionWidgetState extends ConsumerState<ItemSelectionWidget> {
  @override
  Widget build(BuildContext context) {
      final refNotifier = ref.read(addSalesOrderProvider.notifier);
    final refState = ref.watch(addSalesOrderProvider);
  
    return Column(
      children: [
         AppSearchBar(
          hintText: 'Search item',
          isReadOnly: true,
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(AppAssetPaths.searchIcon),
          ),
          onTap: (){
            refState.itemVariantModel = null;
            AppRouter.pushCupertinoNavigation(const SearchScreen(route: 'itemTemplateSalesOrder')).then((value){
              if((value??'').isNotEmpty){
                 refNotifier.itemsVariantApiFunction(context,searchText: value, itemCategory: 'MP').then((val){
              if(val!=null){
                refState.itemVariantModel = ItemTemplateModel.fromJson(val);
               refNotifier.selectedProductCategoryIndex = 0;
                productBottomSheet(context,value,refNotifier, refState);
              }
              setState(() {
                
              });
            });
           
              }
            });

          },
        ),
        const SizedBox(height: 20,),
        _CustomerInfoWidget(
          refNotifier: refNotifier,
          refState: refState,
        ),
        const SizedBox(height: 20,),
        addedProductWidget(refNotifier: refNotifier, refState: refState),
       
      ],
    );
  }

Widget addedProductWidget({required AddSalesOrderNotifier refNotifier,required AddSalesOrderState refState}){
  return ListView.builder(
    itemCount: refState.selectedProductList.length,
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
        collapsedWidget: collapsedWidget(isExpanded: true,index:index,refNotifier: refNotifier,refState: refState), expandedWidget: expandWidget(isExpanded: false,index: index, refNotifier: refNotifier,refState: refState))
    );
  });
}

  collapsedWidget({required bool isExpanded,required int index,required AddSalesOrderNotifier refNotifier,required AddSalesOrderState refState}){
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
              AppText(title: refState.selectedProductList[index].itemTemplate,fontFamily:AppFontfamily.poppinsSemibold,),
            Icon(!isExpanded? Icons.expand_less:Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
      );
  }

  expandWidget({required bool isExpanded, required int index,required AddSalesOrderNotifier refNotifier,required AddSalesOrderState refState}){
    return Container(
         decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 20),
      child: Column(
            children: [
              collapsedWidget(isExpanded: isExpanded,index: index,refNotifier: refNotifier,refState: refState),
              Padding(padding: EdgeInsets.only(top: 9,bottom: 6),
          child: dotteDivierWidget(dividerColor:  AppColors.edColor,thickness: 1.6),),
          ListView.separated(
            separatorBuilder: (ctx,sb){
              return const SizedBox(height: 15,);
            },
            physics: const NeverScrollableScrollPhysics(),
            itemCount: refState.selectedProductList[index].list.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 15),
            itemBuilder: (ctx,sbIndex){
              var model = refState.selectedProductList[index].list[sbIndex];
              return Row(
      children: [
        Expanded(child: AppText(title: (model.itemName??''),maxLines: 2,)),
        model.seletedCompetitor.isEmpty? EmptyWidget():
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: AppText(title: model.seletedCompetitor,maxLines: 2,),
        )),
        const SizedBox(width: 10,),
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
        const SizedBox(width: 15,),
        InkWell(
          onTap: (){
            if(refState.selectedProductList[index].list.length>1){
              refState.selectedProductList[index].list.removeAt(sbIndex);
            }
            else{
              refState.selectedProductList.removeAt(index);
            }
            
            setState(() {
              
            });
          },
          child: Container(
            width: 20,
            height: 30,
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssetPaths.deleteIcon)))
      ],
    );
          }),
            ],
          ),
      );
  }


productBottomSheet(BuildContext context, String title, AddSalesOrderNotifier refNotifier, AddSalesOrderState refState){
  showModalBottomSheet(
    backgroundColor: AppColors.whiteColor,
    isScrollControlled: true,
    context: context, builder: (context){
      return _productBottomSheetWidget(refNotifier, refState,  title);
  });
}

_productBottomSheetWidget( AddSalesOrderNotifier refNotifier, AddSalesOrderState refState, String title){
  return  StatefulBuilder(
    builder: (context,state) {
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
                      AppText(title: title,fontsize: 16,fontFamily: AppFontfamily.poppinsSemibold,),
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
                tabBar(state,productTitle: title,refNotifer: refNotifier,refState: refState),
                const SizedBox(height: 15,),
                headersForTabBarItems(refNotifier),
                const SizedBox(height: 5,),
                productItemsWidget(refNotifier: refNotifier,refState: refState,title: title,stateful: state),
                const SizedBox(height: 20,),
                (refState.itemVariantModel?.selectedList??[]).isEmpty?EmptyWidget():
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
                      AppText(title: "${refState.itemVariantModel?.selectedList.length} Items Selected",fontFamily: AppFontfamily.poppinsSemibold,),
                      AppTextButton(title: "Add items",color: AppColors.arcticBreeze,height: 30,width: 100,
                      onTap: (){
                        final existingProductIndex =
                                refState.selectedProductList.indexWhere(
                              (e) => e.itemTemplate == title,
                            );
                             if (existingProductIndex != -1) {
                              refState.selectedProductList[
                                  existingProductIndex] = SalesItemVariantSendModel(list: refState.itemVariantModel!.selectedList, itemTemplate: title);
                            }
                            else{
                        refState.selectedProductList.add(
                          SalesItemVariantSendModel(list: refState.itemVariantModel!.selectedList, itemTemplate: title)
                        );
                            }
                        state((){});
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
  );
  
}


  Widget tabBar(state,
    { required AddSalesOrderNotifier refNotifer, required AddSalesOrderState refState,
  required String productTitle,}
    ){
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.tabBarColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          customTabBarContainer(title:'MP',index:0,
          refNotifer: refNotifer,refState: refState,
          productTitle: productTitle,
          state: state),
          verticalDivider(),
          customTabBarContainer(title:'BP',index:1,refNotifer: refNotifer,refState: refState,
          productTitle: productTitle,state: state),
          verticalDivider(),
          customTabBarContainer(title:'FP',index:2,refNotifer: refNotifer,refState: refState,
          productTitle: productTitle,state: state),
          verticalDivider(),
          customTabBarContainer(title:'TP',index:3,refNotifer: refNotifer,refState: refState,
          productTitle: productTitle,state: state),
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

  customTabBarContainer({required String title, required int index,
  required AddSalesOrderNotifier refNotifer, required AddSalesOrderState refState,
  required String productTitle,
   state}){
    return Expanded(
      child: InkWell(
        onTap: (){
         refNotifer.selectedProductCategoryIndex=index;
         refState.itemVariantModel = null;
          refNotifer.itemsVariantApiFunction(context, searchText: productTitle,itemCategory: title).then((val){
              if(val!=null){
                refState.itemVariantModel = ItemTemplateModel.fromJson(val);
            state((){});
              setState(() {
                
              });
              }
            });
            state((){});
              setState(() {
                
              });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: refNotifer.selectedProductCategoryIndex==index? AppColors.whiteColor:null,
            borderRadius: BorderRadius.circular(5),
            boxShadow:refNotifer.selectedProductCategoryIndex==index? [
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

headersForTabBarItems(AddSalesOrderNotifier refNotifier){
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
           Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          vertical: BorderSide(color: AppColors.e2Color))),
                  child: AppText(
                      title: "Competetor",
                      fontsize: 11,
                      color: AppColors.lightTextColor),
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

productItemsWidget({required AddSalesOrderNotifier refNotifier, required AddSalesOrderState refState, required String title,var stateful}){
return ListView.separated(
  separatorBuilder: (ctx,sb){
    return const SizedBox(height: 20,);
  },
  itemCount: (refState.itemVariantModel?.data?.length??0),
  shrinkWrap: true,
  padding: EdgeInsets.only(left: 25,right: 25,top: 12),
  itemBuilder: (ctx,index){
    var model = refState.itemVariantModel?.data?[index];
  return Row(
    children: [
     SizedBox(
      width: 60,
      child:  AppText(title: (model?.itemName??''),fontFamily: AppFontfamily.poppinsMedium,maxLines: 2,),),
      GestureDetector(
                      onTap: () {
                        _competetorModelBottomSheet(
                            index, refState, refNotifier,(model?.competitors ?? []), stateful);
                      },
                      child: Container(
                        width: 64,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.edColor),
                            borderRadius: BorderRadius.circular(5)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: (model?.seletedCompetitor ?? "").isEmpty
                            ? Row(
                                children: [
                                  AppText(
                                    title: "Select",
                                    fontsize: 10,
                                    color: AppColors.lightTextColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                  )
                                ],
                              )
                            : AppText(
                                title: (model?.seletedCompetitor ?? ''),
                                fontsize: 10,
                                color: AppColors.lightTextColor,
                                maxLines: 1,
                              ),
                      ),
                    ),
    //  refNotifier.selectedProductCategoryIndex==2 ? SizedBox(width: 80,):
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customContainerForAddRemove(isAdd: false,onTap: (){
              if((model?.quantity??0)>0){
                model!.quantity = model.quantity-1;
                stateful((){});
              setState(() {
              });
              }
            }),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 18,width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.greenColor)
              ),
              child: AppText(title: (model?.quantity??0)==0? '':(model?.quantity).toString(),fontsize: 13,),
            ),
            customContainerForAddRemove(isAdd: true,onTap: (){
              model!.quantity = model.quantity+1;
               stateful((){});
              setState(() {
                
              });
            }),
            const SizedBox(width: 5,),
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
          model?.itemCategory= productCategoryTitle(refNotifier.selectedProductCategoryIndex);
          model?.itemTempate = title;
          if((model?.isSelected??false)==false){
             for(int i=0;i<(refState.itemVariantModel?.selectedList.length??0);i++){
            if((refState.itemVariantModel?.selectedList[i].isSelected==false)){
            refState.itemVariantModel?.selectedList.removeAt(i);
          }
          }
          }
          else{
            refState.itemVariantModel?.selectedList.add(model!);
          }
           stateful((){});
          setState(() {
            
          });
        }
      ),)
    ],
  );
});
}


  _competetorModelBottomSheet(int itemIndex, AddSalesOrderState refState,
      AddSalesOrderNotifier refNotifier, List competitiorList, statefull) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors.whiteColor,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return competitiorList.isEmpty ?
            Container(
              height: 200,alignment: Alignment.center,
              child: NoDataFound(title: "No competetor found"),
            ) :
             Container(
              padding: EdgeInsets.only(
                  top: 14, bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  headingForCompetetorAndVariation("Competetor"),
                  const SizedBox(
                    height: 30,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25),
                  //   child: AppSearchBar(
                  //     hintText: "Search by name",
                  //     suffixWidget: Padding(
                  //       padding: const EdgeInsets.only(right: 10),
                  //       child: SvgPicture.asset(AppAssetPaths.searchIcon),
                  //     ),
                  //     onChanged: (val) {
                  //       // refNotifier.competitorApiFunction(context);
                  //     },
                  //   ),
                  // ),
                  ListView.builder(
                      itemCount: competitiorList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 10, bottom: 20),
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            refState.itemVariantModel?.data?[itemIndex]
                                .seletedCompetitor = (competitiorList[index] ?? '');
                            Navigator.pop(
                              context,
                            );
                            statefull(() {});
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: AppColors.edColor))),
                            child: AppText(
                              title: competitiorList[index],
                              fontsize: 14,
                              fontFamily: AppFontfamily.poppinsSemibold,
                            ),
                          ),
                        );
                      })
                ],
              ),
            );
          });
        });
  }


  headingForCompetetorAndVariation(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 11, left: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new)),
          AppText(
            title: title,
            fontsize: 16,
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.edColor, shape: BoxShape.circle),
              child: Icon(
                Icons.close,
                size: 19,
              ),
            ),
          )
        ],
      ),
    );
  }

}
// ignore: must_be_immutable
class _CustomerInfoWidget extends StatelessWidget {
  AddSalesOrderNotifier refNotifier;
  AddSalesOrderState refState;
   _CustomerInfoWidget({
    required this.refNotifier,
    required this.refState
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
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
            itemsWidget("Vendor Name", refNotifier.customerNameController.text),
            const SizedBox(height: 10,),
            itemsWidget("Shop Name", refNotifier.shopNameController.text),
             refState.selectedVisitType == 1?
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: itemsWidget("Channel Parnter", refNotifier.channelPartnerController.text),
            ) : EmptyWidget(),
            const SizedBox(height: 10,),
            itemsWidget("Contact", (refState.contactNumberList).isEmpty ? refNotifier.numberController.text :
            refState.contactNumberList.join(', '),
            ),
            const SizedBox(height: 10,),
            itemsWidget("Delivery Date", refNotifier.deliveryDateController.text),
        ],
      ),
    );
}


  Widget itemsWidget(String title, String subTitle){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        Expanded(
          child: AppText(title: subTitle,
          fontsize: 13,
          fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
        ),
      ],
    );
  }


}
