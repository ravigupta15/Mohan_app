import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/status_activity.dart';
import 'package:mohan_impex/features/home_module/custom_visit/visit_draft_details/widgets/product_widget.dart';
import 'package:mohan_impex/features/home_module/seles_order/presentation/new_sales_order_screen.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/sales_order_state.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import '../../../../core/widget/app_text.dart';
import '../../../../core/widget/custom_slider_widget.dart';
import '../../../../res/app_colors.dart';

class ViewOrderScreen extends ConsumerStatefulWidget {
  final String id;
  final bool isDraft;
  const ViewOrderScreen({required this.id, required this.isDraft});

  @override
  ConsumerState<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends ConsumerState<ViewOrderScreen> {

 @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(salesOrderProvider.notifier);
    refNotifier.viewSalesApiFunction(context, widget.id);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(salesOrderProvider);
    final refNotifier = ref.read(salesOrderProvider.notifier);
    return Scaffold(
        appBar: customAppBar(title: "Sales Order",
      actions: [
        (refState.viewSalesOrderModel?.data?[0].workflowState ?? '').isEmpty?
        EmptyWidget():
        Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.greenColor,width: .5)),
            child: AppText(title:(refState.viewSalesOrderModel?.data?[0].workflowState ?? ''),fontsize: 9,),
        )
      ]
      ),
      body: (refState.viewSalesOrderModel?.data?[0])!=null ? SingleChildScrollView(
          padding: const EdgeInsets.only(top: 12,left: 17,right: 17,bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             ProductWidget(refState: refState,),
             const SizedBox(height: 15,),
             _AdditionalDetailsWidget(refState: refState,),
             Padding(
               padding: const EdgeInsets.only(top: 15),
               child: StatusWidget(activities: refState.viewSalesOrderModel?.data?[0].activities),
             ),
             const SizedBox(height: 15,),
             widget.isDraft?
             Align(
              alignment: Alignment.center,
              child: AppTextButton(title: "Resume",color: AppColors.arcticBreeze,
              width: 180,height: 40,
              onTap: (){
                AppRouter.pushCupertinoNavigation(NewSalesOrderScreen(
                  route: 'resume',
                  resumeItems: refState.viewSalesOrderModel?.data?[0],
                  )).then((val){
                    refNotifier.viewSalesApiFunction(context, widget.id);
                  });
                
              },
              ),
            ): EmptyWidget()
          ],
        ),
      ): EmptyWidget(),
    );
  }
}

class _AdditionalDetailsWidget extends StatelessWidget {
  final SalesOrderState refState;
   _AdditionalDetailsWidget({required this.refState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "Additional Details",fontFamily: AppFontfamily.poppinsSemibold,),
          const SizedBox(height: 14,),
           _DealTypeWidget(refState: refState,),
           const SizedBox(height: 14,),
           _CustomInfoWidget(refState: refState,),           
      ],
    );
  }
}




class _CustomInfoWidget extends StatelessWidget {
  final SalesOrderState refState;
  _CustomInfoWidget({ required this.refState});

  @override
  Widget build(BuildContext context) { 
    return ExpandableWidget(
        initExpanded: true,
        collapsedWidget: collapsedWidget(isExpanded: true),
        expandedWidget: expandedWidget(isExpanded: false));
  }

  collapsedWidget({required bool isExpanded}) {
    return Container(
      padding: !isExpanded
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
         ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title: 'Customer Information',
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
          Icon(
            !isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.light92Color,
          ),
        ],
      ),
    );
  }

  Widget expandedWidget({required bool isExpanded}) {
     var model = refState.viewSalesOrderModel?.data?[0];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
         ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          const SizedBox(
            height: 10,
          ),
           itemsWidget("Vendor Name", model?.customerName??''),
            const SizedBox(height: 20,),
            itemsWidget("Shop Name", model?.shopName??''),
            (model?.channelPartner??'').isNotEmpty?
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: itemsWidget("Channel Partner", model?.channelPartner??''),
            ):EmptyWidget(),
            const SizedBox(height: 20,),
            itemsWidget("Contact", model?.contact??''),
            const SizedBox(height: 20,),
            itemsWidget("Delivery Date", model?.deliveryDate??''),
            const SizedBox(height: 20,),
            itemsWidget("Visit Type", model?.customerLevel??''),
            const SizedBox(height: 20,),
            itemsWidget("Details edit needed", (model?.custEditNeeded??'').toString() == '1'?"Yes":"No"),
        ],
      ),
    );
  }

  Widget itemsWidget(String title, String subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: "$title : ",
          fontFamily: AppFontfamily.poppinsRegular,
        ),
        Expanded(
          child: AppText(
            title: subTitle,
            fontsize: 13,
            fontFamily: AppFontfamily.poppinsRegular,
            color: AppColors.lightTextColor,
          ),
        ),
      ],
    );
  }
}

class _DealTypeWidget extends StatelessWidget {
  final SalesOrderState refState;
  const _DealTypeWidget({required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false));
  }

  collapsedWidget({required bool isExpanded}){
    return Container(
      padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(
            text: "Deal Type",
            style: TextStyle(
             fontFamily: AppFontfamily.poppinsSemibold,color: AppColors.black1 
            ),
            children: [
              TextSpan(
                text: "*",style: TextStyle(
                  color: AppColors.redColor,fontFamily: AppFontfamily.poppinsSemibold
                )
              )
            ]
          )),
            Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
    );
  }

  expandedWidget({required bool isExpanded}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 15,),
          CustomSliderWidget(value:double.parse(refState.viewSalesOrderModel?.data?[0].dealType ?? '0'),isEnable: false,)
        ],
      ),
    );
  }
}
