import 'package:flutter/material.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/widgets/complaint_items_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';

class ResolvedComplaintWidget extends StatelessWidget {
  const ResolvedComplaintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: 4,
      padding: EdgeInsets.only(top: 10,bottom: 20,left:17,right: 17),
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
          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ComplaintItemsWidget(
                        title:"Ticket #12345",
                        name: "Jane Smith",
                        date: "2025-01-01",reasonTitle: "Quality",),
                    ],
          ),
        );
    });
  }
}