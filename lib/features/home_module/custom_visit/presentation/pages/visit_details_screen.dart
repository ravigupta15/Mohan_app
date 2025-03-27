import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_slider_widget.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/common_widgets/status_activity.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/view_visit_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/new_customer_visit_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/riverpod/customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/kyc/presentation/add_kyc_screen.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/presentation/trial_product_item_screen.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';

class VisitDetailsScreen extends ConsumerStatefulWidget {
  final String id;
  const VisitDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<VisitDetailsScreen> createState() => _VisitDetailsScreenState();
}

class _VisitDetailsScreenState extends ConsumerState<VisitDetailsScreen> {

  @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(customVisitProvider.notifier);
    ref.watch(customVisitProvider).visitModel=null;
    refNotifier.viewCustomerVisitApiFunction(context, widget.id);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(customVisitProvider);
     final refNotifier = ref.read(customVisitProvider.notifier);
    return Scaffold(
        appBar: customAppBar(title: "Visit",
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.greenColor,width: .5)),
            child: AppText(title: (refState.visitModel?.data?[0].workflowState ?? ''),fontsize: 9,),
        )
      ]
      ),
      body: (refState.visitModel?.data??[]).isNotEmpty?
       SingleChildScrollView(
        padding: const EdgeInsets.only(top: 12,left: 17,right: 17,bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productWidget(refState),
            const SizedBox(height: 19,),
            _AdditionalDetails(refState: refState,),
            const SizedBox(height: 20,),
            (refState.visitModel?.data?[0].workflowState ?? '').toString().toLowerCase() == "draft"?
            Align(
              alignment: Alignment.center,
              child: AppTextButton(title: "Resume",color: AppColors.arcticBreeze,
              width: 180,height: 40,
              onTap: (){
                AppRouter.pushCupertinoNavigation( NewCustomerVisitScreen(
                  route: 'resume',
                  resumeItems: refState.visitModel?.data?[0],));
                
              },
              ),
            ):
            (refState.visitModel?.data?[0].kycStatus ?? '').toString().toLowerCase() == "pending" && refState.visitModel?.data?[0].customerLevel =='Primary' && refState.visitModel?.data?[0].verificType.toString().toLowerCase() =='unverified'?
            Align(
              alignment: Alignment.center,
              child: AppTextButton(title: "Complete KYC",color: AppColors.arcticBreeze,
              width: 180,height: 40,
              onTap: (){
                AppRouter.pushCupertinoNavigation(AddKycScreen(
                  visitItemsModel: refState.visitModel?.data?[0],
                  route: 'view',
                )).then((val){
                  if(val==true){
                    refNotifier.viewCustomerVisitApiFunction(context, widget.id);
                  }
                });
              },
              ),
            ) : EmptyWidget()
          ],
        ),
      ) : EmptyWidget(),
    );
  }

  Widget productWidget(CustomerVisitState refState){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
      decoration: BoxDecoration(
        color:AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffE2E2E2)),
      ),
      child: ListView.separated(
        separatorBuilder: (ctx,sp){
          return const SizedBox(height: 16,);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (refState.visitModel?.data?[0].productPitching?.length ?? 0),
        itemBuilder: (ctx,index){
           var model = refState.visitModel?.data?[0].productPitching?[index];
           return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                  AppText(title: model?.product??'',fontFamily: AppFontfamily.poppinsMedium,),
              Padding(padding: EdgeInsets.only(top: 9,bottom: 6),
                 child: dotteDivierWidget(dividerColor:  AppColors.edColor,thickness: 1.6),),
          
               productItemWidget(model),
             ],
           );
      })
     );
  }

  Widget productItemWidget(ProductPitching? model){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 20),

      child: ListView.separated(
              separatorBuilder: (ctx,sb){
                return const SizedBox(height: 15,);
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (model?.item?.length ?? 0),
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 15),
              itemBuilder: (ctx,sbIndex){
                var itemModel = model?.item?[sbIndex];
                return Row(
           children: [
          Expanded(child: AppText(title: (itemModel?.itemName??''),maxLines: 1,)),
           const SizedBox(width: 10,),
        const SizedBox(width: 15,),
          AppText(title:(itemModel?.qty ??0 ).toString(),),
        ],
      );
            }),
    );
  }
}

// ignore: must_be_immutable
class _AdditionalDetails extends StatelessWidget {
  CustomerVisitState refState;
   _AdditionalDetails({super.key, required this.refState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "Additional Details",fontFamily: AppFontfamily.poppinsSemibold,),
        const SizedBox(height: 14,),
          _DealTypeWidget(refState: refState,),
          const SizedBox(height: 14,),
        ExpandableWidget(
          initExpanded: true,
          collapsedWidget: collapsedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false)),
          (refState.visitModel?.data?[0].hasTrialPlan ?? '0').toString() == '0'? EmptyWidget():
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: _TrialPlanWidget(refState: refState),
          ),
          const SizedBox(height: 14,),
          RemarksWidget(
            isEditable: false,
            remarks: refState.visitModel?.data?[0].remarksnotes??'',
          ),
          
          const SizedBox(height: 14,),
          imageWidget(context),
          const SizedBox(height: 14,),
          StatusWidget(activities: refState.visitModel?.data?[0].activities)
      ],
    );

  }

Widget collapsedWidget({required bool isExpanded}){
  return Container(
      padding:isExpanded? EdgeInsets.symmetric(horizontal: 10,vertical: 14):EdgeInsets.zero,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(title: "Customer Information",fontFamily:AppFontfamily.poppinsSemibold,),
          Icon(!isExpanded? Icons.expand_less:Icons.expand_more,color: AppColors.light92Color,),
      ],
    ),
  );
}

Widget expandedWidget({required bool isExpanded}){
  var model = refState.visitModel?.data?[0];
  return  Container(
       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       collapsedWidget(isExpanded: isExpanded),
            const SizedBox(height: 13,),
            itemsWidget("Vendor Name", (model?.customerName??'').isEmpty? (model?.unvCustomerName ?? ''): (model?.customerName??'')),
            const SizedBox(height: 13,),
            itemsWidget("Shop Name", model?.shopName?? ''),
            const SizedBox(height: 13,),
            itemsWidget("Contact", (model?.contact?.isEmpty ?? true) 
    ? '' 
    : model?.contact?.map((e) => e.contact).join(', ') ?? ''
            ),
const SizedBox(height: 13,),
            itemsWidget("Visit Type", model?.customerLevel?? ''),
            const SizedBox(height: 13,),
            itemsWidget("Location", model?.location??''),
            const SizedBox(height: 13,),
            itemsWidget("Address Type", model?.addressTitle??''),
            const SizedBox(height: 13,),
            itemsWidget("Address-1", model?.addressLine1??''),
            (model?.addressLine2??'').isEmpty ? EmptyWidget():
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: itemsWidget("Address-2", model?.addressLine2??''),
            ),
            const SizedBox(height: 13,),
            itemsWidget("District", model?.district??''),
            const SizedBox(height: 13,),
            itemsWidget("State", model?.state??''),
            const SizedBox(height: 13,),
            itemsWidget("Pincode", (model?.pincode??'').toString()),
            const SizedBox(height: 13,),
            itemsWidget("Details edit needed", (model?.custEditNeeded??'').toString() == '1'?"Yes":"No"),
            (model?.conductBy??'').isEmpty? EmptyWidget() :
             Padding(
               padding: const EdgeInsets.only(top: 13),
               child: itemsWidget("Conduct By", (model?.conductBy??'')),
             ),
            (model?.trialType??'').isEmpty? EmptyWidget() :
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: itemsWidget("Trial Type", model?.trialType?? ''),
            ),
            (model?.appointmentDate??'').isEmpty? EmptyWidget() :
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: itemsWidget("Appointment Date", model?.appointmentDate?? ''),
            ),
        ],
      ),
    );
}


  Widget itemsWidget(String title, String subTitle){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        const SizedBox(width: 4,),
        Expanded(
          child: AppText(title: subTitle,
          fontsize: 13,
          fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
        ),
      ],
    );
  }

  Widget imageWidget(BuildContext context){
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: imageCollapsedWidget(isExpanded: true),
     expandedWidget: imageExpandedWidget(context, isExpanded: false));
  }


  imageCollapsedWidget({required bool isExpanded}){
    return Container(
      padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             AppText(title: "Capture Image",fontFamily: AppFontfamily.poppinsSemibold,),
            Icon(!isExpanded ? Icons.expand_less : Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
    );
  }

   imageExpandedWidget(BuildContext context, {required bool isExpanded,}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        imageCollapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 15,),
          GridView.builder(
            itemCount: (refState.visitModel?.data?[0].imageUrl?.length ?? 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 15,crossAxisSpacing: 15,childAspectRatio: 2.9/3),
             itemBuilder: (ctx,index){
              var model = refState.visitModel?.data?[0].imageUrl?[index];
              return AppNetworkImage(imgUrl: model?.fileUrl??'' ,height: 85,width: 85,borderRadius: 15,boxFit: BoxFit.cover,);})
        ],
      ),
    );
  }


}

class _TrialPlanWidget extends StatelessWidget {
   final CustomerVisitState refState;
   _TrialPlanWidget({super.key, required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true),
       expandedWidget: expandedWidget( isExpanded: false));
  }


 Widget collapsedWidget({required bool isExpanded}){
  var model = refState.visitModel?.data?[0];
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
    var model = refState.visitModel?.data?[0];
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
    var model = refState.visitModel?.data?[0];
    return   ListView.separated(
       separatorBuilder: (ctx,sb){
                return const SizedBox(height: 15,);
              }, 
              itemCount: (model?.productTrial ?? []).length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx,index){
                var productModel = model?.productTrial?[index];
                return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: GestureDetector(
                onTap: (){
                  // AppRouter.pushCupertinoNavigation(TrialProductItemScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: productModel?.product ?? '',fontWeight: FontWeight.w400,),
                    Container(
                      alignment: Alignment.center,
                      child: AppText(title: productModel?.report ?? '',fontsize: 12,color: AppColors.mossGreyColor,),)
                  ],
                ),
              ),
            );
            });
  }


  Widget itemViewWidget(){
    var model = refState.visitModel?.data?[0];
    return   ListView.separated(
              separatorBuilder: (ctx,sb){
                return const SizedBox(height: 15,);
              },
              itemCount: (model?.itemTrial ?? []).length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx,index){
                var productModel = model?.itemTrial?[index];
                return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: GestureDetector(
                onTap: (){
                  // AppRouter.pushCupertinoNavigation(TrialProductItemScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(title: productModel?.itemName ?? '',fontWeight: FontWeight.w400,),
                    Container(
                      alignment: Alignment.center,
                      child: AppText(title: productModel?.report ?? '',fontsize: 12,color: AppColors.mossGreyColor,),)
                  ],
                ),
              ),
            );
            });
  }

}

class _DealTypeWidget extends StatelessWidget {
  final CustomerVisitState refState;
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
          CustomSliderWidget(value:double.parse(refState.visitModel?.data?[0].dealType ?? '0'),isEnable: false,)
        ],
      ),
    );
  }
}
