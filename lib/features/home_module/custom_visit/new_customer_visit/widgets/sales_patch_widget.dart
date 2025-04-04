import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/product_item_model.dart';
import 'package:mohan_impex/features/home_module/search/presentation/search_screen.dart';
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
class SalesPatchWidget extends ConsumerStatefulWidget {
  // final NewCustomerVisitNotifier refNotifer;
  // final NewCustomerVisitState refState;
  SalesPatchWidget({
    super.key,
  });

  @override
  ConsumerState<SalesPatchWidget> createState() => _SalesPatchWidgetState();
}

class _SalesPatchWidgetState extends ConsumerState<SalesPatchWidget> {
  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(newCustomVisitProvider.notifier);
    final refState = ref.watch(newCustomVisitProvider);
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
          onTap: () {
            refState.productItemModel = null;
            AppRouter.pushCupertinoNavigation(
                    const SearchScreen(route: 'product'))
                .then((value) {
              if ((value ?? '').isNotEmpty) {
                refNotifier
                    .productItemApiFunction(context, productTitle: value)
                    .then((val) {
                  if (val != null) {
                    refState.productItemModel = ProductItemModel.fromJson(val);
                    refNotifier.selectedProductCategoryIndex = 0;
                    productBottomSheet(context, value, refNotifier, refState);
                  }
                  setState(() {});
                });
              }
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomerVisitInfoWidget(
          refNotifier: refNotifier,
          refState: refState,
        ),
        const SizedBox(
          height: 20,
        ),
        RemarksWidget(
          controller: refNotifier.remarksController,
        ),
        const SizedBox(
          height: 20,
        ),
        addedProductWidget(refNotifier: refNotifier, refState: refState),
      ],
    );
  }

  Widget addedProductWidget(
      {required NewCustomerVisitNotifier refNotifier,
      required NewCustomerVisitState refState}) {
    return ListView.separated(
      separatorBuilder: (ctx, sb){
        return const SizedBox(height: 15,);
      },
        itemCount: refState.selectedProductList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                  color: AppColors.itemsBG,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xffE2E2E2)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        color: AppColors.black.withValues(alpha: .1),
                        blurRadius: 10),
                  ]),
              child: ExpandableWidget(
                  initExpanded: true,
                  collapsedWidget: collapsedWidget(
                      isExpanded: true,
                      index: index,
                      refNotifier: refNotifier,
                      refState: refState),
                  expandedWidget: expandWidget(
                      isExpanded: false,
                      index: index,
                      refNotifier: refNotifier,
                      refState: refState)));
        });
  }

  collapsedWidget(
      {required bool isExpanded,
      required int index,
      required NewCustomerVisitNotifier refNotifier,
      required NewCustomerVisitState refState}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      alignment: Alignment.center,
      padding: isExpanded
          ? EdgeInsets.symmetric(horizontal: 15, vertical: 12)
          : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: refState.selectedProductList[index].productType,
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
          Icon(
            !isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.light92Color,
          ),
        ],
      ),
    );
  }

  expandWidget(
      {required bool isExpanded,
      required int index,
      required NewCustomerVisitNotifier refNotifier,
      required NewCustomerVisitState refState}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 20),
      child: Column(
        children: [
          collapsedWidget(
              isExpanded: isExpanded,
              index: index,
              refNotifier: refNotifier,
              refState: refState),
          Padding(
            padding: EdgeInsets.only(top: 9, bottom: 6),
            child: dotteDivierWidget(
                dividerColor: AppColors.edColor, thickness: 1.6),
          ),
          ListView.separated(
              separatorBuilder: (ctx, sb) {
                return const SizedBox(
                  height: 15,
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: refState.selectedProductList[index].list.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 15),
              itemBuilder: (ctx, sbIndex) {
                var model = refState.selectedProductList[index].list[sbIndex];
                return Row(
                  children: [
                    Expanded(
                        child: AppText(
                      title: (model.name ?? ''),
                    )),
                    customContainerForAddRemove(
                        isAdd: false,
                        onTap: () {
                          if ((model.quantity) > 0) {
                            model.quantity = model.quantity - 1;
                            setState(() {});
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AppText(
                        title: (model.quantity).toString(),
                      ),
                    ),
                    customContainerForAddRemove(
                        isAdd: true,
                        onTap: () {
                          model.quantity = model.quantity + 1;
                          setState(() {});
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          if (refState.selectedProductList[index].list.length >
                              1) {
                            refState.selectedProductList[index].list
                                .removeAt(sbIndex);
                          } else {
                            refState.selectedProductList.removeAt(index);
                          }

                          setState(() {});
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

  productBottomSheet(BuildContext context, String title,
      NewCustomerVisitNotifier refNotifier, NewCustomerVisitState refState) {
    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return _productBottomSheetWidget(refNotifier, refState, title);
        });
  }

  _productBottomSheetWidget(NewCustomerVisitNotifier refNotifier,
      NewCustomerVisitState refState, String title) {
    return StatefulBuilder(builder: (context, state) {
      return Container(
        padding: EdgeInsets.only(top: 14, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 11),
              child: Row(
                children: [
                  const Spacer(),
                  AppText(
                    title: title,
                    fontsize: 16,
                    fontFamily: AppFontfamily.poppinsSemibold,
                  ),
                  const Spacer(),
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
            ),
            const SizedBox(
              height: 25,
            ),
            tabBar(state,
                productTitle: title,
                refNotifer: refNotifier,
                refState: refState),
            const SizedBox(
              height: 15,
            ),
            headersForTabBarItems(refNotifier),
            const SizedBox(
              height: 5,
            ),
            productItemsWidget(
                refNotifier: refNotifier,
                refState: refState,
                title: title,
                stateful: state),
            const SizedBox(
              height: 20,
            ),
            (refState.productItemModel?.selectedList ?? []).isEmpty
                ? EmptyWidget()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.edColor),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          title:
                              "${refState.productItemModel?.selectedList.length} Items Selected",
                          fontFamily: AppFontfamily.poppinsSemibold,
                        ),
                        AppTextButton(
                          title: "Add items",
                          color: AppColors.arcticBreeze,
                          height: 30,
                          width: 100,
                          onTap: () {
                            final existingProductIndex =
                                refState.selectedProductList.indexWhere(
                              (e) => e.productType == title,
                            );

                            if (existingProductIndex != -1) {
                              var product = refState
                                  .selectedProductList[existingProductIndex];
                              for (var newItem
                                  in refState.productItemModel!.selectedList) {
                                int existingItemIndex =
                                    product.list.indexWhere((e) {
                                  if (e.itemCode == null ||
                                      newItem.itemCode == null) {
                                    return false; // Don't match if either itemCode is null
                                  }

                                  return e.itemCode.toString().trim() ==
                                      newItem.itemCode.toString().trim();
                                });

                                if (existingItemIndex != -1) {
                                  var existingItem =
                                      product.list[existingItemIndex];
                                  existingItem.quantity += newItem.quantity;

                                } else {
                                  product.list.add(newItem);
                                }
                              }
                            } else {
                              refState.selectedProductList.add(
                                ProductSendModel(
                                  list: refState.productItemModel!.selectedList,
                                  productType: title,
                                ),
                              );
                            }

                            // final existingProductIndex =
                            //     refState.selectedProductList.indexWhere(
                            //   (e) => e.productType == title,
                            // );
                            // if (existingProductIndex != -1) {
                            //   refState.selectedProductList[
                            //       existingProductIndex] = ProductSendModel(
                            //     list: refState.productItemModel!.selectedList,
                            //     productType: title,
                            //   );
                            // } else {
                            //   refState.selectedProductList.add(
                            //     ProductSendModel(
                            //       list: refState.productItemModel!.selectedList,
                            //       productType: title,
                            //     ),
                            //   );
                            // }
                            state(() {});
                            Navigator.pop(context);
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  )
          ],
        ),
      );
    });
  }

  Widget tabBar(
    state, {
    required NewCustomerVisitNotifier refNotifer,
    required NewCustomerVisitState refState,
    required String productTitle,
  }) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.tabBarColor, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          customTabBarContainer(
              title: 'MP',
              index: 0,
              refNotifer: refNotifer,
              refState: refState,
              productTitle: productTitle,
              state: state),
          verticalDivider(),
          customTabBarContainer(
              title: 'BP',
              index: 1,
              refNotifer: refNotifer,
              refState: refState,
              productTitle: productTitle,
              state: state),
          verticalDivider(),
          customTabBarContainer(
              title: 'FP',
              index: 2,
              refNotifer: refNotifer,
              refState: refState,
              productTitle: productTitle,
              state: state),
          verticalDivider(),
          customTabBarContainer(
              title: 'TP',
              index: 3,
              refNotifer: refNotifer,
              refState: refState,
              productTitle: productTitle,
              state: state),
        ],
      ),
    );
  }

  verticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.edColor,
    );
  }

  customTabBarContainer(
      {required String title,
      required int index,
      required NewCustomerVisitNotifier refNotifer,
      required NewCustomerVisitState refState,
      required String productTitle,
      state}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          refNotifer.selectedProductCategoryIndex = index;
          refState.productItemModel = null;
          refNotifer
              .productItemApiFunction(context, productTitle: productTitle,itemCategory: title)
              .then((val) {
            if (val != null) {
              refState.productItemModel = ProductItemModel.fromJson(val);
              state(() {});
            }
            setState(() {});
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: refNotifer.selectedProductCategoryIndex == index
                  ? AppColors.whiteColor
                  : null,
              borderRadius: BorderRadius.circular(5),
              boxShadow: refNotifer.selectedProductCategoryIndex == index
                  ? [
                      BoxShadow(
                          offset: Offset(0, -2),
                          blurRadius: 12,
                          color: AppColors.black.withValues(alpha: .2)),
                    ]
                  : []),
          child: AppText(
            title: title,
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
        ),
      ),
    );
  }

  String productCategoryTitle(int index) {
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

  headersForTabBarItems(NewCustomerVisitNotifier refNotifier) {
    return Container(
      // height: 30,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: AppColors.edColor, width: .5))),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
              width: 60,
              child: AppText(
                title: "Item",
                fontsize: 11,
                color: AppColors.lightTextColor,
              )),
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
          Expanded(
              child: Center(
                  child: AppText(
                      title: "Quantity",
                      fontsize: 11,
                      color: AppColors.lightTextColor))),
          Container(
            padding: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                border: Border(left: BorderSide(color: AppColors.e2Color))),
            child: AppText(
                title: "Select", fontsize: 11, color: AppColors.lightTextColor),
          )
        ],
      ),
    );
  }

  productItemsWidget(
      {required NewCustomerVisitNotifier refNotifier,
      required NewCustomerVisitState refState,
      required String title,
      var stateful}) {
    return ListView.separated(
        separatorBuilder: (ctx, sb) {
          return const SizedBox(
            height: 20,
          );
        },
        itemCount: (refState.productItemModel?.data?.length ?? 0),
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 25, right: 25, top: 12),
        itemBuilder: (ctx, index) {
          var model = refState.productItemModel?.data?[index];
          return Row(
            children: [
              SizedBox(
                width: 60,
                child: AppText(
                  title: (model?.name ?? ''),
                  fontFamily: AppFontfamily.poppinsMedium,
                ),
              ),
               GestureDetector(
                      onTap: () {
                        _competetorModelBottomSheet(
                            index, refState, refNotifier, stateful);
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customContainerForAddRemove(
                        isAdd: false,
                        onTap: () {
                          if ((model?.quantity ?? 0) > 0) {
                            model!.quantity = model.quantity - 1;
                            stateful(() {});
                            setState(() {});
                          }
                        }),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 20,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.greenColor)),
                      child: AppText(
                        title: (model?.quantity ?? 0) == 0
                            ? ''
                            : (model?.quantity).toString(),
                        fontsize: 13,
                      ),
                    ),
                    customContainerForAddRemove(
                        isAdd: true,
                        onTap: () {
                          model!.quantity = model.quantity + 1;
                          stateful(() {});
                          setState(() {});
                        }),
                    const SizedBox(
                      width: 3,
                    ),
                    AppText(
                      title: model?.uom??'',
                      fontsize: 10,
                    )
                  ],
                ),
              ),
              Container(
                width: 45,
                padding: EdgeInsets.only(),
                child: customCheckbox(
                    isCheckbox: (model?.isSelected ?? false),
                    onChanged: (val) {
                      model?.isSelected = val!;
                      model?.productCategory = productCategoryTitle(
                          refNotifier.selectedProductCategoryIndex);
                      model?.productType = title;
                      if ((model?.isSelected ?? false) == false) {
                        for (int i = 0;
                            i <
                                (refState.productItemModel?.selectedList
                                        .length ??
                                    0);
                            i++) {
                          if ((refState.productItemModel?.selectedList[i]
                                  .isSelected ==
                              false)) {
                            refState.productItemModel?.selectedList.removeAt(i);
                          }
                        }
                      } else {
                        refState.productItemModel?.selectedList.add(model!);
                      }
                      stateful(() {});
                      setState(() {});
                    }),
              )
            ],
          );
        });
  }

  _competetorModelBottomSheet(int itemIndex, NewCustomerVisitState refState,
      NewCustomerVisitNotifier refNotifier, statefull) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors.whiteColor,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(
                  top: 14, bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  headingForCompetetorAndVariation("Competetor"),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: AppSearchBar(
                      hintText: "Search by name",
                      suffixWidget: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(AppAssetPaths.searchIcon),
                      ),
                      onChanged: (val) {
                        refNotifier.competitorApiFunction(context, val);
                      },
                    ),
                  ),
                  ListView.builder(
                      itemCount: (refState.competitorModel?.data?.length ?? 0),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 10, bottom: 20),
                      itemBuilder: (ctx, index) {
                        var model = refState.competitorModel?.data?[index];
                        return GestureDetector(
                          onTap: () {
                            refState.productItemModel?.data?[itemIndex]
                                .seletedCompetitor = (model?.name ?? '');
                            Navigator.pop(
                              context,
                            );
                            statefull(() {});
                            setState(() {});
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: AppColors.edColor))),
                            child: AppText(
                              title: (model?.name ?? ''),
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
