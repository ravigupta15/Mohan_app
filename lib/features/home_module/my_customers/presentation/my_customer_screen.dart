import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/helper/dropdown_item_helper.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/custom_search_drop_down.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/features/home_module/custom_visit/presentation/widgets/visit_item.dart';
import 'package:mohan_impex/features/home_module/my_customers/presentation/view_customer_screen.dart';
import 'package:mohan_impex/features/home_module/my_customers/riverpod/my_customer_notifier.dart';
import 'package:mohan_impex/features/home_module/my_customers/riverpod/my_customer_state.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyCustomerScreen extends ConsumerStatefulWidget {
  const MyCustomerScreen({super.key});

  @override
  ConsumerState<MyCustomerScreen> createState() => _MyCustomerScreenState();
}

class _MyCustomerScreenState extends ConsumerState<MyCustomerScreen> {
  int selectedBusinessTypeIndex = -1;
  int selectedBillingTypeIndex = -1;
  String filterState = '';
  String filterDistrict = '';
  String filterBusinessType = '';
  String filterbillingType = '';
  String filterFromDate = '';
  String filterToDate = '';
  DateTime? fromDate;
  DateTime? todDate;
  String selectedState = '';
  String selectedDistrict = '';
  final stateSearchController = TextEditingController();
  final districtSearchController = TextEditingController();

  resetValue() {
    selectedBusinessTypeIndex = -1;
    selectedBillingTypeIndex = -1;
    filterBusinessType = '';
    filterbillingType = '';
    filterDistrict = '';
    filterState = '';
    fromDate = null;
    todDate = null;
    filterFromDate = '';
    filterToDate = '';
    selectedState = '';
    selectedDistrict = '';
  }

  @override
  void initState() {
    Future.microtask(() {
      callInitFunction();
    });
    super.initState();
  }

  ScrollController _scrollController = ScrollController();

  callInitFunction() {
    ref.read(myCustomerProvider.notifier).searchText = '';
    ref.read(myCustomerProvider.notifier).resetFilter();
    ref.read(myCustomerProvider.notifier).resetPageCount();
    _scrollController.addListener(_scrollListener);
    ref.read(myCustomerProvider.notifier).customerApiFunction();
    ref.read(myCustomerProvider.notifier).stateApiFunction();
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final state = ref.watch(myCustomerProvider);
    final notifier = ref.read(myCustomerProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.myCustomerModel?.data?[0].records?.length ?? 0) <
          int.parse(
              (state.myCustomerModel?.data?[0].totalCount ?? 0).toString())) {
        notifier.customerApiFunction(isLoadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(myCustomerProvider);
    final refNotifier = ref.read(myCustomerProvider.notifier);
    return Scaffold(
      appBar: customAppBar(title: 'My Customers'),
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AppSearchBar(
                hintText: "Search customer",
                onChanged: refNotifier.onChangedSearch,
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
                      GestureDetector(
                          onTap: () {
                            TextfieldUtils.hideKeyboard();
                            selectedState = filterState;
                            selectedDistrict = filterDistrict;
                            filterBottomSheet(context, refState, refNotifier);
                          },
                          child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            selectedFiltersWidget(refNotifier: refNotifier, refState: refState),
            Expanded(
                child: refState.isLoading
                    ? _myCustomerShimmer()
                    : (refState.myCustomerModel?.data?[0].records ?? [])
                            .isNotEmpty
                        ? ListView.separated(
                            controller: _scrollController,
                            separatorBuilder: (ctx, sb) {
                              return const SizedBox(
                                height: 15,
                              );
                            },
                            itemCount: (refState.myCustomerModel?.data?[0]
                                    .records?.length ??
                                0),
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 18, right: 18),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var model = refState
                                  .myCustomerModel?.data?[0].records?[index];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      AppRouter.pushCupertinoNavigation(
                                          ViewCustomerScreen(
                                        id: model?.name ?? '',
                                      ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 9, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 0),
                                                color: AppColors.black
                                                    .withValues(alpha: .2),
                                                blurRadius: 6)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          VisitItem(
                                              title: 'Customer name',
                                              subTitle:
                                                  model?.customerName ?? ''),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          VisitItem(
                                              title: 'Shop name',
                                              subTitle:
                                                  model?.customShop ?? ""),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          VisitItem(
                                              title: "Contact",
                                              subTitle: model?.contact ?? ''),
                                          const SizedBox(
                                            height: 9,
                                          ),
                                          VisitItem(
                                              title: "Location",
                                              subTitle: model?.location ?? ''),
                                        ],
                                      ),
                                    ),
                                  ),
                                  index ==
                                              (refState
                                                          .myCustomerModel
                                                          ?.data?[0]
                                                          .records
                                                          ?.length ??
                                                      0) -
                                                  1 &&
                                          refState.isLoadingMore
                                      ? Container(
                                          padding: const EdgeInsets.all(4),
                                          width: 37,
                                          height: 37,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : SizedBox.fromSize()
                                ],
                              );
                            })
                        : NoDataFound(title: "No data found"))
          ],
        ),
      ),
    );
  }

  Widget selectedFiltersWidget(
      {required MyCustomerNotifier refNotifier,
      required MyCustomerState refState}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          refNotifier.businessTypeFilter.isNotEmpty
              ? customFiltersUI(refNotifier.businessTypeFilter, () {
                  selectedBusinessTypeIndex = -1;
                  refNotifier.businessTypeFilter = '';
                  filterBusinessType = '';
                  refNotifier.customerApiFunction();
                  setState(() {});
                })
              : EmptyWidget(),
          refNotifier.zeroBillingFilter.isNotEmpty &&
                  selectedBillingTypeIndex != -1
              ? customFiltersUI(
                  refNotifier.biilingList[selectedBillingTypeIndex], () {
                  refNotifier.zeroBillingFilter = '';
                  filterbillingType = '';
                  selectedBillingTypeIndex = -1;
                  refNotifier.customerApiFunction();
                  setState(() {});
                })
              : EmptyWidget(),
          refNotifier.fromDateFilter.isNotEmpty
              ? customFiltersUI(
                  "${refNotifier.fromDateFilter} - ${refNotifier.toDateFilter}",
                  () {
                  refNotifier.fromDateFilter = '';
                  filterFromDate = '';
                  fromDate = null;
                  refNotifier.toDateFilter = '';
                  filterToDate = '';
                  todDate = null;

                  refNotifier.customerApiFunction();
                  setState(() {});
                })
              : EmptyWidget(),
              refNotifier.stateFilter.isNotEmpty
              ? customFiltersUI(
                  refNotifier.stateFilter, () {
                  refNotifier.stateFilter = '';
                  filterState = '';
                  selectedState = '';
                  stateSearchController.clear();
                  refNotifier.customerApiFunction();
                  setState(() {});
                })
              : EmptyWidget(),
              refNotifier.districtFilter.isNotEmpty 
              ? customFiltersUI(
                  refNotifier.districtFilter, () {
                  refNotifier.districtFilter = '';
                  filterDistrict = '';
                  selectedDistrict = '';
                  districtSearchController.clear();
                  refNotifier.customerApiFunction();
                  setState(() {});
                })
              : EmptyWidget()
        ],
      ),
    );
  }

  customFiltersUI(String title, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 15),
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
    );
  }

  filterBottomSheet(BuildContext context, MyCustomerState refState,
      MyCustomerNotifier refNotifier) {

    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        isScrollControlled: true,
        context: context,
        builder: (context) {
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
                          title: "Business Type",
                          fontFamily: AppFontfamily.poppinsSemibold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  refNotifier.businessTypeList.length, (val) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(
                                  isSelected: selectedBusinessTypeIndex == val
                                      ? true
                                      : false,
                                  title: refNotifier.businessTypeList[val],
                                  onTap: () {
                                    setState(() {
                                      state(() {
                                        selectedBusinessTypeIndex = val;
                                        filterBusinessType =
                                            refNotifier.businessTypeList[val];
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
                          title: "Billing Text",
                          fontFamily: AppFontfamily.poppinsSemibold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: List.generate(
                                  refNotifier.biilingList.length, (val) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: customRadioButton(
                                  isSelected: selectedBillingTypeIndex == val
                                      ? true
                                      : false,
                                  title: refNotifier.biilingList[val],
                                  onTap: () {
                                    setState(() {
                                      state(() {
                                        selectedBillingTypeIndex = val;
                                        filterbillingType =
                                            refNotifier.biilingList[val];
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
                          title: "Date",
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
                  CustomSearchDropDown(
                    searchController: stateSearchController,
                    selectedValues: selectedState,
                    height: 300,
                    items: DropdownItemHelper()
                        .stateItems((refState.stateModel?.data ?? [])),
                    hintText: "Select state",
                    onChanged: (val) {
                      state((){
                      filterState = val;
                      filterDistrict = '';
                      selectedDistrict = '';
                      districtSearchController.clear();
                      refState.districtModel = DistrictModel.fromJson({}); 
                      refNotifier.districtApiFunction(context, stateText: val).then((val){
                       if(val != null){
                         refState.districtModel = DistrictModel.fromJson(val);
                       }
                        state((){});
                        setState(() {
                          
                        });
                      });
                      });
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomSearchDropDown(
                     key: ValueKey(selectedDistrict),  // Add this line
                    searchController: districtSearchController,
                    selectedValues: selectedDistrict,
                    height: 300,
                    items: DropdownItemHelper()
                        .districtItems((refState.districtModel?.data ?? [])),
                    hintText: "Select district",
                    onChanged: (val) {
                      filterDistrict = val;
                      selectedDistrict = val;
                      state((){});
                      setState(() {});
                    },
                  ),
                
                      ],
                    ),
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
                        TextfieldUtils.hideKeyboard();
                        if (filterBusinessType.isEmpty &&
                            filterbillingType.isEmpty &&
                            filterFromDate.isEmpty &&
                            filterToDate.isEmpty&&
                            filterState.isEmpty&&
                            filterDistrict.isEmpty) {
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
                              businessType: filterBusinessType,
                              districtType: filterDistrict,
                              fromDate: filterFromDate,
                              stateType: filterState,
                              toDate: filterToDate,
                              zeroBilling: filterbillingType);
                          setState(() {});
                          refNotifier.customerApiFunction();
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          });
        });
  }
}

class _myCustomerShimmer extends StatelessWidget {
  const _myCustomerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
          separatorBuilder: (ctx, sb) {
            return const SizedBox(
              height: 15,
            );
          },
          itemCount: 5,
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 18, right: 18),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: AppColors.black.withValues(alpha: .2),
                          blurRadius: 6)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VisitItem(title: 'Customer name', subTitle: "Testing"),
                    const SizedBox(
                      height: 9,
                    ),
                    VisitItem(title: 'Shop name', subTitle: "Amar bakery"),
                    const SizedBox(
                      height: 9,
                    ),
                    VisitItem(title: "Contact", subTitle: "3534546646"),
                    const SizedBox(
                      height: 9,
                    ),
                    VisitItem(title: "Location", subTitle: 'Testing'),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
