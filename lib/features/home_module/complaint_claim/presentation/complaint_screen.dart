import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/custom_tabbar.dart';
import 'package:mohan_impex/core/widget/floating_action_button_widget.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/presentation/add_complaint_screen.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/riverpod/add_complaint_state.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/widgets/active_complaint_widget.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/widgets/resolved_complaint_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class ComplaintScreen extends ConsumerStatefulWidget {
  const ComplaintScreen({super.key});

  @override
  ConsumerState<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends ConsumerState<ComplaintScreen> {

 @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(addComplaintsProvider.notifier);
    refNotifier.complaintListApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(addComplaintsProvider.notifier);
    final refstate = ref.watch(addComplaintsProvider);
    return Scaffold(
      appBar: customAppBar(title: "Complaints & Claim"),
      body: Padding(
       padding: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: AppSearchBar(
                hintText: "Search by ticket number",
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
                          // filterBottomSheet(context,refstate);
                        },
                        child: SvgPicture.asset(AppAssetPaths.filterIcon)),
                     
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 25),
               child: CustomTabbar(
                currentIndex:refstate.tabBarIndex,
                title1: "Active",
                title2: "Resolved",
                onClicked1: (){
                  refNotifier.updateTabBarIndex(0);
                },
                onClicked2: (){
                  refNotifier.updateTabBarIndex(1);
                },
              ),
             ),
            const SizedBox(height: 10,),
            Expanded(child:refstate.tabBarIndex==0?
            ActiveComplaintWidget(refNotifer: refNotifier,refState: refstate,):ResolvedComplaintWidget(refNotifer: refNotifier,refState: refstate,)
            )
          ],
        ),
      ),
      floatingActionButton: floatingActionButtonWidget(onTap: (){
        AppRouter.pushCupertinoNavigation(const AddComplaintScreen()).then((val){
         if((val??false)==true){
            refNotifier.updateTabBarIndex(0);
            refNotifier.complaintListApiFunction();
          }
        });
      }),
    );
  }

  filterBottomSheet(BuildContext context, AddComplaintState refstate){
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
                  padding: const EdgeInsets.only(left: 25,right: 25,top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(title: "Select Date",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),
                      AppDateWidget(),
                      const SizedBox(height: 15,),
                      AppText(title: "Nature of Travel",fontFamily: AppFontfamily.poppinsSemibold,),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          customRadioButton(isSelected:refstate.selectedRadio==0? true:false, title: 'All',
                          onTap: (){
                            state(() {
                             refstate. selectedRadio=0;
                            });
                          }
                          ),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:refstate.selectedRadio==1? true:false, title: 'Quality',
                          onTap: (){
                            state(() {
                              refstate.selectedRadio=1;
                            });
                          }),
                          const SizedBox(width: 15,),
                          customRadioButton(isSelected:refstate.selectedRadio==2? true:false, title: 'Transit',
                          onTap: (){
                            state(() {
                              refstate.selectedRadio=2;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 25,),
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