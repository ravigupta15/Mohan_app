// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/add_remove_container_widget.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_notifier.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_state.dart';
import 'package:mohan_impex/features/home_module/seles_order/widget/add_sales_order_customer_info_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import '../../../../core/widget/app_text.dart';
import '../../../../core/widget/app_text_field/app_textfield.dart';

class SalesOverviewWidget extends StatefulWidget {
  final AddSalesOrderNotifier refNotifer;
  final AddSalesOrderState refState;
  const SalesOverviewWidget(
      {super.key, required this.refNotifer, required this.refState});

  @override
  State<SalesOverviewWidget> createState() => _SalesOverviewWidgetState();
}

class _SalesOverviewWidgetState extends State<SalesOverviewWidget> {
  DateTime? selectedDate;

  double _sliderValue = 0.0;

  double thumbRadius = 20;

  
  double getSliderValue(double value){
     if (value == 0.1) {
    return 1;  // Maps to range [0, 1]
  } else if (value == 2) {
    return 0.3;  // Maps to range [0.1, 0.3]
  } else if (value == 3) {
    return 0.5;  // Maps to range [0.3, 0.5]
  } else if (value == 4) {
    return 0.7;  // Maps to range [0.5, 0.7]
  } else if (value == 5) {
    return 0.87;  // Maps to range [0.7, 1]
  } else {
    return 0;  // Fallback value, should not be reached if slider values are restricted
  }
  }


  @override
  void initState() {
    _sliderValue =
        getSliderValue(double.parse(widget.refState.dealTypeValue.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addedProductWidget(
            refNotifier: widget.refNotifer, refState: widget.refState),
        const SizedBox(
          height: 15,
        ),
        _additionalDetail(),
        const SizedBox(
          height: 15,
        ),
        CustomInfoWidget(
          refNotifier: widget.refNotifer,
          refState: widget.refState,
        ),
        //  const SizedBox(height: 15,),
        //  _CouponCodeWidget()
      ],
    );
  }

  Widget addedProductWidget(
      {required AddSalesOrderNotifier refNotifier,
      required AddSalesOrderState refState}) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  decoration: BoxDecoration(
                    color: AppColors.itemsBG,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffE2E2E2)),
                  ),
                 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title: 'Added Items',
            fontsize: 14,
            color: AppColors.black,
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.separated(
              separatorBuilder: (ctx, sb) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: refState.selectedProductList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                return ExpandableWidget(
                    initExpanded: true,
                    collapsedWidget: productCollapsedWidget(
                        isExpanded: true,
                        index: index,
                        refNotifier: refNotifier,
                        refState: refState),
                    expandedWidget: productExpandexpandWidget(
                        isExpanded: false,
                        index: index,
                        refNotifier: refNotifier,
                        refState: refState));
              }),
        ],
      ),
    );
  }

  productCollapsedWidget(
      {required bool isExpanded,
      required int index,
      required AddSalesOrderNotifier refNotifier,
      required AddSalesOrderState refState}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      padding: isExpanded
          ? EdgeInsets.symmetric(horizontal: 15, vertical: 12)
          : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: refState.selectedProductList[index].itemTemplate,
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

  productExpandexpandWidget(
      {required bool isExpanded,
      required int index,
      required AddSalesOrderNotifier refNotifier,
      required AddSalesOrderState refState}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 20),
      child: Column(
        children: [
          productCollapsedWidget(
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
                      title: (model.itemName ?? ''),
                      maxLines: 2,
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    customContainerForAddRemove(
                        isAdd: false,
                        onTap: () {
                          if ((model.quantity) > 0) {
                            model.quantity = model.quantity - 1;
                            setState(() {});
                          }
                        }),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 20,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.greenColor)),
                      child: AppText(
                        title: model.quantity == 0
                            ? ''
                            : (model.quantity).toString(),
                      ),
                    ),
                    customContainerForAddRemove(
                        isAdd: true,
                        onTap: () {
                          model.quantity = model.quantity + 1;
                          setState(() {});
                        }),
                    const SizedBox(
                      width: 15,
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

  _additionalDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: "Additional Details",
          fontFamily: AppFontfamily.poppinsSemibold,
        ),
        const SizedBox(
          height: 14,
        ),
        _dealTypeWidget(),
        const SizedBox(
          height: 14,
        ),
      ],
    );
  }

  _dealTypeWidget() {
    return ExpandableWidget(
        initExpanded: true,
        collapsedWidget: collapsedWidget(isExpanded: true),
        expandedWidget: expandedWidget(isExpanded: false));
  }

  collapsedWidget({required bool isExpanded}) {
    return Container(
      padding: !isExpanded
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(TextSpan(
              text: "Deal Type",
              style: TextStyle(
                  fontFamily: AppFontfamily.poppinsSemibold,
                  color: AppColors.black1),
              children: [
                TextSpan(
                    text: "*",
                    style: TextStyle(
                        color: AppColors.redColor,
                        fontFamily: AppFontfamily.poppinsSemibold))
              ])),
          Icon(
            !isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.light92Color,
          ),
        ],
      ),
    );
  }

  expandedWidget({required bool isExpanded}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(
            height: 15,
          ),
          customSlider()
        ],
      ),
    );
  }

  customSlider() {
    double screenWidth = MediaQuery.of(context).size.width;
    double sliderWidth = screenWidth * 0.85;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                double newPosition = details.localPosition.dx;
                if (newPosition < 0) newPosition = 0;
                if (newPosition > sliderWidth - thumbRadius * 2) {
                  newPosition = sliderWidth - thumbRadius * 2;
                }
                _sliderValue = newPosition / sliderWidth;
                widget.refState.dealTypeValue = getSnappedValue(_sliderValue);
              });
            },
            child: Container(
              width: sliderWidth,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.yellow, Colors.green],
                  stops: [0.0, 0.5, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: _sliderValue * sliderWidth - thumbRadius * .3,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: thumbRadius * 2,
                      height: thumbRadius * 2,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          // width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                title: "Low",
                fontsize: 12,
              ),
              AppText(
                title: "Medium",
                fontsize: 12,
              ),
              AppText(
                title: "High",
                fontsize: 12,
              ),
            ],
          ),
        )
      ],
    );
  }

  String getSliderState(double value) {
    if (value <= 0.33) {
      return "Low";
    } else if (value <= 0.66) {
      return "Medium";
    } else {
      return "High";
    }
  }

  int getSnappedValue(double value) {
    if (value <= 0.1) {
      return 1;
    } else if (value <= 0.3) {
      return 2;
    } else if (value <= 0.5) {
      return 3;
    } else if (value <= 0.7) {
      return 4;
    } else {
      return 5;
    }
  }
}

class _ActivityWidget extends StatelessWidget {
  const _ActivityWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withValues(alpha: .2),
                blurRadius: 10)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: 'Activity',
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
          Icon(
            Icons.expand_less,
            color: AppColors.light92Color,
          ),
        ],
      ),
    );
  }
}

class _CouponCodeWidget extends StatelessWidget {
  const _CouponCodeWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
        collapsedWidget: collapsedWidget(isExpanded: true),
        expandedWidget: expandWidget(isExpanded: false));
  }

  Widget collapsedWidget({required bool isExpanded}) {
    return Container(
      padding: isExpanded
          ? EdgeInsets.symmetric(horizontal: 10, vertical: 12)
          : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: "Coupon Codes",
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

  Widget expandWidget({required bool isExpanded}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        border: Border.all(color: Color(0xffE2E2E2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(
            height: 8,
          ),
          AppTextfield(
            fillColor: false,
            suffixWidget: Container(
              decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Icon(
                Icons.arrow_forward,
                color: AppColors.whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
