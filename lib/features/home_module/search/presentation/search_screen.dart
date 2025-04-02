import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final String route;
  final String channelParter;
  final String visitType;
  final String verificationType;
  final bool showCustomerStatus;
  final String kycStatus; /// from sales order (Completed) 
  const SearchScreen({super.key, required this.route, this.channelParter = '', this.visitType = '',
  this.verificationType = '',this.showCustomerStatus = false, this.kycStatus = ''
  });

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String url = '';

  @override
  void initState() {
    Future.microtask(() {
      callInitFunction();
    });
    super.initState();
  }
  bool isInit = false;

  callInitFunction() {
    isInit = true;
    setState(() {
      
    });
    final refNotifier = ref.read(newCustomVisitProvider.notifier);
    final refState = ref.watch(newCustomVisitProvider);
    final addSalesNotifier = ref.read(addSalesOrderProvider.notifier);
    refState.channelList.clear();
    refState.customerInfoModel = null;
    if (widget.route == 'channel') {
      refNotifier.channelListApiFunction('');
    } else if (widget.route == 'product') {
      refNotifier.productApiFunction('');
    } else if(widget.route=='verified') {
      refNotifier.customerInfoApiFunction(searchText: '', channelPartern: widget.channelParter, visitType: widget.visitType,verificationType: widget.verificationType, kycStatus: widget.kycStatus);
    }
    else if(widget.route == 'itemTemplateSalesOrder'){
      addSalesNotifier.itemTemplateApiFunction('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(newCustomVisitProvider);
    final addSalesRefState = ref.watch(addSalesOrderProvider);
    return Scaffold(
      appBar: customAppBar(title: "Search"),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
        child: Column(
          children: [
            AppSearchBar(
              autofocus: true,
                hintText: "Search...",
                suffixWidget: Container(
                  alignment: Alignment.center,
                  width: 40,
                  child: SvgPicture.asset(AppAssetPaths.searchIcon),
                ),
                onChanged: widget.route == "channel"
                         ? _handleChannelSearch
                         : widget.route == 'product'
                         ? _handleProductSearch
                         : widget.route=='verified'?
                         _handleCustomInfoSearch:
                         widget.route == 'itemTemplateSalesOrder'?
                         _handleSalesItemTemplateSearch:
                          _handleCustomInfoSearch
                         ),

                         /// widget 
                         widget.route =='verified'?
                         _customInfoWidget(refState):
                         widget.route == 'product'
                         ? _productWidget(refState)
                         : widget.route == 'channel'
                         ? _channelWidget(refState)
                         : widget.route == 'itemTemplateSalesOrder'?
                         _salesItemtemplateWidget(addSalesRefState):
                          _customInfoWidget(refState)
          ],
        ),
      ),
    );
  }

  Widget _customInfoWidget(NewCustomerVisitState refState) {
    return Expanded(
        child: (refState.customerInfoModel?.message ?? []).isEmpty && !isInit
            ? NoDataFound(title: "No matching vendor found")
            : ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: (refState.customerInfoModel?.message?.length ?? 0),
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 20),
                itemBuilder: (ctx, index) {
                  var model = refState.customerInfoModel?.message?[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context, refState.customerInfoModel?.message![index]);
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: AppColors.lightBlue62Color
                                      .withValues(alpha: .4)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: AppText(title: model?.customerName ?? '',maxLines: 1,)),
                          const SizedBox(width: 4,),
                        widget.showCustomerStatus?
                          AppText(title: model?.verificType ?? '',
                          fontsize: 13,
                          color: (model?.verificType ?? '').toLowerCase() == 'verified' ? AppColors.greenColor : AppColors.redColor,
                          ) : EmptyWidget()
                        ],
                      ),
                    ),
                  );
                }));
  }



  Widget _salesItemtemplateWidget(AddSalesOrderState refState) {
    return Expanded(
        child: (refState.itemTemplateModel?.data ?? []).isEmpty && !isInit
            ? NoDataFound(title: "No matching item found")
            : ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: (refState.itemTemplateModel?.data?.length ?? 0),
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 20),
                itemBuilder: (ctx, index) {
                  var model = refState.itemTemplateModel?.data?[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context, refState.itemTemplateModel?.data![index].itemCode);
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: AppColors.lightBlue62Color
                                      .withValues(alpha: .4)))),
                      child: AppText(title: model?.itemName ?? ''),
                    ),
                  );
                }));
  }


  Widget _channelWidget(NewCustomerVisitState refState) {
    return Expanded(
        child: (refState.channelList).isEmpty && !isInit
            ? NoDataFound(title: "No matching channel partner found")
            : ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: (refState.channelList.length),
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 20),
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, refState.channelList[index]);
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: AppColors.lightBlue62Color
                                      .withValues(alpha: .4)))),
                      child: AppText(title: refState.channelList[index]),
                    ),
                  );
                }));
  }

  Widget _productWidget(NewCustomerVisitState refState) {
    return Expanded(
        child: (refState.productModel?.data ?? []).isEmpty && !isInit
            ? NoDataFound(title: "No matching product found")
            : ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: (refState.productModel?.data?.length ?? 0),
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 20),
                itemBuilder: (ctx, index) {
                  var model = refState.productModel?.data?[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, model?.productName ?? '');
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: AppColors.lightBlue62Color
                                      .withValues(alpha: .4)))),
                      child: AppText(title: model?.productName ?? ''),
                    ),
                  );
                }));
  }

  _handleCustomInfoSearch(String val) {
    isInit = false; 
    if (val.isNotEmpty) {
      ref.read(newCustomVisitProvider.notifier).customerInfoApiFunction(searchText: val,channelPartern: widget.channelParter, visitType: widget.visitType, verificationType: widget.verificationType, kycStatus: widget.kycStatus);
    } else {
        ref.read(newCustomVisitProvider.notifier).customerInfoApiFunction(searchText: '',channelPartern: widget.channelParter, visitType: widget.visitType, verificationType: widget.visitType,kycStatus : widget.kycStatus);
      // ref.read(newCustomVisitProvider.notifier).customerInfoApiFunction('');
    }
  }

  _handleSalesItemTemplateSearch(String val) {
    isInit = false; 
    if (val.isNotEmpty) {
      ref.read(addSalesOrderProvider.notifier).itemTemplateApiFunction(val);
    } else {
      ref.read(addSalesOrderProvider.notifier).itemTemplateApiFunction('');
    }
  }

  _handleUnvCustomSearch(String val) {
    isInit = false; 
    if (val.isNotEmpty) {
      ref.read(newCustomVisitProvider.notifier).unvCustomerApiFunction(val);
    } else {
          ref.read(newCustomVisitProvider.notifier).unvCustomerApiFunction('');
      // ref.read(newCustomVisitProvider.notifier).unvCustomerApiFunction('');
    }
  }

  _handleProductSearch(String val) {
    isInit = false; 
    if (val.isNotEmpty) {
      ref.read(newCustomVisitProvider.notifier).productApiFunction(val);
    } else {
      ref.read(newCustomVisitProvider.notifier).productApiFunction('');
    }
  }

  _handleChannelSearch(String val) {
    isInit = false; 
    if (val.isNotEmpty) {
      ref.read(newCustomVisitProvider.notifier).channelListApiFunction(val);
    } else {
      ref.read(newCustomVisitProvider.notifier).channelListApiFunction('');
    }
  }
}
