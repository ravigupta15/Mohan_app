import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/presentation/add_complaint_screen.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/presentation/view_complaint_screen.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/riverpod/add_complaint_notifier.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/riverpod/add_complaint_state.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/widgets/complaint_items_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/res/shimmer/list_shimmer.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';

class ComplaintScreen extends ConsumerStatefulWidget {
  const ComplaintScreen({super.key});

  @override
  ConsumerState<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends ConsumerState<ComplaintScreen> {
  int selectedVisitTypeIndex = -1;
  int selectedClaimTypeIndex = -1;
  String filterVisitType = '';
  String filterClaimType = '';
  String filterFromDate = '';
  String filterToDate = '';
  DateTime? fromDate;
  DateTime? todDate;
  ScrollController _scrollController = ScrollController();

  resetValues() {
    selectedClaimTypeIndex = -1;
    selectedVisitTypeIndex = -1;
    filterClaimType = '';
    filterVisitType = '';
    filterFromDate = '';
    filterToDate = '';
    fromDate = null;
    todDate = null;
  }

  @override
  void initState() {
    Future.microtask(() {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final refNotifier = ref.read(addComplaintsProvider.notifier);
    refNotifier.resetComplaintValues();
    _scrollController.addListener(_scrollListener);
    refNotifier.complaintListApiFunction();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final state = ref.watch(addComplaintsProvider);
    final notifier = ref.read(addComplaintsProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.complaintModel?.data?[0].records?.length ?? 0) <
          int.parse(
              (state.complaintModel?.data?[0].totalCount ?? 0).toString())) {
        notifier.complaintListApiFunction(isLoadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(addComplaintsProvider.notifier);
    final refstate = ref.watch(addComplaintsProvider);
    return Scaffold(
      appBar: customAppBar(title: "Complaints & Claim"),
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: AppSearchBar(
                hintText: "Search by ticket number",
                onChanged: refNotifier.onChangedSearch,
                controller: refNotifier.searchController,
                suffixWidget: Container(
                  alignment: Alignment.center,
                  width: 60,
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssetPaths.searchIcon),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 20,
                        width: 1,
                        color: AppColors.lightBlue62Color.withValues(alpha: .3),
                      ),
                      InkWell(
                          onTap: () {
                            TextfieldUtils.hideKeyboard();
                            filterBottomSheet(context, refstate, refNotifier);
                          },
                          child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: selectedFiltersWidget(
                  refNotifier: refNotifier, refState: refstate),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: CustomTabbar(
                currentIndex: refstate.tabBarIndex,
                title1: "Active",
                title2: "Resolved",
                onClicked1: () {
                  if (refstate.tabBarIndex != 0) {
                    resetValues();
                  }
                  refNotifier.updateTabBarIndex(0);
                },
                onClicked2: () {
                  if (refstate.tabBarIndex != 1) {
                    resetValues();
                  }
                  refNotifier.updateTabBarIndex(1);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: complaintWidget(
                    refState: refstate, refNotifier: refNotifier))
          ],
        ),
      ),
      floatingActionButton: floatingActionButtonWidget(onTap: () {
        AppRouter.pushCupertinoNavigation(const AddComplaintScreen())
            .then((val) {
          if ((val ?? false) == true) {
            refNotifier.updateTabBarIndex(0);
            refNotifier.complaintListApiFunction();
          }
        });
      }),
    );
  }

  complaintWidget(
      {required AddComplaintState refState,
      required AddComplaintNotifier refNotifier}) {
    return refState.isLoading
        ? CustomerVisitShimmer(isKyc: true, isShimmer: refState.isLoading)
        : (refState.complaintModel?.data?[0].records?.length ?? 0) > 0
            ? ListView.separated(
                separatorBuilder: (ctx, sb) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount:
                    (refState.complaintModel?.data?[0].records?.length ?? 0),
                padding:
                    EdgeInsets.only(top: 10, bottom: 20, left: 13, right: 13),
                shrinkWrap: true,
                controller: _scrollController,
                itemBuilder: (ctx, index) {
                  var model = refState.complaintModel?.data?[0].records?[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppRouter.pushCupertinoNavigation(ViewComplaintScreen(
                            ticketId: (model?.name ?? ''),
                          )).then((val) {
                            // refNotifier.complaintListApiFunction();
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    color:
                                        AppColors.black.withValues(alpha: .2),
                                    blurRadius: 3)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 9),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ComplaintItemsWidget(
                                    title: model?.name ?? '',
                                    name: model?.username ?? '',
                                    date: model?.date ?? '',
                                    reasonTitle: model?.claimType ?? '',
                                    status: model?.workflowState ?? '',
                                    tabBarIndex: refState.tabBarIndex,
                                    statusDate:
                                        (model?.statusDate ?? '').toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      index ==
                                  (refState.complaintModel?.data?[0].records
                                              ?.length ??
                                          0) -
                                      1 &&
                              refState.isLoadingMore
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              width: 37,
                              height: 37,
                              child: const CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            )
                          : SizedBox.fromSize()
                    ],
                  );
                })
            : NoDataFound(
                title: refState.tabBarIndex == 0
                    ? "No active tickets found"
                    : "No resolved tickets found");
  }

  filterBottomSheet(
    BuildContext context,
    AddComplaintState refstate,
    AddComplaintNotifier refNotifier,
  ) {
    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 14, bottom: 20),
            child: StatefulBuilder(builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 11),
                    child: Row(
                      children: [
                        const Spacer(),
                        AppText(
                          title: "Filter",
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
                                color: AppColors.edColor,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.close,
                              size: 19,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          title: "Visit Type",
                          fontFamily: AppFontfamily.poppinsSemibold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  AppConstants.visitTypeList.length, (val) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(
                                  isSelected: selectedVisitTypeIndex == val
                                      ? true
                                      : false,
                                  title: AppConstants.visitTypeList[val],
                                  onTap: () {
                                    setState(() {
                                      state(() {
                                        selectedVisitTypeIndex = val;
                                        filterVisitType =
                                            AppConstants.visitTypeList[val];
                                      });
                                    });
                                  }),
                            );
                          }).toList()),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AppText(
                          title: "Claim Type",
                          fontFamily: AppFontfamily.poppinsSemibold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  AppConstants.claimTypeList.length, (val) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(
                                  isSelected: selectedClaimTypeIndex == val
                                      ? true
                                      : false,
                                  title: AppConstants.claimTypeList[val],
                                  onTap: () {
                                    setState(() {
                                      state(() {
                                        selectedClaimTypeIndex = val;
                                        filterClaimType =
                                            AppConstants.claimTypeList[val];
                                      });
                                    });
                                  }),
                            );
                          }).toList()),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AppText(
                          title: "Select Date",
                          fontFamily: AppFontfamily.poppinsSemibold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            AppDateWidget(
                              onTap: () {
                                DatePickerService.datePicker(context,
                                        selectedDate: fromDate)
                                    .then((picked) {
                                  if (picked != null) {
                                    var day = picked.day < 10
                                        ? '0${picked.day}'
                                        : picked.day;
                                    var month = picked.month < 10
                                        ? '0${picked.month}'
                                        : picked.month;
                                    filterFromDate =
                                        "${picked.year}-$month-$day";
                                    state(() {
                                      fromDate = picked;
                                      if (todDate != null &&
                                          fromDate!.isAfter(todDate!)) {
                                        todDate = null;
                                        filterToDate = "";
                                      }
                                    });
                                  }
                                });
                              },
                              title: filterFromDate,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              width: 8,
                              height: 2,
                              color: AppColors.black,
                            ),
                            AppDateWidget(
                              onTap: () {
                                DateTime firstDate = fromDate ?? DateTime(1994);
                                DatePickerService.datePicker(context,
                                        selectedDate: todDate,
                                        firstDate: firstDate)
                                    .then((picked) {
                                  if (picked != null) {
                                    var day = picked.day < 10
                                        ? '0${picked.day}'
                                        : picked.day;
                                    var month = picked.month < 10
                                        ? '0${picked.month}'
                                        : picked.month;
                                    filterToDate = "${picked.year}-$month-$day";
                                    state(() {
                                      todDate = picked;
                                    });
                                  }
                                });
                              },
                              title: filterToDate,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: AppTextButton(
                            title: "Apply",
                            height: 35,
                            width: 150,
                            color: AppColors.arcticBreeze,
                            onTap: () {
                              if (filterVisitType.isEmpty &&
                                  filterClaimType.isEmpty &&
                                  filterFromDate.isEmpty &&
                                  filterToDate.isEmpty) {
                                MessageHelper.showToast("Select any filter");
                              } else if ((filterFromDate.isNotEmpty &&
                                      filterToDate.isEmpty) ||
                                  (filterFromDate.isEmpty &&
                                      filterToDate.isNotEmpty)) {
                                MessageHelper.showToast(
                                    "Please select both From and To dates.");
                              } else {
                                Navigator.pop(context);
                                refNotifier.updateFilterValues(
                                    visitType: filterVisitType,
                                    fromDate: filterFromDate,
                                    toDate: filterToDate,
                                    claimType: filterClaimType);
                                setState(() {});
                                refNotifier.complaintListApiFunction();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          );
        });
  }

  Widget selectedFiltersWidget(
      {required AddComplaintNotifier refNotifier,
      required AddComplaintState refState}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          refNotifier.visitTypeFilter.isNotEmpty
              ? customFiltersUI(refNotifier.visitTypeFilter, () {
                  refNotifier.visitTypeFilter = '';
                  filterVisitType = '';
                  selectedVisitTypeIndex = -1;
                  refNotifier.complaintListApiFunction();
                  setState(() {});
                })
              : EmptyWidget(),
          // const SizedBox(width: 15,),
          refNotifier.claimTypeFilter.isNotEmpty
              ? customFiltersUI(refNotifier.claimTypeFilter, () {
                  refNotifier.claimTypeFilter = '';
                  filterClaimType = '';
                  selectedClaimTypeIndex = -1;
                  refNotifier.complaintListApiFunction();
                  setState(() {});
                })
              : EmptyWidget(),
          //  const SizedBox(width: 15,),
          refNotifier.fromDateFilter.isNotEmpty
              ? customFiltersUI("${refNotifier.fromDateFilter} - ${refNotifier.toDateFilter}", () {
                  refNotifier.fromDateFilter = '';
                  refNotifier.toDateFilter = '';
                  filterFromDate = '';
                  filterToDate = '';
                  fromDate = null;
                  todDate = null;
                  refNotifier.complaintListApiFunction();
                  setState(() {});
                })
              : EmptyWidget(),
          //  const SizedBox(width: 15,),
          // refNotifier.toDateFilter.isNotEmpty
          //     ? customFiltersUI(refNotifier.toDateFilter, () {
          //         refNotifier.toDateFilter = '';
          //         filterToDate = '';
          //         refNotifier.complaintListApiFunction();
          //         setState(() {});
          //       })
          //     : EmptyWidget(),
        ],
      ),
    );
  }

  customFiltersUI(String title, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.greenColor),
              borderRadius: BorderRadius.circular(15)),
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 2),
          child: Row(
            children: [
              AppText(
                title: title,
                fontFamily: AppFontfamily.poppinsSemibold,
                fontsize: 13,
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.close,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
