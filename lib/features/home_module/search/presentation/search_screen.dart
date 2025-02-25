import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final String route;
  const SearchScreen({super.key, required this.route});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {

String url = '';

@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(newCustomVisitProvider.notifier);
    final refState = ref.watch(newCustomVisitProvider);
    refState.channelList.clear();
    refState.customerInfoModel = null;
     if(widget.route =='channel'){
      refNotifier.channelListApiFunction('');
     }
     else if(widget.route=='product'){
      refNotifier.productApiFunction('');
     }
     else{
      refNotifier.customerInfoApiFunction('');
     }

  }

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(newCustomVisitProvider);
    return Scaffold(
      appBar: customAppBar(title: "Search"),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 6),
        child: Column(
          children: [
            AppSearchBar(
                  hintText: "Search by name, phone, etc.",
                  suffixWidget: Container(
                    alignment: Alignment.center,
                    width: 40,
                    child: SvgPicture.asset(AppAssetPaths.searchIcon),
                  ),
                  onChanged: widget.route == "channel"?_handleChannelSearch :
                  widget.route == 'product'? _handleProductSearch :
                  _handleCustomInfoSearch
                ),
               widget.route == 'product'?
               _productWidget(refState):
               widget.route == 'channel'?
               _channelWidget(refState):
               _customInfoWidget(refState)
          ],
        ),
      ),
    );
  }


Widget _customInfoWidget(NewCustomerVisitState refState){
return  Expanded(child:(refState.customerInfoModel?.message??[]).isEmpty?
                NoDataFound(title: "Not found"):
                 ListView.separated(
                  separatorBuilder: (ctx,index){
                    return const SizedBox(height: 10,);
                  },
                  itemCount: (refState.customerInfoModel?.message?.length??0),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20),
                  itemBuilder: (ctx,index){
                    var model = refState.customerInfoModel?.message?[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.pop(context, refState.customerInfoModel?.message![index]);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: AppColors.lightBlue62Color.withValues(alpha: .4)
                            )
                          )
                        ),
                        child: AppText(title: model?.customerName??''),
                      ), 
                    );
                }));
}


Widget _channelWidget(NewCustomerVisitState refState){
return  Expanded(child:(refState.channelList).isEmpty?
                NoDataFound(title: "Not found"):
                 ListView.separated(
                  separatorBuilder: (ctx,index){
                    return const SizedBox(height: 10,);
                  },
                  itemCount: (refState.channelList.length),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20),
                  itemBuilder: (ctx,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.pop(context, refState.channelList[index]);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: AppColors.lightBlue62Color.withValues(alpha: .4)
                            )
                          )
                        ),
                        child: AppText(title: refState.channelList[index]),
                      ), 
                    );
                }));
}


Widget _productWidget(NewCustomerVisitState refState){
return  Expanded(child:(refState.productModel?.data??[]).isEmpty?
                NoDataFound(title: "Not found"):
                 ListView.separated(
                  separatorBuilder: (ctx,index){
                    return const SizedBox(height: 10,);
                  },
                  itemCount: (refState.productModel?.data?.length??0),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20),
                  itemBuilder: (ctx,index){
                    var model = refState.productModel?.data?[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.pop(context, model?.productName??'');
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: AppColors.lightBlue62Color.withValues(alpha: .4)
                            )
                          )
                        ),
                        child: AppText(title: model?.productName??''),
                      ), 
                    );
                }));
}


  _handleCustomInfoSearch(String val){
if(val.isNotEmpty){
                      ref.read(newCustomVisitProvider.notifier).customerInfoApiFunction(val);
                    }
                    else{
                       ref.read(newCustomVisitProvider.notifier).customerInfoApiFunction('');
                    }
  }

  _handleProductSearch(String val){
if(val.isNotEmpty){
                      ref.read(newCustomVisitProvider.notifier).productApiFunction(val);
                    }
                    else{
                       ref.read(newCustomVisitProvider.notifier).productApiFunction('');
                    }
  }


   _handleChannelSearch(String val){
if(val.isNotEmpty){
                      ref.read(newCustomVisitProvider.notifier).channelListApiFunction(val);
                    }
                    else{
                       ref.read(newCustomVisitProvider.notifier).channelListApiFunction('');
                    }
  }

}