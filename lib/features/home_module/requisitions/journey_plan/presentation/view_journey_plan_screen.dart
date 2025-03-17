import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/status_activity.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/view_journey_plan_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/riverpod/journey_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';

// ignore: must_be_immutable
class ViewJourneyPlanScreen extends ConsumerStatefulWidget {
  String id;
   ViewJourneyPlanScreen({super.key, required this.id});

  @override
  ConsumerState<ViewJourneyPlanScreen> createState() => _ViewJourneyPlanScreenState();
}

class _ViewJourneyPlanScreenState extends ConsumerState<ViewJourneyPlanScreen> {

@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    ref.read(journeyProvider.notifier).viewJourneyPlanApiFunction(context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final refState =ref.watch(journeyProvider);
    return Scaffold(
      appBar: customAppBar(title: "Journey Plan #${widget.id}"),
      body: (refState.viewJounreyPlanModel?.message)!=null? SingleChildScrollView(
        padding: const EdgeInsets.only(top: 14,left: 15,right: 15,bottom: 20),
        child: Column(
          children: [
            StatusWidget(activities: refState.viewJounreyPlanModel?.data?[0].activities,),
            const SizedBox(height: 15,),
            _VisitInformationWidget(model: refState.viewJounreyPlanModel?.data?[0],)
          ],
        ),
      ): EmptyWidget(),
    );
  }
}

// ignore: must_be_immutable
class _VisitInformationWidget extends StatelessWidget {
  JourneyDetailsModel? model;
   _VisitInformationWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false));
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
              AppText(title: 'Visit Information',fontFamily: AppFontfamily.poppinsSemibold,),
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
            itemsWidget("Visit Date", "${model?.visitFromDate??''} - ${model?.visitToDate??''}"),
            const SizedBox(height: 16,),
            itemsWidget("Nature of Travel", model?.natureOfTravel??""),
            const SizedBox(height: 16,),
            itemsWidget("Night Out Location",model?.nightOutLocation??""),
            const SizedBox(height: 16,),
            itemsWidget("Travel To State", model?.travelToState??""),
            const SizedBox(height: 16,),
            itemsWidget("Travel To District", model?.travelToDistrict??""),
            const SizedBox(height: 16,),
            itemsWidget("Mode of Travel", model?.modeOfTravel??""),
            const SizedBox(height: 16,),
            itemsWidget("Remarks", ''),
            
        ],
      )
    );
  }

   Widget itemsWidget(String title, String subTitle){
    return Row(
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        AppText(title: subTitle,
        fontsize: 13,
        fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
      ],
    );
  }
}