import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/features/home_module/custom_visit/customer_visit_history/widget/visit_item.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_details/presentation/visit_details_screen.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class MyVisitWidget extends StatelessWidget {
  const MyVisitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (ctx,sb){
        return const SizedBox(height: 15,);
      },
      itemCount: 4,
      padding: EdgeInsets.only(top: 10,bottom: 20),
      shrinkWrap: true,
      itemBuilder: (ctx,index){
        return InkWell(
          onTap: (){
            AppRouter.pushCupertinoNavigation(const VisitDetailsScreen());
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
                  blurRadius: 6
                )
              ]
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    children: [
                      Image.asset('assets/dummy/shop.png',height: 64,),
                      const SizedBox(width: 13,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VisitItem(title: 'Shop name', subTitle: 'Ammas Bakery'),
                          const SizedBox(height: 9,),
                          VisitItem(title:"Contact",subTitle: '7019405678'),
                          const SizedBox(height: 9,),
                          VisitItem(title:"Location",subTitle: 'Bangalore 560044'),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Divider(
                    color: AppColors.edColor,
                  ),
                ),
                 kycWidget()
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
        AppText(title: "KYC : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: "Pending",fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
      ],
    ),
  );
}
}