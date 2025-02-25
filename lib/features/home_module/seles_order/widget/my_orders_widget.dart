import 'package:flutter/material.dart';
import 'package:mohan_impex/features/home_module/custom_visit/presentation/widgets/visit_item.dart';
import 'package:mohan_impex/features/home_module/seles_order/presentation/view_order_screen.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

class MyOrdersWidget extends StatelessWidget {
  const MyOrdersWidget({super.key});

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
            AppRouter.pushCupertinoNavigation(const ViewOrderScreen());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 9,vertical: 10),
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
        );
    });
  }
}