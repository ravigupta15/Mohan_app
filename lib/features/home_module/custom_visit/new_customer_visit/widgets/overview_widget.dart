import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/capture_image_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/add_remove_container_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/customer_information_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/presentation/add_trial_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class OverviewWidget extends StatefulWidget {
  final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
  OverviewWidget({super.key, required this.refNotifer, required this.refState});

  @override
  State<OverviewWidget> createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
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
    _sliderValue = getSliderValue(double.parse(widget.refState.dealTypeValue.toString()));
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
        additionalDetailsWidget(),
        const SizedBox(
          height: 15,
        ),
        _CaptureImage(
          refNotifer: widget.refNotifer,
          refState: widget.refState,
        ),
        const SizedBox(
          height: 15,
        ),
        RemarksWidget(
          isEditable: false,
          remarks: widget.refNotifer.remarksController.text,
          isRequired: true,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomerVisitInfoWidget(
          refNotifier: widget.refNotifer,
          refState: widget.refState,
        ),
      ],
    );
  }

  Widget additionalDetailsWidget() {
    return Column(
      children: [
        Center(
          child: AppText(
            title: "Additional Details",
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        // bookAppointmentWidget(),
        // const SizedBox(
        //   height: 14,
        // ), 
        _dealTypeWidget(),
        const SizedBox(
          height: 14,
        ),
        _ProductTrial(
          refNotifer: widget.refNotifer,
          refState: widget.refState,
        )
      ],
    );
  }

  Widget bookAppointmentWidget() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              color: AppColors.black.withValues(alpha: .2),
              blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title: "Book Appointment",
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
          const SizedBox(
            height: 10,
          ),
          AppTextfield(
            fillColor: false,
            isReadOnly: true,
            controller: widget.refNotifer.bookAppointmentController,
            onTap: () {
              DatePickerService.datePicker(context, selectedDate: selectedDate)
                  .then((picked) {
                if (picked != null) {
                  var day = picked.day < 10 ? '0${picked.day}' : picked.day;
                  var month =
                      picked.month < 10 ? '0${picked.month}' : picked.month;
                  widget.refNotifer.bookAppointmentController.text =
                      "${picked.year}-$month-$day";
                  setState(() {
                    selectedDate = picked;
                  });
                }
              });
            },
            suffixWidget: Container(
              height: 33,
              width: 33,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.add,
                color: AppColors.whiteColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
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
          boxShadow: !isExpanded
              ? []
              : [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: AppColors.black.withValues(alpha: .2),
                      blurRadius: 10)
                ]),
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
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withValues(alpha: .2),
                blurRadius: 10)
          ]),
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

  Widget addedProductWidget(
      {required NewCustomerVisitNotifier refNotifier,
      required NewCustomerVisitState refState}) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.itemsBG,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffE2E2E2)),
                  ),
                 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            AppText(
                title: "Added Items",
                color: AppColors.black,
                fontWeight: FontWeight.w400,
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
                return Container(
                    child: ExpandableWidget(
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
                            refState: refState)));
              }),
        ],
      ),
    );
  }

  productCollapsedWidget(
      {required bool isExpanded,
      required int index,
      required NewCustomerVisitNotifier refNotifier,
      required NewCustomerVisitState refState}) {
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

  productExpandexpandWidget(
      {required bool isExpanded,
      required int index,
      required NewCustomerVisitNotifier refNotifier,
      required NewCustomerVisitState refState}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
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
                      title: (model.name ?? ''),
                      maxLines: 1,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    AppText(
                      title: model.seletedCompetitor,
                      fontFamily: AppFontfamily.poppinsMedium,
                      fontsize: 12,
                    ),
                    const SizedBox(
                      width: 15,
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

class _ProductTrial extends StatelessWidget {
  final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
  const _ProductTrial({required this.refNotifer, required this.refState});

  @override
  Widget build(BuildContext context) {
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
          boxShadow: !isExpanded
              ? []
              : [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: AppColors.black.withValues(alpha: .2),
                      blurRadius: 10)
                ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(TextSpan(
              text: "Product Trial",
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
    print(refState.productTrial);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withValues(alpha: .2),
                blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              customRadioButton(
                  isSelected: refState.productTrial == 1 ? true : false,
                  title: 'Yes',
                  onTap: () {
                    refNotifer.selectProductTrialType(1);
                  }),
              const Spacer(),
              customRadioButton(
                  isSelected: refState.productTrial == 2 ? true : false,
                  title: 'No',
                  onTap: () {
                    refNotifer.selectProductTrialType(2);
                  }),
              const Spacer(),
            ],
          ),
          refState.productTrial == 1
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: AppTextButton(
                    title: "Book Trial",
                    height: 40,
                    color: AppColors.arcticBreeze,
                    onTap: () {
                      AppRouter.pushCupertinoNavigation( AddTrialScreen(
                        refNotifer: refNotifer,route: "visit",refState: refState,
                        onDetails: refNotifer.detailsBack,
                      )).then((val){
                        if((val??false)==true){
                          refNotifer.updatehasProductTrial(1);
                        }
                      });
                      // AppRouter.pushCupertinoNavigation(ProductTrialScreen(
                      //   refNotifer: refNotifer,
                      //   refState: refState,
                      // ));
                    },
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

class _CaptureImage extends StatefulWidget {
  final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
  const _CaptureImage({required this.refNotifer, required this.refState});

  @override
  State<_CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<_CaptureImage> {
  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
        initExpanded: true,
        collapsedWidget: collapsedWidget(isExpanded: true),
        expandedWidget: expandedWidget(context, isExpanded: false));
  }

  collapsedWidget({required bool isExpanded}) {
    return Container(
      padding: !isExpanded
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: !isExpanded
              ? []
              : [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: AppColors.black.withValues(alpha: .2),
                      blurRadius: 10)
                ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(TextSpan(
              text: "Capture Image",
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

  expandedWidget(
    BuildContext context, {
    required bool isExpanded,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withValues(alpha: .2),
                blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(
            height: 15,
          ),
          widget.refState.captureImageList.length > 1
              ? GridView.builder(
                  itemCount: widget.refState.captureImageList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2.9 / 3),
                  itemBuilder: (ctx, index) {
                    return index != 0
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    widget.refState.captureImageList[index],
                                    height: 79,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.refState.captureImageList.removeAt(index);
                                      widget.refState.uploadedImageList
                                          .removeAt(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.redColor),
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.whiteColor,
                                        size: 15,
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        : addImageWidget(context);
                  })
              : GestureDetector(
                  onTap: () {
                    _openCaptureImageScreen(context);
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.whiteColor,
                        border: Border.all(color: AppColors.e2Color)),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(AppAssetPaths.galleryIcon),
                  ),
                )
        ],
      ),
    );
  }

  Widget addImageWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        _openCaptureImageScreen(context);
      },
      child: DottedBorder(
          dashPattern: [5, 6],
          borderType: BorderType.RRect,
          color: AppColors.greenColor,
          radius: Radius.circular(20),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20)),
            child: Icon(
              Icons.add,
              size: 50,
              color: AppColors.light92Color.withValues(alpha: .5),
            ),
          )),
    );
  }

  _openCaptureImageScreen(BuildContext context) {
    AppRouter.pushCupertinoNavigation(CaptureImageScreen(
      refNotifer: widget.refNotifer,
      refState: widget.refState,
    )).then((val) {
      if (val != null) {
        widget.refNotifer.imageUploadApiFunction(context, val);
        setState(() {
          
        });
      }
    });
  }
}
