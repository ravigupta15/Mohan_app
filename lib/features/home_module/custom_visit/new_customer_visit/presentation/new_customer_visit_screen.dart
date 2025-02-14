import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/book_trial_success_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/registration_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/sales_patch_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/overview_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class NewCustomerVisitScreen extends StatefulWidget {
  const NewCustomerVisitScreen({super.key});

  @override
  State<NewCustomerVisitScreen> createState() => _NewCustomerVisitScreenState();
}

class _NewCustomerVisitScreenState extends State<NewCustomerVisitScreen> {

int tabBarIndex = 0;
bool isCaptureImage= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar:customAppBar(title:
      tabBarIndex==0 || tabBarIndex==1?
       "New Customer Visit" : "Submit",
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
          decoration: ShapeDecoration(
            color: AppColors.edColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )),
            child: AppText(title: "1:30:22",fontFamily: AppFontfamily.poppinsMedium,),
        )
      ]
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tabbarWidget(),
            const SizedBox(height: 10,),
            Align(
                alignment: Alignment.center,
                child: AppText(title:
                tabBarIndex ==0 ?
                 'Registration' : 
                 tabBarIndex == 1 ?
                 "Sales Pitch" : "Overview"
                 
                 ,fontFamily: AppFontfamily.poppinsSemibold,)),
                const SizedBox(height: 20,),
                Expanded(child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 30,left: 18,right: 19),
                  child: Column(
                    children: [
                      tabBarIndex == 0 ? 
                  RegistrationWidget() :
                   tabBarIndex == 1 ? 
                   SalesPatchWidget() :
                   OverviewWidget(),
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
                    child: AppTextButton(title:isCaptureImage ? "Draft": "Previous",color: AppColors.arcticBreeze,
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
                AppRouter.pushCupertinoNavigation(const BookTrialSuccessScreen());
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

