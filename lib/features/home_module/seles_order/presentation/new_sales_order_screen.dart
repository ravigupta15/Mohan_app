import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/seles_order/widget/item_selection_widget.dart';
import 'package:mohan_impex/features/home_module/seles_order/widget/sales_registration_widget.dart';
import 'package:mohan_impex/features/home_module/seles_order/widget/submit_sales_order_widget.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';
import '../../../../res/app_fontfamily.dart';

class NewSalesOrderScreen extends StatefulWidget {
  const NewSalesOrderScreen({super.key});

  @override
  State<NewSalesOrderScreen> createState() => _NewSalesOrderScreenState();
}

class _NewSalesOrderScreenState extends State<NewSalesOrderScreen> {

  int tabBarIndex = 0;
  bool isPreview = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:customAppBar(title:
       isPreview ? "Preview" : "Sales Order",
      ),
    body: Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          tabbarWidget(),
          const SizedBox(height: 10,),
            Align(
                alignment: Alignment.center,
                child: AppText(title:
                tabBarIndex ==0 ?
                 'Registration' : 
                 tabBarIndex == 1 ?
                 "item Selection" : "Overview" 
                 ,fontFamily: AppFontfamily.poppinsSemibold,)),
              const SizedBox(height: 20,),
                Expanded(child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 30,left: 16,right: 16),
                  child: Column(
                    children: [
                      tabBarIndex == 0 ? 
                  SalesRegistrationWidget() :
                   tabBarIndex == 1 ? 
                   ItemSelectionWidget() :
                   SubmitSalesOrderWidget(isPreview:isPreview),
                    const SizedBox(height: 30,),
                    tabBarIndex==0 || tabBarIndex ==1 ?
                    Align(
              alignment: Alignment.center,
              child: AppTextButton(title: "Next",color: AppColors.arcticBreeze,
              height: 44,width: 120,onTap: (){
                 updateTabBarIndex();
              },
              ),
            ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                   alignment: Alignment.center,
                    child: AppTextButton(title:
                    isPreview ? "Draft":
                     "Previous",color: AppColors.arcticBreeze,
                    height: 44,width: 120,
                    onTap: (){
                      // Navigator.pop(context);
                    },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AppTextButton(title: "Submit",color: AppColors.arcticBreeze,
              height: 44,width: 120,onTap: (){
                if(isPreview){
                  AppRouter.pushCupertinoNavigation( SuccessScreen(title: '', btnTitle: "Home", 
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }, des: 'You have successfully submitted Quotation'));
                }
                else{
                  isPreview=true;
                setState(() {
                });
                }
                // AppRouter.pushCupertinoNavigation(const BookTrialSuccessScreen());
              },
              ),
            )
                    ],
                  )
                    ],
                  ),
                ))
        
            
        ],
      ),
    ),
    );
  }

  tabbarWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _roundedContainer(bgColor: tabBarIndex == 0 ? AppColors.black : AppColors.greenColor,borderColor: tabBarIndex == 0 ? AppColors.black : AppColors.greenColor),

        Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: _divider(AppColors.greenColor),),

        _roundedContainer(bgColor:tabBarIndex == 1 ? AppColors.black:
        tabBarIndex >1 ? AppColors.greenColor :
         AppColors.whiteColor,borderColor : tabBarIndex == 1 ? AppColors.black:
        tabBarIndex >1 ? AppColors.greenColor : AppColors.lightTextColor),
        
        Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: _divider(tabBarIndex>=1?AppColors.greenColor: AppColors.lightTextColor),),

        _roundedContainer(bgColor:tabBarIndex>=2?AppColors.black: AppColors.whiteColor,borderColor:
        tabBarIndex >=2 ? AppColors.black:
         AppColors.lightTextColor),
      ],
    );
  }

_divider(Color color){
  return Container(
width: 50,color: color,height: 1,
  );
}
 _roundedContainer({required Color bgColor, required Color borderColor}){
    return Container(
      height: 16,width: 16,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: bgColor,
        shape: BoxShape.circle
      ),
    );
  }




 ////// HELPER METHOD
  updateTabBarIndex(){
    tabBarIndex = tabBarIndex+1;
    print(tabBarIndex);
    setState(() {
      
    });
  }
}