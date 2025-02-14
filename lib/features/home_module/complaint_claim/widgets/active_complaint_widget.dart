import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/presentation/view_complaint_screen.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/widgets/complaint_items_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class ActiveComplaintWidget extends StatelessWidget {
  const ActiveComplaintWidget({super.key});

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
        return InkWell(
          onTap: (){
            AppRouter.pushCupertinoNavigation(const ViewComplaintScreen());
          },
          child: Container(
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
          ),
        );
    });
  }

kycWidget(){
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Container(
          height: 5,width: 5,
          decoration: BoxDecoration(
            color: AppColors.greenColor,shape: BoxShape.circle
          ),
        ),
        const SizedBox(width: 4,),
        AppText(title: "Pending : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: "ASM Review",fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
      ],
    ),
  );
}
}