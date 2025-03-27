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
              // _StatusWidget(),
              const SizedBox(height: 15,),
              _ComplaintDetailsWidget(model: refState.viewComplaintModel?.data?[0],)
            ],
          ),
        ): NoDataFound(title: "No data found"),
    );
  }
}

class _StatusWidget extends StatelessWidget {
  const _StatusWidget();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collpasedWidget(isExpanded: true),
     expandedWidget: expandedWidget(isExpanded: false));
  }

 Widget collpasedWidget({required bool isExpanded}){
    return Container(
     padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 10,vertical: 11),
          decoration: BoxDecoration(
        color:!isExpanded?null: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:!isExpanded?[]:  [
          BoxShadow(offset: Offset(0, 0),color: AppColors.black.withValues(alpha: .2),blurRadius: 10)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              AppText(title: 'Status',fontFamily: AppFontfamily.poppinsSemibold,),
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
    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           collpasedWidget(isExpanded: isExpanded),
            const SizedBox(height: 10,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
            headerWidget(img: AppAssetPaths.selectedTimeIcon, title: "Customer Care", date: "03 Jan 2025 10:30 AM"),
            Padding(padding: EdgeInsets.only(left: 30,top: 14),
            child: commentWidget(),),
            const SizedBox(height: 20,),
            headerWidget(img: AppAssetPaths.selectedTimeIcon, title: "Department", date: "03 Jan 2025 10:30 AM"),
            Padding(padding: EdgeInsets.only(left: 30,top: 14),
            child: commentWidget(),),
            const SizedBox(height: 20,),
            headerWidget(img: AppAssetPaths.unselectedTimeIcon, title: "HOD", date: ""),
            const SizedBox(height: 20,),
            headerWidget(img: AppAssetPaths.unselectedTimeIcon, title: "Management", date: ""),
            const SizedBox(height: 20,),
            dotteDivierWidget(dividerColor: AppColors.edColor,thickness: 1.6),
            const SizedBox(height: 11,),
            AppText(title: "Comments",fontFamily: AppFontfamily.poppinsMedium,),
            const SizedBox(height: 10,),
            commentWidget(isAsm: true),
            const SizedBox(height: 17,),
             Align(
              alignment: Alignment.center,
               child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.light92Color,
                  width: 0.5),
                  borderRadius: BorderRadius.circular(5)
                ),
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                child: AppText(title: "Comment",fontFamily: AppFontfamily.poppinsMedium,fontsize: 12,),
               ),
             )
        ],
      ),
  );
 }

 Widget headerWidget({required String img,required String title, required String date}){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SvgPicture.asset(img),
    const SizedBox(width: 7,),
    Expanded(child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: title,fontFamily: AppFontfamily.poppinsMedium,),
        date.isEmpty?
        AppText(title: "Pending",fontsize: 10,) : SizedBox.shrink()
      ],
    )),
    date.isEmpty ? SizedBox.shrink() :
    Row(
      children: [
        SvgPicture.asset(AppAssetPaths.dateIcon),
        const SizedBox(width: 2,),
        AppText(title: date,fontsize: 10,fontWeight: FontWeight.w300,),
      ],
    )
    ],
  );
 }

 Widget commentWidget({bool isAsm=false}){
  return Container(
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      border: Border.all(color: AppColors.e2Color,width: .5),
      borderRadius: BorderRadius.circular(5)
    ),
    padding: EdgeInsets.only(top: 9,left: 12,right: 12,bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isAsm?
        Padding(
          padding: const EdgeInsets.only(left: 40,bottom: 5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.greenColor,
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: AppText(title: "ASM",fontsize: 10,),
          ),
        ) : SizedBox.shrink(),
        Row(
          children: [
            SvgPicture.asset(AppAssetPaths.userIcon),
            const SizedBox(width: 3,),
            AppText(title: "John Doe",fontsize: 10,fontFamily:AppFontfamily.poppinsMedium,),
            const SizedBox(width: 6,),
            AppText(title: "10:35 AM",fontsize: 10,fontWeight: FontWeight.w300,),
          ],
        ),
         const SizedBox(height: 12,),
         AppText(title: "Approved",fontsize: 10,fontWeight: FontWeight.w300,)
      ],
    ),
  );
 }
}


// ignore: must_be_immutable
class _ComplaintDetailsWidget extends StatelessWidget {
  ComplaintData? model;
   _ComplaintDetailsWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpandableWidget(
        initExpanded: true,
        collapsedWidget: collpasedWidget(isExpanded: true), expandedWidget: expandedWidget(isExpanded: false)),
    );
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
            itemsWidget("Customer Type", model?.customerType??''),
            const SizedBox(height: 18,),
            itemsWidget("Date", model?.openingDate??''),
            const SizedBox(height: 18,),
            itemsWidget("Trial Time", model?.openingTime??""),
            const SizedBox(height: 18,),
            itemsWidget("Claim Type", model?.claimType??''),
            const SizedBox(height: 18,),
            itemsWidget("Company Name", model?.company??''),
            const SizedBox(height: 18,),
            itemsWidget("Contact Person Name", model?.name??''),
            const SizedBox(height: 18,),
            itemsWidget("Contact No", model?.contact??''),
            const SizedBox(height: 18,),
            itemsWidget("State", model?.state??''),
            const SizedBox(height: 18,),
            itemsWidget("District", model?.district??''),
            const SizedBox(height: 18,),
            itemsWidget("Pincode", model?.pincode??''),
            const SizedBox(height: 18,),
            itemsWidget("Item Name", model?.itemName??''),
            const SizedBox(height: 18,),
            itemsWidget("Invoice no & Date", "${model?.invoiceNo??""}, ${model?.invoiceDate??''}"),
            const SizedBox(height: 18,),
            itemsWidget("Complaint Item Quantity", (model?.complaintItmQty??'').toString()),
            const SizedBox(height: 18,),
            itemsWidget("Value of Goods", (model?.valueOfGoods??'').toString()),
            const SizedBox(height: 18,),
            itemsWidget("Batch No.", (model?.batchNo??"").toString()),
            const SizedBox(height: 18,),
            itemsWidget("MFD", model?.mfd??''),
            const SizedBox(height: 18,),
            itemsWidget("Expiry", model?.expiry??''),
            const SizedBox(height: 18,),
            itemsWidget("Reason for Complaint",model?.description??''),
            const SizedBox(height: 18,),
            itemsWidget("Attach images", ""),
            const SizedBox(height: 18,),
            ListView.separated(
              separatorBuilder: (sb,index){
                return const SizedBox(height: 15,);
              },
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
      print(img);
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