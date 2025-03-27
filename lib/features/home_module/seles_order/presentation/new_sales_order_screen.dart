import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/view_sales_order_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_notifier.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/add_sales_order_state.dart';
import 'package:mohan_impex/features/home_module/seles_order/widget/item_selection_widget.dart';
import 'package:mohan_impex/features/home_module/seles_order/widget/sales_overview_widget.dart';
import 'package:mohan_impex/features/home_module/seles_order/widget/sales_registration_widget.dart';
import 'package:mohan_impex/res/app_colors.dart';
import '../../../../res/app_fontfamily.dart';

class NewSalesOrderScreen extends ConsumerStatefulWidget {
  final String route; 
  final ViewSalesItem? resumeItems;
  const NewSalesOrderScreen({super.key, required this.route, this.resumeItems});

  @override
  ConsumerState<NewSalesOrderScreen> createState() => _NewSalesOrderScreenState();
}

class _NewSalesOrderScreenState extends ConsumerState<NewSalesOrderScreen> {

  int tabBarIndex = 0;
  // bool isPreview = false;

   
 @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }
  callInitFunction(){
    final refNotifier = ref.read(addSalesOrderProvider.notifier);
    refNotifier.resetValues();
    if(widget.route == 'resume'){
      refNotifier.setResumeData(widget.resumeItems!);
      setState(() {
        
      });
    }
  }


  @override
  Widget build(BuildContext context) {
     final refNotifier = ref.read(addSalesOrderProvider.notifier);
    final refState = ref.watch(addSalesOrderProvider);
   
    return WillPopScope(
      onWillPop: ()async{
          _handleBackButton(refNotifier, refState); 
            return false;
      },
      child: Scaffold(
          appBar:customAppBar(title:appBarTitle(refState.tabBarIndex),
         isBackTap: (){
          _handleBackButton(refNotifier, refState); 
        },
        ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Form(
            key: refNotifier.formKey,
          child: Column(
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
                        SalesRegistrationWidget(refNotifer: refNotifier,refState: refState,) :
                         refState.tabBarIndex == 1 ? 
                         /// sales patch
                         ItemSelectionWidget(
                         ) :
                         /// overview
                         SalesOverviewWidget(
                          refNotifer: refNotifier,
                          refState: refState,
                         ),
                        //  OverviewWidget(
                        //   refNotifer: refNotifier,
                        //   refState: refState,
                        //  ),
          
                          const SizedBox(height: 30,),
                          
                          refState.tabBarIndex==0  ?
                          Align(
                    alignment: Alignment.center,
                    child: AppTextButton(title: "Next",color: AppColors.arcticBreeze,
                    height: 44,width: 120,onTap: (){
                      if(refState.tabBarIndex==0){
                        refNotifier.checkRegistrationValidation();
                      }
                    },
                    ),
                  ):
                  refState.tabBarIndex ==1 ?
                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                         alignment: Alignment.center,
                          child: AppTextButton(title:
                          "Previous",color: AppColors.arcticBreeze,
                          height: 44,width: 120,
                          onTap: (){
                            _handleBackButton(refNotifier, refState); 
                          },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AppTextButton(title: "Next",color: AppColors.arcticBreeze,
                    height: 44,width: 120,onTap: (){
                       refNotifier.checkSalesPitchValidation(context);
                    },
                    ),
                  )
                          ],
                        )
                      :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                         alignment: Alignment.center,
                          child: AppTextButton(title:
                          "Draft",color: AppColors.arcticBreeze,
                          height: 44,width: 120,
                          onTap: (){
                            refNotifier.checkOverViewValidation(context,actionType: "Draft",route: widget.route );
                          },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AppTextButton(title: "Submit",color: AppColors.arcticBreeze,
                    height: 44,width: 120,onTap: (){
                      refNotifier.checkOverViewValidation(context,actionType: "Submit",route: widget.route);
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

  tabbarWidget(AddSalesOrderState refState){
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
  updateTabBarIndex(){
    tabBarIndex = tabBarIndex+1;
    print(tabBarIndex);
    setState(() {
      
    });
  }


String appBarTitle(int index){
  switch (index) {
    case 0:
      return 'Sales Order';
      case 1:
      return "Submit";
    default:
    return 'Sales Order';
  }
  }
  String tabBarTitle(int index){
    switch (index) {
      case 0:
        return "Registration";
      case 1:
      return "Item selection";
      case 2:
      return "Overview";
      default:
      return "Registration";
    }
  }

  _handleBackButton(AddSalesOrderNotifier refNotifer, AddSalesOrderState refState){
    if(refState.tabBarIndex>0){
        refNotifer.deceraseTabBarIndex();
        }
        else{
          Navigator.pop(context);
        }
  }
}