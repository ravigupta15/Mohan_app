import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class SchemesManagementScreen extends StatefulWidget {
  const SchemesManagementScreen({super.key});

  @override
  State<SchemesManagementScreen> createState() => _SchemesManagementScreenState();
}

class _SchemesManagementScreenState extends State<SchemesManagementScreen> {

  int selectedRadio=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: customAppBar(title: "Scheme Management"),
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: AppSearchBar(
                hintText: "Search scheme",
                suffixWidget: Container(
                  alignment: Alignment.center,
                  width:  60,
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssetPaths.searchIcon),
                          Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 20,width: 1,color: AppColors.lightBlue62Color.withValues(alpha: .3),
                      ),
                       InkWell(
                        onTap: (){
                          filterBottomSheet(context);
                        },
                        child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                    ],
                  ),
                ),
              ),
            ),
         const SizedBox(height: 10,),
         Expanded(
           child: ListView.separated(
            separatorBuilder: (ctx,sb){
              return const SizedBox(height: 15,);
            },
            itemCount: 4,
            padding: EdgeInsets.only(top: 5,left: 17,right:  17,bottom: 30),
            shrinkWrap: true,
            itemBuilder: (ctx,index){
            return _SchemeWidget();
           }),
         )
        ],
       ),
    );
  }


  filterBottomSheet(BuildContext context){
  showModalBottomSheet(
    backgroundColor: AppColors.whiteColor,
    context: context, builder: (context){
    return Container(
       padding: EdgeInsets.only(top: 14,bottom: 20),
      child: StatefulBuilder(
        builder: (context,state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Padding(
                  padding: const EdgeInsets.only(right: 11),
                  child: Row(
                    children: [
                      const Spacer(),
                      AppText(title: "Filter",fontsize: 16,fontFamily: AppFontfamily.poppinsSemibold,),
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
                  padding: const EdgeInsets.only(left: 26,right: 26,top: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(title: "Scheme Category",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 28,),
                      Row(
                        children: [
                          customRadioButton(isSelected:selectedRadio==0? true:false, title: 'All',
                          onTap: (){
                            state(() {
                              selectedRadio=0;
                            });
                          }
                          ),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==1? true:false, title: 'Spot Scheme',
                          onTap: (){
                            state(() {
                              selectedRadio=1;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 28,),
                           Row(
                            children: [
                              customRadioButton(isSelected:selectedRadio==2? true:false, title: 'Monthly Trade',
                          onTap: (){
                            state(() {
                              selectedRadio=2;
                            });
                          }
                          ),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:selectedRadio==3? true:false, title: 'Speical Scheme',
                          onTap: (){
                            state(() {
                              selectedRadio=3;
                            });
                          }
                          ),
                            ],
                           ),
                     const SizedBox(height: 67,),
                       Align(
                  alignment: Alignment.center,
                  child: AppTextButton(title: "Apply",height: 35,width: 150,color: AppColors.arcticBreeze,),
                 )
                    ],
                  ),
                ),
                
            ],
          );
        }
      ),
    );
  });
}
}

class _SchemeWidget extends StatelessWidget {
  const _SchemeWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.only(bottom: 15),
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
            Padding(
              padding: const EdgeInsets.only(left: 17,right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(title: "SP1001",fontsize: 20,fontFamily: AppFontfamily.poppinsMedium,),
                        const SizedBox(height: 10,),
                        AppText(title: "Festive season discount",fontsize: 10,fontWeight: FontWeight.w300,)
                      ],
                    ),
                  ),
                  AppText(title: "10%",color: AppColors.greenColor,fontsize: 48,fontFamily: AppFontfamily.poppinsMedium,)
                ],
              ),
            ),
            Divider(
                  color: AppColors.edColor,
                ),
                const SizedBox(height: 5,),
                validWidget(),
                termsConditionWidget()
          ],
        ),
    );
  }

  validWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        children: [
          Row(
            children: [
              Container(
          height: 5,width: 5,
          decoration: BoxDecoration(
            color: AppColors.greenColor,shape: BoxShape.circle
          ),
        ),
        const SizedBox(width: 4,),
        AppText(title: "Valid till : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: "2025-10-20",fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
        const Spacer(),
        AppText(title: "Min Order : ",fontsize: 10,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.visitItem,),
        AppText(title: "10,000",fontsize: 10,fontFamily: AppFontfamily.poppinsRegular,color: AppColors.visitItem,),
            ],
          ),
          
        ],
      ),
    );
  }

  termsConditionWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 18,right: 8,top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title: "Terms Condition:",fontsize: 10,fontFamily: AppFontfamily.poppinsMedium,),
          const SizedBox(height: 6,),
          termsConditionItems("Application on all products"),
          const SizedBox(height: 6,),
          termsConditionItems("Cannot be combined with other offers"),
          const SizedBox(height: 6,),
          termsConditionItems("Subject to available stock"),
        ],
      ),
    );
  }

  termsConditionItems(String title){
    return Row(
      children: [
        Container(
          height: 4,width:4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.light92Color
          ),
        ),
        const SizedBox(width: 5,),
        AppText(title: title,fontsize: 10,)
      ],
    );
  }
}