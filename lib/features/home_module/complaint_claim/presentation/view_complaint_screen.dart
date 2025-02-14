import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class ViewComplaintScreen extends StatefulWidget {
  const ViewComplaintScreen({super.key});

  @override
  State<ViewComplaintScreen> createState() => _ViewComplaintScreenState();
}

class _ViewComplaintScreenState extends State<ViewComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: "Complaints & Claim"),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 17,right: 17,top: 7,bottom: 30),
          child: Column(
            children: [
              _StatusWidget(),
              const SizedBox(height: 15,),
              _ComplaintDetailsWidget()
            ],
          ),
        ),
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
              Icon(Icons.expand_less,color: AppColors.light92Color,),
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


class _ComplaintDetailsWidget extends StatelessWidget {
  const _ComplaintDetailsWidget();

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
              AppText(title: 'Complaint Details',fontFamily: AppFontfamily.poppinsSemibold,),
              Icon(Icons.expand_less,color: AppColors.light92Color,),
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
        children: [
          collpasedWidget(isExpanded: isExpanded),
            const SizedBox(height: 10,),
          dotteDivierWidget(dividerColor: AppColors.edColor,),
            const SizedBox(height: 9,),
            itemsWidget("Customer Type", "Secondary"),
            const SizedBox(height: 18,),
            itemsWidget("Date", "11-02-2024"),
            const SizedBox(height: 18,),
            itemsWidget("Trial Time", "14:30"),
            const SizedBox(height: 18,),
            itemsWidget("Claim Type", "Quality"),
            const SizedBox(height: 18,),
            itemsWidget("Company Name", "XYZ"),
            const SizedBox(height: 18,),
            itemsWidget("Contact Person Name", "abc"),
            const SizedBox(height: 18,),
            itemsWidget("Contact No", "34654565645"),
            const SizedBox(height: 18,),
            itemsWidget("State", "Rajasthan"),
            const SizedBox(height: 18,),
            itemsWidget("Town", "Jaipur"),
            const SizedBox(height: 18,),
            itemsWidget("Pincode", "343534"),
            const SizedBox(height: 18,),
            itemsWidget("Item Name", "abc"),
            const SizedBox(height: 18,),
            itemsWidget("Invoice no & Date", "1212423,11-12-2024"),
            const SizedBox(height: 18,),
            itemsWidget("Complaint Item Quantity", "50"),
            const SizedBox(height: 18,),
            itemsWidget("Value of Goods", "50,000"),
            const SizedBox(height: 18,),
            itemsWidget("Batch No.", "1234"),
            const SizedBox(height: 18,),
            itemsWidget("MFD", "11-12-2024"),
            const SizedBox(height: 18,),
            itemsWidget("Expiry", "1-06-2025"),
            const SizedBox(height: 18,),
            itemsWidget("Reason for Complaint", "Quality of product is not good"),
            const SizedBox(height: 18,),
            itemsWidget("Attach images/Video", ""),
            const SizedBox(height: 18,),
            imageVideoWidget(),
            const SizedBox(height: 15,),
            imageVideoWidget(),
        ],
      ),
);
  }

Widget imageVideoWidget(){
  return Container(
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      border: Border.all(color: AppColors.edColor),
      borderRadius: BorderRadius.circular(8)
    ),
    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
    child: Row(
      children: [
        SvgPicture.asset(AppAssetPaths.visitIcon,color: AppColors.greenColor,height: 20,),
        const SizedBox(width: 6,),
        AppText(title: "Customer complaint.jpg",color: AppColors.lightTextColor,fontsize: 12,)
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