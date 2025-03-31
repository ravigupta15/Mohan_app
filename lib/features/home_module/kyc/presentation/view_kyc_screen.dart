import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/kyc/model/view_kyc_model.dart';
import 'package:mohan_impex/features/home_module/kyc/riverpod/kyc_state.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/empty_widget.dart';

import '../../../../core/widget/app_text_field/label_text_textfield.dart';
import '../../../common_widgets/status_activity.dart';

class ViewKycScreen extends ConsumerStatefulWidget {
  final String id;
  const ViewKycScreen({super.key, required this.id});

  @override
  ConsumerState<ViewKycScreen> createState() => _ViewKycScreenState();
}

class _ViewKycScreenState extends ConsumerState<ViewKycScreen> {

    
@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(kycProvider.notifier);
    refNotifier.viewKycpiFunction(context, id: widget.id);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(kycProvider);
    return Scaffold(
       appBar: customAppBar(title: "Kyc #${widget.id}"),
        body: (refState.viewKycModel?.data?[0])!=null? SingleChildScrollView(
         padding: const EdgeInsets.only(top: 14,left: 18,right: 19,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusWidget(activities:  refState.viewKycModel?.data?[0].activities,),
            const SizedBox(height: 15,),
            _CustomInfoWidget(refState: refState),
            const SizedBox(height: 15,),
            _DocumentCheckListWidget(refState: refState),
            (refState.viewKycModel?.data?[0].customerDetails ?? '').isEmpty?
            EmptyWidget():
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: RemarksWidget(
                remarks: refState.viewKycModel?.data?[0].customerDetails ??'',
                isEditable: false,
              ),
            )
          ],
        ),
      ):EmptyWidget(),
    );
  }
}


class _CustomInfoWidget extends StatelessWidget {
  final KycState refState;
   _CustomInfoWidget({required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
        initExpanded: true,
        collapsedWidget: collapsedWidget(
          isExpanded: true,
        ),
        expandedWidget: expandedWidget(isExpanded: false));
  }

  Widget collapsedWidget({required bool isExpanded}) {
    return Container(
      padding: isExpanded
          ? EdgeInsets.symmetric(horizontal: 10, vertical: 14)
          : EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                  title: "Customer Information",
                  fontFamily: AppFontfamily.poppinsSemibold),
              Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.light92Color),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          !isExpanded
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(34, (index) {
                    return Container(
                      width: 8.5,
                      // Width of each dash
                      height: 2,
                      // Line thickness
                      color: index % 2 == 0
                          ? AppColors.edColor
                          : Colors.transparent,
                      // Alternating between black and transparent
                      margin: EdgeInsets.symmetric(
                          horizontal: 0), // Spacing between dashes
                    );
                  }),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget expandedWidget({required bool isExpanded}) {
    var model = refState.viewKycModel?.data?[0];
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
          const SizedBox(height: 10),
          itemsWidget("Customer Type", model?.customerType??''),
         const SizedBox(height: 10),          
          itemsWidget("Customer Name", model?.customerName??''),
          const SizedBox(height: 10),
          itemsWidget("Contact", (model?.contact?.isEmpty ?? true) 
    ? '' 
    : model?.contact?.map((e) => e).join(', ') ?? ''),
          const SizedBox(height: 10),
          itemsWidget("Email", model?.emailId??''),
          const SizedBox(height: 10),
          itemsWidget("Business name", model?.customShop??''),
          const SizedBox(height: 10),
          itemsWidget("Segment", model?.marketSegment??''),       
             const SizedBox(height: 10),
          itemsWidget("Shipping address title",(model?.shippingAddress??[]).isNotEmpty?(model?.shippingAddress?[0].addressTitle??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Shipping address-1",(model?.shippingAddress??[]).isNotEmpty?(model?.shippingAddress?[0].addressLine1??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Shipping address-2",(model?.shippingAddress??[]).isNotEmpty? (model?.shippingAddress?[0].addressLine2??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Shipping District",(model?.shippingAddress??[]).isNotEmpty? (model?.shippingAddress?[0].city??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Shipping state",(model?.shippingAddress??[]).isNotEmpty? (model?.shippingAddress?[0].state??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Shipping pincode",(model?.shippingAddress??[]).isNotEmpty? (model?.shippingAddress?[0].pincode??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Billing address-1",(model?.billingAddress ?? []).isNotEmpty? (model?.billingAddress?[0].addressLine1??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Billing address-2",(model?.billingAddress ?? []).isNotEmpty?( model?.billingAddress?[0].addressLine2??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Billing District",(model?.billingAddress ?? []).isNotEmpty?( model?.billingAddress?[0].city??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Billing state",(model?.billingAddress ?? []).isNotEmpty? (model?.billingAddress?[0].state??'') : ''),
          const SizedBox(height: 10),
          itemsWidget("Billing pincode", (model?.billingAddress ?? []).isNotEmpty?(model?.billingAddress?[0].pincode??''):""),
          const SizedBox(height: 10),
          itemsWidget("Business type", model?.businessType??''),
         const SizedBox(height: 10),
         (model?.gstin??'').isNotEmpty? itemsWidget("GST No", model?.gstin??''): Container(),
         (model?.pan??'').isNotEmpty? itemsWidget("PAN No", model?.pan??''): Container()
          ,
          // const SizedBox(height: 10),
          // itemsWidget("Proposed credit limit", model?.ce),
          // const SizedBox(height: 10),
          // itemsWidget("Proposed credit days", model?.cred),
         
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
          fontsize: 14,
          color: Colors.black,
        ),
        Flexible(
          child: AppText(
              title: subTitle,
              fontsize: 14,
              fontFamily: AppFontfamily.poppinsRegular,
              color: AppColors.lightTextColor),
        ),
      ],
    );
  }
}


class _DocumentCheckListWidget extends StatelessWidget {
  final KycState refState;
 
  const _DocumentCheckListWidget({ required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
        initExpanded: true,
        collapsedWidget: collapsedWidget(
          isExpanded: true,
        ),
        expandedWidget: expandedWidget(isExpanded: false));
  }

  Widget collapsedWidget({required bool isExpanded}) {
    return Container(
      padding: isExpanded
          ? EdgeInsets.symmetric(horizontal: 10, vertical: 12)
          : EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                  title: "Documents Checklist",
                  fontFamily: AppFontfamily.poppinsSemibold),
              Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.light92Color),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          !isExpanded
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(34, (index) {
                    return Container(
                      width: 8.5,
                      height: 2,
                      color: index % 2 == 0
                          ? AppColors.edColor
                          : Colors.transparent,
                      // Alternating between black and transparent
                      margin: EdgeInsets.symmetric(
                          horizontal: 0), // Spacing between dashes
                    );
                  }),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget expandedWidget({required bool isExpanded}) {
    var model =refState.viewKycModel?.data?[0];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
         ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collapsedWidget(isExpanded: isExpanded),
          SizedBox(
            height: 10,
          ),
          LabelTextTextfield(
              title: "Customer Declaration (CD)", isRequiredStar: false),
             (model?.custDecl??[]).isNotEmpty?

             Padding(
               padding: const EdgeInsets.only(top: 6),
               child: viewDocumentImage(model?.custDecl??[]),
             ): EmptyWidget() ,
             const SizedBox(height: 15,),
             LabelTextTextfield(
              title: "Customer License (CL)", isRequiredStar: false),
              (model?.customerLicense??[]).isNotEmpty?
             Padding(
               padding: const EdgeInsets.only(top: 6),
               child: viewLicenseImage(model?.customerLicense??[]),
             ) : EmptyWidget(),
        ],
      ),
    );
  }

  viewLicenseImage(List<CustLicense> list){
    return GridView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2.9 / 3),
                  itemBuilder: (ctx, index) {
                    var model = list[index];
                    return  AppNetworkImage(imgUrl:  model.custDecl??'',
                    height: 80,width: 80,boxFit: BoxFit.cover,borderRadius: 10,
                    );});
  }


  viewDocumentImage(List<CustDecl> list){
    return GridView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2.9 / 3),
                  itemBuilder: (ctx, index) {
                    var model = list[index];
                    return  AppNetworkImage(imgUrl:  model.custDecl??'',
                    height: 80,width: 80,boxFit: BoxFit.cover,borderRadius: 10,
                    );});
  }

}


