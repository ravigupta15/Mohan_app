import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/common_widgets/status_activity.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/riverpod/collaterals_request_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';

class ViewMarkingCollateralsScreen extends ConsumerStatefulWidget {
  final String id;
  const ViewMarkingCollateralsScreen({super.key, required this.id});

  @override
  ConsumerState<ViewMarkingCollateralsScreen> createState() => _ViewMarkingCollateralsScreenState();
}

class _ViewMarkingCollateralsScreenState extends ConsumerState<ViewMarkingCollateralsScreen> {


@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(collateralRequestProvider.notifier);
    refNotifier.viewCollateralsApiFunction(context, id: widget.id);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final refState= ref.watch(collateralRequestProvider);
    return Scaffold(
      appBar: customAppBar(title: refState.viewCollateralsReqestModel?.data?[0].name ?? ''),
      body:(refState.viewCollateralsReqestModel?.data)!=null? SingleChildScrollView(
         padding: const EdgeInsets.only(top: 14,left: 17,right: 17,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusWidget(activities: refState.viewCollateralsReqestModel?.data?[0].activities,),
            const SizedBox(height: 15,),
            _ItemRequestedWidget(refState: refState,),
            const SizedBox(height: 15,),
            RemarksWidget(
              isEditable: false,
              remarks: refState.viewCollateralsReqestModel?.data?[0].remarks??'',
            )
          ],
        ),
      ):EmptyWidget(),
    );
  }
}

// ignore: must_be_immutable
class _ItemRequestedWidget extends StatelessWidget {
  CollateralsRequestState refState;
   _ItemRequestedWidget({required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true),
     expandedWidget: expandedWidget(isExpanded: false));
  }

 Widget collapsedWidget({required bool isExpanded}){
   return Container(
    padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
       
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Visit Details',fontFamily: AppFontfamily.poppinsSemibold,),
              Icon(Icons.expand_less,color: AppColors.light92Color,),
        ],
      ),
   );
  }
  Widget expandedWidget({required bool isExpanded}){
   return Container(
    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          collapsedWidget(isExpanded: isExpanded),
           const SizedBox(height: 10,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
            headingWidget(),
            const SizedBox(height: 7,),
            ListView.separated(
              separatorBuilder: (ctx,sb){
                return const SizedBox(height: 15,);
              },
              shrinkWrap: true,
              itemCount: (refState.viewCollateralsReqestModel?.data?[0].mktgCollItem?.length??0),
              itemBuilder: (ctx,index){
                var model = refState.viewCollateralsReqestModel?.data?[0].mktgCollItem![index];
              return itemsWidget(model?.item??'', (model?.idx??'').toString());
            })
        ],
      ),
   );
  }

  itemsWidget(String title, String qty){
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(title: title,fontWeight: FontWeight.w400,),
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: AppText(title: qty),)
                ],
              ),
            );
  }

  headingWidget(){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.edColor,
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.symmetric(horizontal: 19,vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: AppText(title: "Item",fontsize: 12,fontFamily: AppFontfamily.poppinsMedium,color: AppColors.oliveGray,)),
          SizedBox(
            width: 60,
            child: AppText(title: "Quantity",fontsize: 12,fontFamily: AppFontfamily.poppinsMedium,color: AppColors.oliveGray,),
          ),
        ],
      ),
    );
  }

}
