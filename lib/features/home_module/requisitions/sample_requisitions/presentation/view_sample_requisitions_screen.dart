import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/common_widgets/status_activity.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/riverpod/sample_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';

class ViewSampleRequisitionsScreen extends ConsumerStatefulWidget {
  final String id;
  const ViewSampleRequisitionsScreen({super.key, required this.id});

  @override
  ConsumerState<ViewSampleRequisitionsScreen> createState() => _ViewSampleRequisitionsScreenState();
}

class _ViewSampleRequisitionsScreenState extends ConsumerState<ViewSampleRequisitionsScreen> {
  
@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(sampleProvider.notifier);
    refNotifier.viewSampleRequiitionsApiFunction(context, id: widget.id);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final refState =ref.watch(sampleProvider);
    return Scaffold(  
       appBar: customAppBar(title: "Sample #${widget.id}"),
      body: (refState.viewSampleRequisitionsModel?.data?[0])!=null? SingleChildScrollView(
         padding: const EdgeInsets.only(top: 14,left: 18,right: 19,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusWidget(activities: refState.viewSampleRequisitionsModel?.data?[0].activities,),
            const SizedBox(height: 15,),
            _ItemRequestedWidget(refState: refState,),
            const SizedBox(height: 15,),
            RemarksWidget(
              isEditable: false,
              remarks: refState.viewSampleRequisitionsModel?.data?[0].remarks??'',
            )
          ],
        ),
      ):EmptyWidget(),
    );
  }
}

// ignore: must_be_immutable
class _ItemRequestedWidget extends StatelessWidget {
  SampleState refState;
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
    padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 10,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:!isExpanded?[]:  [
          BoxShadow(offset: Offset(0, 0),color: AppColors.black.withValues(alpha: .2),blurRadius: 10)
        ]
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
    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
              itemCount: (refState.viewSampleRequisitionsModel?.data?[0].sampReqItem?.length??0),
              itemBuilder: (ctx,index){
                var model = refState.viewSampleRequisitionsModel?.data?[0].sampReqItem?[index];
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
