import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/core/widget/view_img.dart';
import 'package:mohan_impex/features/common_widgets/status_activity.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/view_complaint_model.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/riverpod/add_complaint_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';

class ViewComplaintScreen extends ConsumerStatefulWidget {
  final String ticketId;
  const ViewComplaintScreen({super.key, required this.ticketId});

  @override
  ConsumerState<ViewComplaintScreen> createState() => _ViewComplaintScreenState();
}

class _ViewComplaintScreenState extends ConsumerState<ViewComplaintScreen> {

 @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

callInitFunction(){
  ref.read(addComplaintsProvider.notifier).viewComplaintApiFunction(context, widget.ticketId);
}

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(addComplaintsProvider);
    return Scaffold(
        appBar: customAppBar(title: "Complaints & Claim"),
        body: (refState.viewComplaintModel?.data??[]).isNotEmpty? SingleChildScrollView(
          padding: EdgeInsets.only(left: 17,right: 17,top: 7,bottom: 30),
          child: Column(
            children: [
              StatusWidget(activities: []),
              const SizedBox(height: 15,),
              _ComplaintDetailsWidget(model: refState.viewComplaintModel?.data?[0],),
              _complaintItems(model: refState.viewComplaintModel?.data?[0],)
            ],
          ),
        ): NoDataFound(title: "No data found"),
    );
  }
}

// ignore: must_be_immutable
class _ComplaintDetailsWidget extends StatelessWidget {
  ComplaintData? model;
   _ComplaintDetailsWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collpasedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false));
  }

 Widget collpasedWidget({required bool isExpanded}){
return Container(
        padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Complaint Details',fontFamily: AppFontfamily.poppinsSemibold,),
             Icon(
            !isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.light92Color,
          ),
        ],
      ),
   
    );
  }


 Widget expandedWidget({required bool isExpanded}){
return Container(
  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
       
      ),
      child: Column(
        children: [
          collpasedWidget(isExpanded: isExpanded),
            const SizedBox(height: 10,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
            itemsWidget("Customer Type", model?.customerLevel??''),
            const SizedBox(height: 18,),
            itemsWidget("Date", model?.date??''),
            const SizedBox(height: 18,),
            itemsWidget("Subject", model?.subject??''),
            const SizedBox(height: 18,),
            itemsWidget("Claim Type", model?.claimType??''),
            const SizedBox(height: 18,),
            itemsWidget("Shop Name", model?.shopName??''),
            const SizedBox(height: 18,),
            itemsWidget("Contact Person Name", model?.customerName??''),
            const SizedBox(height: 18,),
            itemsWidget("Contact No", model?.contact??''),
            const SizedBox(height: 18,),
            itemsWidget("State", model?.state??''),
            const SizedBox(height: 18,),
            itemsWidget("District", model?.district??''),
            const SizedBox(height: 18,),
            itemsWidget("Pincode", model?.pincode??''),
            const SizedBox(height: 18,),
            itemsWidget("Reason for Complaint",model?.description??''),
            const SizedBox(height: 18,),
            itemsWidget("Attach images", ""),
            ListView.separated(
              separatorBuilder: (sb,index){
                return const SizedBox(height: 15,);
              },
              padding: EdgeInsets.only(top: 18),
              itemCount: (model?.imageUrl?.length??0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx,index){
                var imgModel = model?.imageUrl?[index];
                return imageVideoWidget(imgModel?.fileUrl??'', imgModel?.fileName??'');
            })
        ],
      ),
);
  }


Widget imageVideoWidget(String img, String fileName){
  return InkWell(
    onTap: (){
      AppRouter.pushCupertinoNavigation(ViewImage(image: img));
      // AppRouter.pushCupertinoNavigation(ViewImage(image: 'img'));
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.edColor),
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppAssetPaths.visitIcon,color: AppColors.greenColor,height: 20,),
          const SizedBox(width: 6,),
          Expanded(child: AppText(title: fileName,color: AppColors.lightTextColor,fontsize: 12))
        ],
      ),
    ),
  );
 }

   Widget itemsWidget(String title, String subTitle){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        Expanded(
          child: AppText(title: subTitle,
          fontsize: 13,
          fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
        ),
      ],
    );
  }
}

class _complaintItems extends StatelessWidget {
  ComplaintData? model;
   _complaintItems({super.key, this.model});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  decoration: BoxDecoration(
                    color: AppColors.itemsBG,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffE2E2E2)),
                  ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           AppText(
            title: 'Complaint Items',
            fontsize: 14,
            color: AppColors.black,
            fontFamily: AppFontfamily.poppinsSemibold,
          ),
             const SizedBox(
            height: 10,
          ),
       ListView.separated(
              separatorBuilder: (ctx, sb) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: model?.complaintItem?.length??0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                return ExpandableWidget(
                    initExpanded: true,
                    collapsedWidget: collpasedWidget(
                        isExpanded: true,
                        index: index,),
                    expandedWidget: expandedWidget(
                        isExpanded: false,
                        index: index,));
              }),
        ],
      ),
    );
  
  }

 Widget collpasedWidget({required bool isExpanded,required int index}){
return Container(
        padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: "Item",fontFamily: AppFontfamily.poppinsSemibold,),
             Icon(
            !isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.light92Color,
          ),
        ],
      ),
   
    );
  }


 Widget expandedWidget({required bool isExpanded, required int index}){
return Container(
  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
       
      ),
      child: Column(
        children: [
          collpasedWidget(isExpanded: isExpanded,index: index),
            const SizedBox(height: 10,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
            itemsWidget("Item name", model?.complaintItem?[index].itemName??''),
            const SizedBox(height: 18,),
            itemsWidget("Complaint item qty", (model?.complaintItem?[index].complaintItmQty??'').toString()),
            const SizedBox(height: 18,),
            itemsWidget("Value of goods", (model?.complaintItem?[index].valueOfGoods??'').toString()),
            const SizedBox(height: 18,),
            itemsWidget("Batch No.", model?.complaintItem?[index].batchNo??''),
            const SizedBox(height: 18,),
            itemsWidget("Expiry date", model?.complaintItem?[index].expiry??''),
            const SizedBox(height: 18,),
            itemsWidget("MFD", model?.complaintItem?[index].mfd??''),
        ],
      ),
);
  }

   Widget itemsWidget(String title, String subTitle){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "$title : ",fontFamily: AppFontfamily.poppinsRegular,),
        Expanded(
          child: AppText(title: subTitle,
          fontsize: 13,
          fontFamily: AppFontfamily.poppinsRegular,color: AppColors.lightTextColor,),
        ),
      ],
    );
  }


}