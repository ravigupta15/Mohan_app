import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/registration_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/sales_patch_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/overview_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/timer_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class NewCustomerVisitScreen extends ConsumerStatefulWidget {
  const NewCustomerVisitScreen({super.key});

  @override
  ConsumerState<NewCustomerVisitScreen> createState() => _NewCustomerVisitScreenState();
}

class _NewCustomerVisitScreenState extends ConsumerState<NewCustomerVisitScreen> {

bool isCaptureImage= false;

@override
  void initState() {
    Future.microtask((){
      callInitFuntion();
    });
    super.initState();
  }


callInitFuntion(){
  ref.read(newCustomVisitProvider.notifier).resetValues();
  ref.read(newCustomVisitProvider.notifier).startTimer();
  ref.read(newCustomVisitProvider.notifier).competitorApiFunction(context);
  // ref.read(newCustomVisitProvider.notifier).itemsApiFunction(context);
  ref.watch(newCustomVisitProvider).visitStartDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString();
}

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(newCustomVisitProvider.notifier);
    final refState = ref.watch(newCustomVisitProvider);
    return WillPopScope(
      onWillPop: ()async{
       _handleBackButton(refNotifier, refState); 
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar:customAppBar(title:appBarTitle(refState.tabBarIndex),
        isBackTap: (){
          _handleBackButton(refNotifier, refState); 
        },
        actions: [
          timerWidget(refState.currentTimer)
         ]
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Form(
            key: refNotifier.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tabbarWidget(refState),
                const SizedBox(height: 10,),
                Align(
                    alignment: Alignment.center,
                    child: AppText(title: tabBarTitle(refState.tabBarIndex)
                     ,fontFamily: AppFontfamily.poppinsSemibold,)),
                    const SizedBox(height: 20,),
                    Expanded(
                      child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 30,left: 18,right: 19),
                      child: Column(
                        children: [

                         refState.tabBarIndex == 0 ? 
                         /// registration 
                      RegistrationWidget(refNotifer: refNotifier,refState: refState,) :
                       refState.tabBarIndex == 1 ? 
                       /// sales patch
                       SalesPatchWidget(
                        refNotifer: refNotifier,refState: refState,
                       ) :
                       /// overview
                       OverviewWidget(
                        refNotifer: refNotifier,
                        refState: refState,
                       ),

                        const SizedBox(height: 30,),
                        
                        refState.tabBarIndex==0 || refState.tabBarIndex ==1 ?
                        Align(
                  alignment: Alignment.center,
                  child: AppTextButton(title: "Next",color: AppColors.arcticBreeze,
                  height: 44,width: 120,onTap: (){
                    if(refState.tabBarIndex==0){
                      refNotifier.checkRegistrationValidation();
                    }
                    else if(refState.tabBarIndex==1){
                      refNotifier.checkSalesPitchValidation(context);
                     }
                     else if(refState.tabBarIndex==2){
                      
                     }
                  },
                  ),
                ):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                       alignment: Alignment.center,
                        child: AppTextButton(title:
                        refState.captureImageList.length>1?
                        "Draft": "Previous",color: AppColors.arcticBreeze,
                        height: 44,width: 120,
                        onTap: (){
                          if(refState.captureImageList.length>1){
                            refNotifier.checkOverViewValidation(context,actionType: "Draft" );
                          }
                          else{
                            _handleBackButton(refNotifier, refState); 
                          }
                          // Navigator.pop(context);
                        },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: AppTextButton(title: "Submit",color: AppColors.arcticBreeze,
                  height: 44,width: 120,onTap: (){
                    refNotifier.checkOverViewValidation(context,actionType: "Submit");
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
        ),
      ),
    );
  }

  tabbarWidget(NewCustomerVisitState refState){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _roundedContainer(bgColor: refState.tabBarIndex == 0 ? AppColors.black : AppColors.greenColor,borderColor: refState.tabBarIndex == 0 ? AppColors.black : AppColors.greenColor),

        Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: _divider(AppColors.greenColor),),

        _roundedContainer(bgColor:refState.tabBarIndex == 1 ? AppColors.black:
        refState.tabBarIndex >1 ? AppColors.greenColor :
         AppColors.whiteColor,borderColor : refState.tabBarIndex == 1 ? AppColors.black:
        refState.tabBarIndex >1 ? AppColors.greenColor : AppColors.lightTextColor),
        
        Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: _divider(refState.tabBarIndex>=1?AppColors.greenColor: AppColors.lightTextColor),),

        _roundedContainer(bgColor:refState.tabBarIndex>=2?AppColors.black: AppColors.whiteColor,borderColor:
        refState.tabBarIndex >=2 ? AppColors.black:
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
  

 String appBarTitle(int index){
  switch (index) {
    case 0:
      return 'New Customer Visit';
      case 1:
      return "Submit";
    default:
    return 'New Customer Visit';
  }
  }

  String tabBarTitle(int index){
    switch (index) {
      case 0:
        return "Registration";
      case 1:
      return "Sales Pitch";
      case 2:
      return "Overview";
      default:
      return "Registration";
    }
  }

  _handleBackButton(NewCustomerVisitNotifier refNotifer, NewCustomerVisitState refState){
    if(refState.tabBarIndex>0){
        refNotifer.deceraseTabBarIndex();
        }
        else{
          Navigator.pop(context);
        }
  }
}

