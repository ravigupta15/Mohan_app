import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/card_item_widget.dart';
import 'package:mohan_impex/features/home_module/my_customers/model/view_my_custom_model.dart';
import 'package:mohan_impex/features/home_module/my_customers/riverpod/my_customer_notifier.dart';
import 'package:mohan_impex/features/home_module/my_customers/riverpod/my_customer_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/utils/message_helper.dart';

class ViewCustomerScreen extends ConsumerStatefulWidget {
  final String id;
  const ViewCustomerScreen({super.key, required this.id});

  @override
  ConsumerState<ViewCustomerScreen> createState() => _ViewCustomerScreenState();
}

class _ViewCustomerScreenState extends ConsumerState<ViewCustomerScreen> {
  DateTime? selectedToDate;
  String filterToDate = '';
  // bool isFilterEnable = false;

  DateTime? selectedFromDate;
  String filterFromDate = '';

  @override
  void initState() {
    Future.microtask(() {
      _scrollController.addListener(_scrollListener);
      callInitFunction();
    });
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  callInitFunction() {
    final refNotifier = ref.read(myCustomerProvider.notifier);
    refNotifier.resetLedger();
    refNotifier.viewCustomerApiFunction(context, widget.id);

    refNotifier.ledgerApiFunction(context, widget.id);
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
      if ((state.ledgerModel?.data?[0].records?.length ?? 0) <
          int.parse((state.ledgerModel?.data?[0].totalCount ?? 0).toString())) {
        notifier.ledgerApiFunction(context, widget.id, isLoadMore: true);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(myCustomerProvider);
    final refNotifier = ref.read(myCustomerProvider.notifier);
    return Scaffold(
      appBar: customAppBar(title: 'My Customers'),
      body: (refState.viewMyCustomerModel?.data?[0]) != null
          ? SingleChildScrollView(
              controller: _scrollController,
              padding:
                  EdgeInsets.only(top: 12, left: 18, right: 18, bottom: 25),
              child: Column(
                children: [
                  _CustomInfoWidget(
                    refState: refState,
                    refNotifier: refNotifier,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ledgerWidget(refNotifier: refNotifier, refState: refState)
                ],
              ),
            )
          : EmptyWidget(),
    );
  }

  Widget ledgerWidget(
      {required MyCustomerState refState,
      required MyCustomerNotifier refNotifier}) {
    return ExpandableWidget(
        initExpanded: true,
        isBorderNoShadow: true,
        collapsedWidget: collpasedWidget(context,
            isExpanded: true, refNotifier: refNotifier, refState: refState),
        expandedWidget: expandedWidget(context,
            isExpanded: false, refNotifier: refNotifier, refState: refState));
  }

  collpasedWidget(BuildContext context,
      {required bool isExpanded,
      required MyCustomerState refState,
      required MyCustomerNotifier refNotifier}) {
    return Container(
      padding: !isExpanded
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: !isExpanded ? null : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(9),
          boxShadow: !isExpanded
              ? []
              : [
                  // BoxShadow(
                  //     offset: Offset(0, 0),
                  //     color: AppColors.black.withValues(alpha: .2),
                  //     blurRadius: 10)
                ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: 'Ledger History',
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

  expandedWidget(BuildContext context,
      {required bool isExpanded,
      required MyCustomerState refState,
      required MyCustomerNotifier refNotifier}) {
    var model = refState.viewMyCustomerModel?.data?[0];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collpasedWidget(context,
              isExpanded: isExpanded,
              refNotifier: refNotifier,
              refState: refState),
          const SizedBox(
            height: 5,
          ),
          dotteDivierWidget(
            dividerColor: AppColors.edColor,
            thickness: 1.7
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              customBalanceContainer("Outstanding Balance",
                  (model?.outstandingAmt ?? '').toString()),
              const SizedBox(
                width: 10,
              ),
              customBalanceContainer("Last Billing Amount",
                  (model?.lastBillingRate ?? '').toString()),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          dotteDivierWidget(
            dividerColor: AppColors.edColor,
          ),
          const SizedBox(
            height: 15,
          ),
          AppSearchBar(
            hintText: "Search",
            suffixWidget: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(AppAssetPaths.searchIcon),
            ),
            onChanged: (val) {
              
              refNotifier.onChangedLedgerSearch(val, widget.id, context);
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                filtersWidget("Filters", context, refNotifier, onTap: () {
                  filterBottomSheet(context, refNotifier);
                }, isFilterIcon: true),
                refNotifier.ledgerFromDate.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: 5,
                        ),
                        child: filtersWidget(
                            "${refNotifier.ledgerFromDate} - ${refNotifier.ledgerToDate}", context, refNotifier,
                            onTap: () {
                          refNotifier.ledgerFromDate = '';
                          filterFromDate = '';
                           refNotifier.ledgerToDate = '';
                          filterToDate = '';
                          selectedFromDate = null;
                          selectedToDate = null;
                          refNotifier.ledgerApiFunction(context, widget.id);
                          setState(() {});
                        }),
                      )
                    : EmptyWidget(),

              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          (refState.ledgerModel?.data?[0].records??[]).isEmpty ?
          NoDataFound(title: "No ledger data found"):
          tableWidget(refNotifier: refNotifier, refState: refState)
        ],
      ),
    );
  }

  filtersWidget(
    String title,
    BuildContext context,
    MyCustomerNotifier refNotifier, {
    bool isFilterIcon = false,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: AppColors.greenColor),
            borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        // alignment: Alignment.center,
        child: Row(
          children: [
            isFilterIcon
                ? SvgPicture.asset(
                    AppAssetPaths.filterIcon,
                    height: 14,
                  )
                : SizedBox.shrink(),
            const SizedBox(
              width: 4,
            ),
            AppText(
              title: title,
              fontFamily: AppFontfamily.poppinsRegular,
              fontsize: 11,
            ),
            isFilterIcon
                ? EmptyWidget():
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(Icons.close,size: 15,),
              )
          ],
        ),
      ),
    );
  }

  tableWidget(
      {required MyCustomerState refState,
      required MyCustomerNotifier refNotifier}) {
    return Table(
      border: TableBorder.all(
          color: AppColors.e2Color), // Adds borders to the table
      children: [
        TableRow(
          children: [
            _buildTableCell('Date'),
            _buildTableCell('Description'),
            _buildTableCell('Amount'),
            _buildTableCell('Balance'),
          ],
        ),
        ...List.generate((refState.ledgerModel?.data?[0].records?.length ?? 0),
            (val) {
          var model = refState.ledgerModel?.data?[0].records?[val];
          return TableRow(
            children: [
              _buildTableCell(model?.date ?? '',
                  fontSize: 10, isBGColor: false),
              _buildTableCell(model?.name ?? "",
                  fontSize: 10, isBGColor: false),
              _buildTableCell(
                  double.parse(model!.amount.toString()).toStringAsFixed(2),
                  fontSize: 10,
                  isBGColor: false),
              _buildTableCell((model.balance ?? '').toString(),
                  fontSize: 10, isBGColor: false),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTableCell(String text,
      {bool isBGColor = true, double fontSize = 11}) {
    return TableCell(
      child: Container(
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 2),
        color: isBGColor ? AppColors.edColor : null,
        child: Center(
            child: AppText(
          title: text,
          fontsize: fontSize,
          fontFamily: AppFontfamily.poppinsMedium,
          maxLines: 1,
        )),
      ),
    );
  }

  customBalanceContainer(String title, String subTitle) {
    return Expanded(
      child: Container(
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                  color: AppColors.black.withValues(alpha: .2),
                  blurRadius: 10,
                  offset: Offset(0, 0))
            ]),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title: title,
              fontsize: 10,
              fontFamily: AppFontfamily.poppinsRegular,
            ),
            const SizedBox(
              height: 8,
            ),
            AppText(
              title: subTitle,
              fontsize: 16,
              fontFamily: AppFontfamily.poppinsSemibold,
            ),
          ],
        ),
      ),
    );
  }

  filterBottomSheet(BuildContext context, MyCustomerNotifier refNotifier) {
    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
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
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: AppText(
                      title: "Select Date",
                      fontFamily: AppFontfamily.poppinsSemibold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 15),
                    child: Row(
                      children: [
                        AppDateWidget(
                          title: filterFromDate,
                          onTap: () {
                            DatePickerService.datePicker(context,
                                    selectedDate: selectedFromDate)
                                .then((picked) {
                              if (picked != null) {
                                state(() {
                                  var day = picked.day < 10
                                      ? '0${picked.day}'
                                      : picked.day;
                                  var month = picked.month < 10
                                      ? '0${picked.month}'
                                      : picked.month;
                                  filterFromDate = "${picked.year}-$month-$day";
                                  setState(() {
                                    selectedFromDate = picked;
                                      if (selectedToDate != null &&
                                          selectedFromDate!.isAfter(selectedToDate!)) {
                                        selectedToDate = null;
                                        filterToDate = "";
                                      } 
                                  });
                                });
                              }
                            });
                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          width: 8,
                          height: 2,
                          color: AppColors.black,
                        ),
                        AppDateWidget(
                          title: filterToDate,
                          onTap: () {
                             DateTime firstDate = selectedFromDate ?? DateTime(1994);
                            DatePickerService.datePicker(context,
                                    selectedDate: selectedToDate,
                                    firstDate: firstDate
                                    )
                                .then((picked) {
                              if (picked != null) {
                                state(() {
                                  var day = picked.day < 10
                                      ? '0${picked.day}'
                                      : picked.day;
                                  var month = picked.month < 10
                                      ? '0${picked.month}'
                                      : picked.month;
                                  filterToDate = "${picked.year}-$month-$day";
                                  setState(() {
                                    selectedToDate = picked;
                                  });
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AppTextButton(
                      title: "Apply",
                      height: 35,
                      width: 150,
                      color: AppColors.arcticBreeze,
                      onTap: () {
                        if (filterFromDate.isEmpty && filterToDate.isEmpty) {
                          MessageHelper.showToast("Select filter");
                        } else if((filterFromDate.isNotEmpty &&
                                      filterToDate.isEmpty) ||
                                  (filterFromDate.isEmpty &&
                                      filterToDate.isNotEmpty)){
                                         MessageHelper.showToast(
                                    "Please select both From and To dates.");
                                      } else {
                          Navigator.pop(context);
                          refNotifier.updateLedgerFilterValues(
                              fromDate: filterFromDate, toDate: filterToDate);
                          setState(() {});
                          refNotifier.ledgerApiFunction(context, widget.id);
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

class _CustomInfoWidget extends StatelessWidget {
  final MyCustomerState refState;
  final MyCustomerNotifier refNotifier;
  _CustomInfoWidget({required this.refState, required this.refNotifier});

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
          color: !isExpanded ? null : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
         ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: 'Customer Information',
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

  expandedWidget({required bool isExpanded}) {
    var model = refState.viewMyCustomerModel?.data?[0];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(
            height: 6,
          ),
          dotteDivierWidget(
            dividerColor: AppColors.edColor,
          ),
          const SizedBox(
            height: 8,
          ),
          cardItemsWidget("Customer Name", model?.customerName ?? ''),
          const SizedBox(
            height: 10,
          ),
          cardItemsWidget("Shop Name", model?.shopName ?? ''),
          const SizedBox(
            height: 10,
          ),
          cardItemsWidget("Contact", model?.contact ?? ''),
          const SizedBox(
            height: 10,
          ),
          model!= null?
          cardItemsWidget("Location", customerAddress(model.location!)) : EmptyWidget(),
        ],
      ),
    );
  }

 customerAddress(Location model){
  String address = [
  model.addressLine1 ??'',
  model.addressLine2 ?? '',
  model.city ?? '',
  model.state ?? '',
  model.pincode ?? '',
].where((element) => element != null).join(', ');
  return address;
}

}
