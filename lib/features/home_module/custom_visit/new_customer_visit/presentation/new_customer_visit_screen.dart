import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mohan_impex/core/services/location_service.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/view_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/registration_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/sales_patch_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/overview_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/timer_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/utils/message_helper.dart';

// ignore: must_be_immutable
class NewCustomerVisitScreen extends ConsumerStatefulWidget {
  VisitItemsModel? resumeItems;
  final String route;
  NewCustomerVisitScreen({super.key, this.resumeItems, required this.route});

  @override
  ConsumerState<NewCustomerVisitScreen> createState() =>
      _NewCustomerVisitScreenState();
}

class _NewCustomerVisitScreenState
    extends ConsumerState<NewCustomerVisitScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (widget.route == 'resume') {
        callSetResumeData();
      } else {
        callInitFuntion();
      }
    });
    super.initState();
  }

  callInitFuntion() {
    final refNotifier = ref.read(newCustomVisitProvider.notifier);
    final refState = ref.watch(newCustomVisitProvider);
    refNotifier.resetValues();
    refNotifier.startTimer();
    refNotifier.competitorApiFunction(context,'');
    refNotifier.stateApiFunction(context);
    refState.visitStartDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString();
    LocationService().startLocationUpdates().then((val) {
      refState.visitStartLatitude = val.latitude.toString();
      refState.visitStartLetitude = val.longitude.toString();
    });
    setState(() {});
  }

  callSetResumeData() {
    final refNotifier = ref.read(newCustomVisitProvider.notifier);
    // final refState = ref.watch(newCustomVisitProvider);
    refNotifier.resetValues();
    refNotifier.competitorApiFunction(context,'');
    // refNotifier.stateApiFunction(context);
    // refState.visitStartDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString();
    // LocationService().startLocationUpdates().then((val){
    //  refState.visitStartLatitude = val.latitude.toString();
    //  refState.visitStartLetitude = val.longitude.toString();
    // });
    refNotifier.setResumeData(context, widget.resumeItems!);
  }

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(newCustomVisitProvider.notifier);
    final refState = ref.watch(newCustomVisitProvider);
    return WillPopScope(
      onWillPop: () async {
        _handleBackButton(refNotifier, refState);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: customAppBar(
            title: appBarTitle(refState.tabBarIndex),
            isBackTap: () {
              _handleBackButton(refNotifier, refState);
            },
            actions: [timerWidget(refState.currentTimer)]),
        body: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Form(
            key: refNotifier.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tabbarWidget(refState),
                const SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.center,
                    child: AppText(
                      title: tabBarTitle(refState.tabBarIndex),
                      fontFamily: AppFontfamily.poppinsSemibold,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 30, left: 18, right: 19),
                  child: Column(
                    children: [
                      refState.tabBarIndex == 0
                          ?

                          /// registration
                          RegistrationWidget(
                              refNotifer: refNotifier,
                              refState: refState,
                            )
                          : refState.tabBarIndex == 1
                              ?

                              /// sales patch
                              SalesPatchWidget()
                              :

                              /// overview
                              OverviewWidget(
                                  refNotifer: refNotifier,
                                  refState: refState,
                                ),
                      const SizedBox(
                        height: 30,
                      ),
                      refState.tabBarIndex == 0
                          ? Align(
                              alignment: Alignment.center,
                              child: AppTextButton(
                                title: "Next",
                                color: AppColors.arcticBreeze,
                                height: 44,
                                width: 120,
                                onTap: () {
                                  if (refState.tabBarIndex == 0) {
                                    refNotifier.checkRegistrationValidation();
                                  } else if (refState.tabBarIndex == 1) {
                                    refNotifier
                                        .checkSalesPitchValidation(context);
                                  } else if (refState.tabBarIndex == 2) {}
                                },
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: AppTextButton(
                                    title: refState.tabBarIndex == 1
                                        ? "Previous"
                                        : "Draft"
                                    // : "Previous"
                                    ,
                                    color: AppColors.arcticBreeze,
                                    height: 44,
                                    width: 120,
                                    onTap: () {
                                      if (refState.tabBarIndex == 1) {
                                        _handleBackButton(
                                            refNotifier, refState);
                                      } else {
                                        bool value =
                                            refState.selectedProductList.any(
                                                (val) => val.list.any((items) =>
                                                    items.quantity == 0));
                                        if (value) {
                                          MessageHelper.showErrorSnackBar(
                                              context,
                                              "Quantity should not be empty");
                                        } else if(refState.productTrial == 1 && refState.hasProductTrial ==0){
                                          MessageHelper.showErrorSnackBar(
                                              context,
                                              "Please book the trial");
                                        } else {

                                          refNotifier.createProductApiFunction(
                                              context,
                                              actionType: 'Draft',route: widget.route);
                                        }
                                      }
                                      // if(refState.captureImageList.length>1){
                                      //   refNotifier.checkOverViewValidation(context,actionType: "Draft" );
                                      // }
                                      // el/
                                      // Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: AppTextButton(
                                    title: refState.tabBarIndex == 1
                                        ? "Next"
                                        : "Submit",
                                    color: AppColors.arcticBreeze,
                                    height: 44,
                                    width: 120,
                                    onTap: () {
                                      if (refState.tabBarIndex == 1) {
                                        refNotifier
                                            .checkSalesPitchValidation(context);
                                      } else {
                                        refNotifier.checkOverViewValidation(
                                            context,
                                            actionType: "Submit",route: widget.route);
                                      }
                                      // AppRouter.pushCupertinoNavigation(const BookTrialSuccessScreen());
                                    },
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  tabbarWidget(NewCustomerVisitState refState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _roundedContainer(
            bgColor: refState.tabBarIndex == 0
                ? AppColors.black
                : AppColors.greenColor,
            borderColor: refState.tabBarIndex == 0
                ? AppColors.black
                : AppColors.greenColor),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: _divider(AppColors.greenColor),
        ),
        _roundedContainer(
            bgColor: refState.tabBarIndex == 1
                ? AppColors.black
                : refState.tabBarIndex > 1
                    ? AppColors.greenColor
                    : AppColors.whiteColor,
            borderColor: refState.tabBarIndex == 1
                ? AppColors.black
                : refState.tabBarIndex > 1
                    ? AppColors.greenColor
                    : AppColors.lightTextColor),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: _divider(refState.tabBarIndex >= 1
              ? AppColors.greenColor
              : AppColors.lightTextColor),
        ),
        _roundedContainer(
            bgColor: refState.tabBarIndex >= 2
                ? AppColors.black
                : AppColors.whiteColor,
            borderColor: refState.tabBarIndex >= 2
                ? AppColors.black
                : AppColors.lightTextColor),
      ],
    );
  }

  _divider(Color color) {
    return Container(
      width: 50,
      color: color,
      height: 1,
    );
  }

  _roundedContainer({required Color bgColor, required Color borderColor}) {
    return Container(
      height: 16,
      width: 16,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          color: bgColor,
          shape: BoxShape.circle),
    );
  }

  ////// HELPER METHOD

  String appBarTitle(int index) {
    switch (index) {
      case 0:
        return 'New Customer Visit';
      case 1:
        return "New Customer Visit";
      case 2:
        return "Submit";
      default:
        return 'New Customer Visit';
    }
  }

  String tabBarTitle(int index) {
    switch (index) {
      case 0:
        return "Registration";
      case 1:
        return "Sales Pitch";
      case 2:
        return "Overview";
      default:
        return "Registration";
    }
  }

  _handleBackButton(
      NewCustomerVisitNotifier refNotifer, NewCustomerVisitState refState) {
    if (refState.tabBarIndex > 0) {
      refNotifer.deceraseTabBarIndex();
    } else {
      Navigator.pop(context);
    }
  }
}

