import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/common_widgets/status_activity.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/riverpod/sample_notifier.dart';
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
    final refNotifier = ref.read(sampleProvider.notifier);
    return Scaffold(  
       appBar: customAppBar(title: widget.id),
      body: (refState.viewSampleRequisitionsModel?.data?[0])!=null? SingleChildScrollView(
         padding: const EdgeInsets.only(top: 14,left: 18,right: 19,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusWidget(activities: refState.viewSampleRequisitionsModel?.data?[0].activities,
            buttonWidget: (refState.viewSampleRequisitionsModel?.data?[0].workflowState ?? '').toString().toLowerCase() == 'approved'?
             receivedButtonWidget(refNotifier) : EmptyWidget(),
            ),
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

  Widget receivedButtonWidget(SampleNotifier refNotifier){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: (){
          dialogBox(refNotifier);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.black1.withValues(alpha: .3)
            )
          ),
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: AppText(title: "Received",
          color: AppColors.black,fontFamily: AppFontfamily.poppinsSemibold,
          ),
        ),
      ),
    );
  }


dialogBox(SampleNotifier refNotifier) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 20, right: 20, bottom: 33),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: "Received",
                    color: AppColors.black,
                    fontsize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 25,),
                  Align(
                    alignment: Alignment.center,
                    child: AppText(
                      title:"Are you sure you want to received?",
                      fontsize: 14,
                      fontFamily: AppFontfamily.poppinsMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Flexible(
                        child: AppTextButton(
                            title: "No",
                            height: 50,
                            color: AppColors.redColor,
                            width: double.infinity,
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ),
                      const SizedBox(width: 20,),
                      Flexible(
                        child: AppTextButton(
                            title: "Yes",
                            height: 50,
                            width: double.infinity,
                            onTap: (){
                              Navigator.pop(context);
                              refNotifier.createCommentApiFunction(context, id: widget.id);
                              // ref.read(appNavigationProvider.notifier).logoutApiFunction(context);
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
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
    padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        // border: Border.all(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          collapsedWidget(isExpanded: isExpanded),
           const SizedBox(height: 8,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 8,),
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
