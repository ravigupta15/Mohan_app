import 'package:flutter/material.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/widgets/journey_plan_items_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';

class JourneyApprovedWidget extends StatelessWidget {
  final String title;
  const JourneyApprovedWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: 4,
      padding: EdgeInsets.only(top: 10,bottom: 20,left: 17,right: 17),
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withValues(alpha: .2),
                blurRadius: 3
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JourneyPlanItemsWidget(
                  title:title,
                  ),
              ],
            ),
          ),
        );
    });
  }

}