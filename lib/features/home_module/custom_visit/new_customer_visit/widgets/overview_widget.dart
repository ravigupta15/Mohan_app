import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/core/widget/expandable_widget.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/product_trial_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/presentation/capture_image_screen.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/customer_information_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';

class OverviewWidget extends StatefulWidget {
   final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
   OverviewWidget({super.key, required this.refNotifer,required this.refState});

  @override
  State<OverviewWidget> createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    // print(LocalSharePreference.token);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       _AddedProductWidget(),
       const SizedBox(height: 15,),
       additionalDetailsWidget(),
       const SizedBox(height: 15,),
       _CaptureImage(refNotifer: widget.refNotifer,refState: widget.refState,),
       const SizedBox(height: 15,),
       RemarksWidget(
        isEditable: false,remarks: widget.refNotifer.remarksController.text,
        isRequired: true,
       ),
       const SizedBox(height: 15,),
       CustomerInfoWidget(
          name: widget.refNotifer.customerNameController.text,
          location: LocalSharePreference.currentAddress,
          shopName: widget.refNotifer.shopNameController.text,
          number: widget.refNotifer.numberController.text,
          contactList: widget.refState.contactNumberList,
        ),
      ],
    );
  }

  Widget additionalDetailsWidget(){
    return Column(
      children: [
        Center(
          child:  AppText(title: "Additional Details",fontFamily: AppFontfamily.poppinsSemibold,),
        ),
         const SizedBox(height: 14,),
         bookAppointmentWidget(),
         const SizedBox(height: 14,),
           _dealTypeWidget(),
           const SizedBox(height: 14,),
           _ProductTrial(
            refNotifer: widget.refNotifer,refState: widget.refState,
           )
      ],
    );
  }


  Widget bookAppointmentWidget(){
    return Container(
 padding: EdgeInsets.only(left: 15,right: 15,top: 9,bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title: "Book Appointment",fontFamily: AppFontfamily.poppinsSemibold,),
          const SizedBox(height: 10,),
          AppTextfield(
            fillColor: false,
            isReadOnly: true,
            controller: widget.refNotifer.bookAppointmentController,
            onTap: (){
             DatePickerService.datePicker(context,selectedDate: selectedDate).then((picked){
              if(picked!=null){
                 var day = picked.day < 10 ? '0${picked.day}' : picked.day;
              var  month = picked.month < 10 ? '0${picked.month}' : picked.month;
             widget.refNotifer.bookAppointmentController.text = "${picked.year}-$month-$day";
          setState(() {
        selectedDate = picked;
         }); 
              }
             });
            },
            suffixWidget: Container(
              height: 33,width: 33,
              margin: EdgeInsets.all(8),
              decoration:BoxDecoration(
                color: AppColors.greenColor,
                borderRadius: BorderRadius.circular(5)
              ) ,
              child: Icon(Icons.add,color: AppColors.whiteColor,size: 20,),
            ),
          )
        ],
      ),
    );
  }

_dealTypeWidget(){
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
        boxShadow:!isExpanded?[]: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
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
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 15,),
          customSlider()
        ],
      ),
    );
  }

  customSlider(){
     double screenWidth = MediaQuery.of(context).size.width;
      double sliderWidth = screenWidth * 0.85;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                 double newPosition = details.localPosition.dx;
                if (newPosition < 0) newPosition = 0; 
                if (newPosition > sliderWidth - thumbRadius * 2) {
                  newPosition = sliderWidth - thumbRadius * 2;
                }
                _sliderValue = newPosition / sliderWidth;
                widget.refState.dealTypeValue =getSnappedValue(_sliderValue);
              });
            },
            child: Container(
              width: sliderWidth,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey.shade200, 
                borderRadius: BorderRadius.circular(5), 
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.yellow, Colors.green],
                  stops: [0.0, 0.5, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: _sliderValue * sliderWidth - thumbRadius*.3, 
                    top: 0,bottom: 0,  
                    child: Container(
                      width: thumbRadius * 2, 
                      height: thumbRadius * 2,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, 
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha:  0.3),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 5,),
        SizedBox(
          // width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: "Low",fontsize: 12,),
              AppText(title: "Medium",fontsize: 12,),
              AppText(title: "High",fontsize: 12,),
            ],
          ),
        )
      ],
    );
  
  }

double _sliderValue = 0.0; 

  double thumbRadius = 20;

// Function to check if the slider is in Low, Medium, or High range
  String getSliderState(double value) {
    if (value <= 0.33) {
      return "Low";
    } else if (value <= 0.66) {
      return "Medium";
    } else {
      return "High";
    }
  }

  int getSnappedValue(double value){
    if (value <= 0.1) {
      return 1;
    } else if (value <= 0.3) {
      return 2;
    } else if (value <= 0.5) {
      return 3;
    } else if (value <= 0.7) {
      return 4;
    } else {
      return 5;
    }
  }
}

class _AddedProductWidget extends StatelessWidget {
  const _AddedProductWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
      decoration: BoxDecoration(
        color:AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffE2E2E2)),
        
      ),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: AppText(title: 'Add Products',
              fontsize: 12,color: AppColors.oliveGray,
              fontFamily: AppFontfamily.poppinsSemibold,),
            ),
            const SizedBox(height: 10,),
            ExpandableWidget(
              initExpanded: true,
              collapsedWidget: collapsedWidget(isExpanded: true),
             expandedWidget: expandWidget(isExpanded: false))
        ],
      ),
    );
  }

collapsedWidget({required bool isExpanded}){
    return Container(
         decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      alignment: Alignment.center,
      padding:isExpanded? EdgeInsets.symmetric(horizontal: 15,vertical: 12):EdgeInsets.zero,
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: "Bread",fontFamily:AppFontfamily.poppinsSemibold,),
            Icon(!isExpanded? Icons.expand_less:Icons.expand_more,color: AppColors.light92Color,),
            ],
          ),
      );
  }

  expandWidget({required bool isExpanded}){
    return Container(
         decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      padding: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 20),
      child: Column(
            children: [
              collapsedWidget(isExpanded: isExpanded),
              Padding(padding: EdgeInsets.only(top: 9,bottom: 9),
          child: dotteDivierWidget(dividerColor:  AppColors.edColor,thickness: 1.6),),
          productItemWidget(1),
          const SizedBox(height: 7,),
          productItemWidget(2),
          const SizedBox(height: 7,),
          productItemWidget(3),
            ],
          ),
      );
  }

productItemWidget(int index){
  return Row(
    children: [
      AppText(title: "Item $index",fontFamily: AppFontfamily.poppinsMedium,fontsize: 12,),
      const SizedBox(width: 10,),
      AppText(title: "Variation",fontFamily: AppFontfamily.poppinsMedium,fontsize: 12,),
      addedProductWidget(),
      SvgPicture.asset(AppAssetPaths.deleteIcon)
    ],
  );
}

  addedProductWidget(){
    return  Expanded(
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customContainerForAddRemove(isAdd: false),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 15,width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.greenColor)
                ),
              ),
              customContainerForAddRemove(isAdd: true),
              const SizedBox(width: 3,),
              AppText(title: "kg",fontsize: 10,color: AppColors.lightTextColor,)
            ],
          ),
    );
  }

Widget customContainerForAddRemove({required bool isAdd}){
    return InkWell(
      onTap: (){},
      child: Container(
        height: 18,width: 18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.edColor,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Icon(isAdd? Icons.add:Icons.remove,
        size: 16,
        color: isAdd?AppColors.greenColor:AppColors.redColor,
        ),
      ),
    );
  }

}

class _ProductTrial extends StatelessWidget {
   final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
  const _ProductTrial({required this.refNotifer, required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true),
     expandedWidget: expandedWidget(isExpanded: false));
  }

  collapsedWidget({required bool isExpanded}){
    return Container(
      padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:!isExpanded?[]: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(
            text: "Product Trial",
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
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 15,),
           Row(
          children: [
            customRadioButton(isSelected: refState.productTrial==1? true:false, title: 'Yes',
            onTap: (){
              refNotifer.selectProductTrialType(1);
            }),
            const Spacer(),
            customRadioButton(isSelected:refState.productTrial==2?true: false, title: 'No',
            onTap: (){
              refNotifer.selectProductTrialType(2);
            }),
            const Spacer(),
          ],
        ),
        refState.productTrial==1?
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: AppTextButton(title: "Book Trial",height: 40,color: AppColors.arcticBreeze,
          onTap: (){
            AppRouter.pushCupertinoNavigation(ProductTrialScreen(
              refNotifer: refNotifer,
              refState: refState,
            ));
          },
          ),
        ) : SizedBox.shrink()
        ],
      ),
    );
  }
}

class _CaptureImage extends StatelessWidget {
    final NewCustomerVisitNotifier refNotifer;
  final NewCustomerVisitState refState;
  const _CaptureImage({required this.refNotifer,required this.refState});

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      initExpanded: true,
      collapsedWidget: collapsedWidget(isExpanded: true),
     expandedWidget: expandedWidget(context, isExpanded: false));
  }

  collapsedWidget({required bool isExpanded}){
    return Container(
      padding:!isExpanded?EdgeInsets.zero: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:!isExpanded?[]: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(
            text: "Capture Image",
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

   expandedWidget(BuildContext context, {required bool isExpanded,}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .2),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        collapsedWidget(isExpanded: isExpanded),
          const SizedBox(height: 15,),
         refState.captureImageList.length>1?
          GridView.builder(
            itemCount: refState.captureImageList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 15,crossAxisSpacing: 15,childAspectRatio: 2.9/3), itemBuilder: (ctx,index){
              return index != 0?
               Stack(
                fit: StackFit.expand,
                 children: [
                   ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(refState.captureImageList[index],height: 79,width: 100,fit: BoxFit.cover,)),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: (){
                      refState.captureImageList.removeAt(index);
                      refState.uploadedImageList.removeAt(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.redColor
                      ),
                      child: Icon(Icons.close,color: AppColors.whiteColor,size: 15,),
                    ),
                  ))
                 ],
               ):
              addImageWidget(context);
          }):
         GestureDetector(
          onTap: (){
           _openCaptureImageScreen(context);
          },
           child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.e2Color)
            ),
            alignment: Alignment.center,
            child:SvgPicture.asset(AppAssetPaths.galleryIcon),
           ),
         )
        ],
      ),
    );
  }


  Widget addImageWidget(BuildContext context){
    return InkWell(
      onTap: (){
         _openCaptureImageScreen(context);
      },
      child: DottedBorder(
        dashPattern: [5,6],
        borderType: BorderType.RRect,
        color: AppColors.greenColor,
        radius: Radius.circular(20),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Icon(Icons.add,size: 50,color: AppColors.light92Color.withValues(alpha: .5),),
        )),
    );
  }


_openCaptureImageScreen(BuildContext context){
   AppRouter.pushCupertinoNavigation( CaptureImageScreen(
              refNotifer: refNotifer,refState: refState,
            )).then((val){
              if(val!=null){
                refNotifer.imageUploadApiFunction(context, val);
              }
            });
}

}

