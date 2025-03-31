import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/common_widgets/status_activity.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/presentation/trial_product_item_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';

class ViewTrialPlanScreen extends ConsumerStatefulWidget {
  final String id;
  const ViewTrialPlanScreen({super.key, required this.id});

  @override
  ConsumerState<ViewTrialPlanScreen> createState() => _ViewTrialPlanScreenState();
}

class _ViewTrialPlanScreenState extends ConsumerState<ViewTrialPlanScreen> {

@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(trialPlanProvider.notifier);
    refNotifier.viewTrialPlanApiFunction(context, id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
     final refState =ref.watch(trialPlanProvider);
    return Scaffold(
      appBar: customAppBar(title: widget.id),
      body: refState.viewTrialPlanModel?.data ==null? 
      EmptyWidget():
      SingleChildScrollView(
        padding: const EdgeInsets.only(top: 14,left: 19,right: 19,bottom: 20),
        child: Column(
          children: [
              StatusWidget(activities: refState.viewTrialPlanModel?.data?[0].activities,),
             const SizedBox(height: 15,),
             _TrialPlanDetailsWidget(refState: refState,),
             const SizedBox(height: 15,),
             _ItemRequestedWidget(refState: refState,),
             const SizedBox(height: 15,),
             RemarksWidget(
              isEditable: false,
              horizontalPadding: 17,
              remarks: refState.viewTrialPlanModel?.data?[0].remarksnotes ?? '',
             ),
             (refState.viewTrialPlanModel?.data?[0].conductBy ?? '').toString().toLowerCase() == 'tsm required'?
             Padding(
               padding: const EdgeInsets.only(top: 15),
               child: _AssignedPersonDetailsWidget(refState: refState),
             ): EmptyWidget()
          ],
        ),
      ),
    );
  }
}


class _AssignedPersonDetailsWidget extends StatelessWidget {
  final TrialPlanState refState;
  const _AssignedPersonDetailsWidget({required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false));
  }
  Widget collapsedWidget({required bool isExpanded}){
    return Container(
        padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 17,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Assigned Person',fontFamily: AppFontfamily.poppinsSemibold,),
              Icon(Icons.expand_less,color: AppColors.light92Color,),
        ],
      ),
   
    );
  }

  Widget expandedWidget({required bool isExpanded}){
    var model = refState.viewTrialPlanModel?.data?[0];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17,vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),

      ),
      child:
      Column(
        children: [
          collapsedWidget(isExpanded: isExpanded),
            const SizedBox(height: 10,),
            dotteDivierWidget(dividerColor: AppColors.edColor,),
             const SizedBox(height: 9,),
             (refState.viewTrialPlanModel?.data?[0].tsmInfo?.name) != null?
          Column(
            children: [
               itemsWidget("Name", model?.tsmInfo?.name ?? ''),
            const SizedBox(height: 16,),
            itemsWidget("Contact No.", model?.tsmInfo?.mobile?? ''),
            const SizedBox(height: 16,),
            itemsWidget("Email", model?.tsmInfo?.email?? ''),
            const SizedBox(height: 16,),
            ],
          ):
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AppText(title: "Not Assigned",fontFamily: AppFontfamily.poppinsMedium,fontsize: 15,),
          ),
          
          
        ],
      ));
  }

   Widget itemsWidget(String title, String subTitle){
    return Row(
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        AppText(title: subTitle,
        fontsize: 13,
        fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
      ],
    );
  }
}



class _TrialPlanDetailsWidget extends StatelessWidget {
  final TrialPlanState refState;
  const _TrialPlanDetailsWidget({required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false));
  }
  Widget collapsedWidget({required bool isExpanded}){
    return Container(
        padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 17,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Trial Plan Details',fontFamily: AppFontfamily.poppinsSemibold,),
              Icon(Icons.expand_less,color: AppColors.light92Color,),
        ],
      ),
   
    );
  }

  Widget expandedWidget({required bool isExpanded}){
    var model = refState.viewTrialPlanModel?.data?[0];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17,vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Column(
        children: [
          collapsedWidget(isExpanded: isExpanded),
            const SizedBox(height: 10,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
             itemsWidget("Vendor Name", (model?.customerName??'').isEmpty? (model?.unvCustomerName ?? ''): (model?.customerName??'')),
            const SizedBox(height: 16,),
            itemsWidget("Shop Name", model?.shopName?? ''),
            const SizedBox(height: 16,),
            itemsWidget("Contact", (model?.contact?.isEmpty ?? true) 
            ? '' 
           : model?.contact?.map((e) => e.contact).join(', ') ?? ''),
           const SizedBox(height: 16,),
            itemsWidget("Trial Type", model?.conductBy ?? ''),
            const SizedBox(height: 16,),
            itemsWidget("Trial Location", model?.trialLoc ?? ''),
            const SizedBox(height: 16,),
            itemsWidget("Trial Date :", model?.date ?? ''),
            const SizedBox(height: 16,),
            itemsWidget("Trial Time :", model?.time ?? ''),
            const SizedBox(height: 16,),
            itemsWidget("Customer Type : ", model?.customerLevel ?? ''),
            const SizedBox(height: 16,),
            itemsWidget("Type", model?.trialType ?? ''),
            const SizedBox(height: 16,),
             itemsWidget("Address Type", model?.addressTitle ?? ''),
            const SizedBox(height: 13,),
            itemsWidget("Address-1", model?.addressLine1 ?? ''),
            const SizedBox(height: 13,),
            itemsWidget("Address-2", model?.addressLine2 ?? ''),
            const SizedBox(height: 13,),
            itemsWidget("District", model?.district ?? ''),
            const SizedBox(height: 13,),
            itemsWidget("State", model?.state ?? ''),
            const SizedBox(height: 13,),
            itemsWidget("Pincode", (model?.pincode ?? '').toString()),
            const SizedBox(height: 13,),
            itemsWidget("Appointment Date", (model?.appointmentDate ?? '').toString()),
        
        ],
      )
    );
  }

   Widget itemsWidget(String title, String subTitle){
    return Row(
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        AppText(title: subTitle,
        fontsize: 13,
        fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
      ],
    );
  }
}


class _ItemRequestedWidget extends StatelessWidget {
  final TrialPlanState refState;
  const _ItemRequestedWidget({required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true),
     expandedWidget: expandedWidget(isExpanded: false));
  }

 Widget collapsedWidget({required bool isExpanded}){
  var model = refState.viewTrialPlanModel?.data?[0];
   return Container(
    padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 17,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title:(model?.trialType ?? '').toString().toLowerCase() == "product"? 'Trial Products' : "Trial Items",fontFamily: AppFontfamily.poppinsSemibold,),
              Icon(Icons.expand_less,color: AppColors.light92Color,),
        ],
      ),
   );
  }
  Widget expandedWidget({required bool isExpanded}){
    var model = refState.viewTrialPlanModel?.data?[0];
   return Container(
    padding: EdgeInsets.symmetric(horizontal: 17,vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          collapsedWidget(isExpanded: isExpanded),
           const SizedBox(height: 10,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
            headingWidget(model?.trialType ?? ''),
            const SizedBox(height: 7,),
            (model?.trialType ?? '').toString().toLowerCase() == "product"?
            productViewWidget() : itemViewWidget()
        ],
      ),
   );
  }

  headingWidget(String title){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.edColor,
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.symmetric(horizontal: 19,vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: AppText(title: title,fontsize: 12,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.oliveGray,)),
          SizedBox(
            width: 60,
            child: AppText(title: "Report",fontsize: 12,fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.oliveGray,),
          ),
        ],
      ),
    );
  }

  Widget productViewWidget(){
    var model = refState.viewTrialPlanModel?.data?[0];
    return   ListView.builder(
              
              itemCount: (model?.productTrialTable ?? []).length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx,index){
                var productModel = model?.productTrialTable?[index];
                return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: Column(
                children: [
                  index ==0 ? EmptyWidget() :
                  Container(
                    height: .5,
                    color: AppColors.edColor,
                    margin: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: (){
                      AppRouter.pushCupertinoNavigation(TrialProductItemScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(title: productModel?.product ?? '',fontWeight: FontWeight.w400,),
                        Container(
                          alignment: Alignment.center,
                          child: AppText(title: "pending",fontsize: 12,color: AppColors.mossGreyColor,fontWeight: FontWeight.w400,),)
                      ],
                    ),
                  ),
                ],
              ),
            );
            });
  }


  Widget itemViewWidget(){
    var model = refState.viewTrialPlanModel?.data?[0];
    return   ListView.separated(
              separatorBuilder: (ctx,sb){
                return const SizedBox(height: 15,);
              },
              itemCount: (model?.itemTrialTable ?? []).length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx,index){
                var productModel = model?.itemTrialTable?[index];
                return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: GestureDetector(
                onTap: (){
                  AppRouter.pushCupertinoNavigation(TrialProductItemScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: productModel?.itemName ?? '',fontWeight: FontWeight.w400,),
                    Container(
                      alignment: Alignment.center,
                      child: AppText(title: "pending",fontsize: 12,color: AppColors.mossGreyColor,),)
                  ],
                ),
              ),
            );
            });
  }

}
