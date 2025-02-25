import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/features/home_module/custom_visit/presentation/widgets/visit_item.dart';
import 'package:mohan_impex/features/home_module/my_customers/presentation/view_customer_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class MyCustomerScreen extends StatefulWidget {
  const MyCustomerScreen({super.key});

  @override
  State<MyCustomerScreen> createState() => _MyCustomerScreenState();
}

class _MyCustomerScreenState extends State<MyCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: customAppBar(title: 'My Customers'),
       body: Padding(
         padding: const EdgeInsets.only(top: 14),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 18),
           child: AppSearchBar(
                hintText: "Search customer",
                suffixWidget: Container(
                  alignment: Alignment.center,
                  width: 60,
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssetPaths.searchIcon),
                        Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 20,width: 1,color: AppColors.lightBlue62Color.withValues(alpha: .3),
                      ),
                       GestureDetector(
                        onTap: (){
                          filterBottomSheet();
                        },
                        child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                     
                    ],
                  ),
                ),
              ),
         ),
            const SizedBox(height: 16,),
            selectedFiltersWidget(),
             Expanded(child: ListView.separated(
              separatorBuilder: (ctx,sb){
                return const SizedBox(height: 15,);
              },
              itemCount: 5,
              padding: EdgeInsets.only(top: 20,bottom: 20,left: 18,right: 18),
              shrinkWrap: true,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    AppRouter.pushCupertinoNavigation(const ViewCustomerScreen());
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [ 
                  VisitItem(title: 'Customer name', subTitle: 'Ramesh'),
                    const SizedBox(height: 9,),
                  VisitItem(title: 'Shop name', subTitle: 'Ammas Bakery'),
                      const SizedBox(height: 9,),
                      VisitItem(title:"Contact",subTitle: '7019405678'),
                      const SizedBox(height: 9,),
                      VisitItem(title:"Location",subTitle: 'Bangalore 560044'),
                                ],
                              ),
                  ),
                );
             }))
          ],
         ),
       ),
    );
  }

  Widget selectedFiltersWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          customFiltersUI("Class A"),
          const SizedBox(width: 15,),
          customFiltersUI("Bakery"),
        ],
      ),
    );
  }
  
  customFiltersUI(String title){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greenColor),
        borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.symmetric(horizontal: 9,vertical: 2),
      child: AppText(title: title,fontFamily: AppFontfamily.poppinsSemibold,fontsize: 13,),
    );
  }

  filterBottomSheet(){
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      isScrollControlled: true,
      context: context, builder: (context){
      return _FilterWidget();
    });
  }
}

class _FilterWidget extends StatefulWidget {
  const _FilterWidget();

  @override
  State<_FilterWidget> createState() => __FilterWidgetState();
}

class __FilterWidgetState extends State<_FilterWidget> {

  int segmentIndex =0;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 14,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 11),
              child: Row(
                children: [
                  const Spacer(),
                  AppText(title: "Filter Customers",fontsize: 16, fontFamily: AppFontfamily.poppinsSemibold,),
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 24,width: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.edColor,
                        shape: BoxShape.circle
                      ),
                      child: Icon(Icons.close,size: 19,),
                    ),
                  )
                ],
              ),
            ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const SizedBox(height: 25,),
              segmentWidge(),
              const SizedBox(height: 10,),
              AppText(title: "SKU",fontFamily: AppFontfamily.poppinsSemibold,fontsize: 12,),
              const SizedBox(height: 5,),
              AppTextfield(fillColor: false,suffixWidget: Container(
                child: Icon(Icons.keyboard_arrow_down),
              ),),
              const SizedBox(height: 10,),
              AppText(title: "Class",fontFamily: AppFontfamily.poppinsSemibold,fontsize: 12,),
              const SizedBox(height: 5,),
              AppTextfield(fillColor: false,suffixWidget: Container(
                child: Icon(Icons.keyboard_arrow_down),
              ),),
              const SizedBox(height: 10,),
              AppText(title: "Item group",fontFamily: AppFontfamily.poppinsSemibold,fontsize: 12,),
              const SizedBox(height: 5,),
              AppTextfield(fillColor: false,suffixWidget: Container(
                child: Icon(Icons.keyboard_arrow_down),
              ),),
              const SizedBox(height: 10,),
              AppText(title: "Location",fontFamily: AppFontfamily.poppinsSemibold,fontsize: 12,),
              const SizedBox(height: 5,),
              AppTextfield(fillColor: false,suffixWidget: Container(
                child: Icon(Icons.keyboard_arrow_down),
              ),),
              const SizedBox(height: 10,),
              AppText(title: "Date",fontFamily: AppFontfamily.poppinsSemibold,fontsize: 12,),
              const SizedBox(height: 5,),
                Row(
                children: [
                  AppDateWidget(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: 8,height: 2,
                    color: AppColors.black,
                  ),
                   AppDateWidget(),
                ],
              ),
              const SizedBox(height: 10,),
              AppText(title: "Zero billing",fontFamily: AppFontfamily.poppinsSemibold,fontsize: 12,),
              const SizedBox(height: 5,),
              AppTextfield(fillColor: false,suffixWidget: Container(
                child: Icon(Icons.keyboard_arrow_down),
              ),),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: AppTextButton(title: "Apply",
                width: 150,height: 30,color: AppColors.arcticBreeze,
                ),
              )
              ],
             ),
           )
        ],
      ),
    );
  }

 
  Widget segmentWidge(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "Segment",fontFamily: AppFontfamily.poppinsSemibold,),
        const SizedBox(height: 15,),
         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customRadioButton(isSelected:segmentIndex==0? true:false, title: "All",onTap: (){
            segmentIndex=0;
            setState(() {
            });
          }),
          customRadioButton(isSelected: segmentIndex==1? true:false, title: "Primary",onTap: (){
            segmentIndex=1;
            setState(() {
            });
          }),
          customRadioButton(isSelected: segmentIndex==2? true:false, title: "Secondary",onTap: (){
            segmentIndex=2;
            setState(() {
            });
          }),
        ],
      ),
      ],
    );
  }
}