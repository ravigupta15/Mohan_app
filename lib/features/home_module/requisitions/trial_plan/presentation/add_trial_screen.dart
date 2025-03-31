import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:mohan_impex/core/helper/dropdown_item_helper.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/custom_drop_down.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_checkbox.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/date_picker_bottom_sheet.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_address_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/customer_info_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/product_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_notifier.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/customer_information_widget.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/timer_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/add_trial_plan_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/add_trial_plan_state.dart';
import 'package:mohan_impex/features/home_module/search/presentation/search_screen.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/utils/app_date_format.dart';
import 'package:mohan_impex/utils/app_validation.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import '../../../../../res/app_fontfamily.dart';

// ignore: must_be_immutable
class AddTrialScreen extends ConsumerStatefulWidget {
  final NewCustomerVisitNotifier? refNotifer;
  final NewCustomerVisitState? refState;
  final String route;
  Function(List)?onDetails;
   AddTrialScreen({super.key,  this.route = '', this.refNotifer, this.refState,this.onDetails});

  @override
  ConsumerState<AddTrialScreen> createState() => _AddTrialScreenState();
}

class _AddTrialScreenState extends ConsumerState<AddTrialScreen> with AppValidation {
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0); // Default time
 DateTime selectedDay = DateTime.now(); // Track the selected day
  DateTime focusedDay = DateTime.now();
 DateTime? selectedDate;
ItemModel?itemModel;
ProductModel? productModel;
String itemTemplate = '';
String? selectedTrialType;

 @override
  void initState() {
    Future.microtask(() {
      callInitFunction();
    });
    super.initState();
  }
callInitFunction() {
    final refNotifier = ref.read(addTrialPlanProvider.notifier);
    refNotifier.resetAddTrialValues();
    itemsApiFunction(context, searchText: '',);
    productApiFunction('');
    if(widget.route == 'visit'){
      fromProduct();
    }
    setState(() {
      
    });
  }

  fromProduct(){
    final trialPlanNotifier = ref.read(addTrialPlanProvider.notifier);
    final trialPlanState = ref.read(addTrialPlanProvider);
    final newVisitNotifier = ref.read(newCustomVisitProvider.notifier);
    final newVisitState = ref.watch(newCustomVisitProvider);
    if(widget.route == 'visit'){
      trialPlanNotifier.customerNameController.text = newVisitNotifier.customerNameController.text;
    trialPlanNotifier.visitTypeController.text = AppConstants.visitTypeList[newVisitState.selectedVisitType];
    trialPlanNotifier.businessNameController.text = newVisitNotifier.shopNameController.text;
    trialPlanNotifier.verifiedCustomerLocation = AppConstants.customerType[newVisitState.selectedCustomerType] == "new"? '' : newVisitNotifier.verifiedCustomerLocation;
    trialPlanNotifier.customer = newVisitNotifier.selectedExistingCustomer;
    trialPlanNotifier.selectedVisitType = AppConstants.visitTypeList[newVisitState.selectedVisitType];
    trialPlanNotifier.selectedVerifyType =  newVisitNotifier.selectedVerificationType;
    trialPlanNotifier.selectedShop = newVisitNotifier.selectedshop;
    
    trialPlanNotifier.addressTypeController.text = newVisitNotifier.addressTypeController.text;
    trialPlanNotifier.channelPartnerController.text = newVisitNotifier.channelPartnerController.text;
    trialPlanNotifier.address1Controller.text = newVisitNotifier.address1Controller.text;
    trialPlanNotifier.address2Controller.text = newVisitNotifier.address2Controller.text;
    trialPlanNotifier.districtController.text = newVisitNotifier.districtController.text;
    trialPlanNotifier.stateController.text = newVisitNotifier.stateController.text;
    trialPlanNotifier.pincodeController.text = newVisitNotifier.pincodeController.text;
    trialPlanNotifier.appointmentController.text = newVisitNotifier.bookAppointmentController.text;
    trialPlanNotifier.verifyTypeController.text = newVisitNotifier.selectedVerificationType;
    trialPlanNotifier.remarksController.text =  newVisitNotifier.remarksController.text;
    trialPlanNotifier.contactNumberList = newVisitState.contactNumberList;
    trialPlanNotifier.appointmentController.text = newVisitNotifier.trialPlanAppointmentDate;
    trialPlanState.selectedConductType = (newVisitNotifier.trialConductType.isNotEmpty && newVisitNotifier.trialConductType.toLowerCase() != 'self')? 1:0;
    trialPlanNotifier.trailTypeController.text = newVisitNotifier.trialType;
    selectedTrialType = newVisitNotifier.trialType.isNotEmpty? newVisitNotifier.trialType : null;
    trialPlanNotifier.selectedItem = newVisitNotifier.trialType.toLowerCase() == 'item'
    ? newVisitNotifier.trailItems.map((e) {
        return Items(itemName: e['item_name'],itemCode: e['item_code']);
      }).toList()
    : [];

 trialPlanNotifier.selectedProduct = newVisitNotifier.trialType.toLowerCase() == 'product'
    ? newVisitNotifier.trailItems.map((e) {
        return ProductItems(productName: e['product']);
      }).toList()
    : [];
    

    if(newVisitState.contactNumberList.isNotEmpty){
      trialPlanNotifier.contactNumberController.text = newVisitState.contactNumberList[0];
    }
    else{
      trialPlanNotifier.contactNumberController.text = newVisitNotifier.numberController.text;
    }
    print("stat....${newVisitNotifier.stateController.text}");
    if((newVisitNotifier.stateController.text).isNotEmpty){
    }
    setState(() {
      
    });
    }
  }

  bool disableToEdit(){
   final refState = ref.watch(newCustomVisitProvider);
   return widget.route == 'visit' && refState.hasProductTrial ==1 ? true : false;
  }


  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(addTrialPlanProvider.notifier);
    final refState = ref.watch(addTrialPlanProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(title: 'Trial Plan',
       actions: widget.route == 'visit'? [
        timerWidget(ref.watch(newCustomVisitProvider).currentTimer)
      ]:[]
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 18,right: 19,top: 14,bottom: 30),
        child:Form(
          key: refNotifier.formKey,
          child: Column(
            children: [
              screenContentWidget(refNotifier,refState),
              refNotifier.trailTypeController.text.isEmpty? EmptyWidget():
              Padding(padding: EdgeInsets.only(top: 30),
              child: selectItemWidget(refNotifier),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: RemarksWidget(
                  controller: refNotifier.remarksController,
                  remarks:widget.route == 'visit'? refNotifier.remarksController.text : '',
                isEditable: widget.route == 'visit'? false : true,
                  validator: (val){
                    if((val??'').isEmpty){
                      return "Required";
                    }
                    return null;
                  },
                ),
              ),
              widget.route == 'visit'?
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomerVisitInfoWidget(refNotifier: widget.refNotifer!, refState: widget.refState!),
              ) : EmptyWidget(),
              widget.route == "visit" ?
              EmptyWidget():
                 Padding(
                   padding: const EdgeInsets.only(top: 20),
                   child: Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               customCheckbox(
                                 isCheckbox: refNotifier.isEditDetails,
                                 onChanged: (val){
                                  refNotifier.isEditDetails = val!;
                                  setState(() {
                                  });
                                 }
                               ),
                               const SizedBox(width: 5,),
                               Flexible(
                                 child: Text('Do you want to request edit to the information?',
                                 ),
                               )
                             ],
                           ),
                 )
       ,
           const SizedBox(height: 40,),
           disableToEdit() ?
           EmptyWidget():
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextButton(title: "Cancel",color: AppColors.arcticBreeze,width: 100,height: 40,
                onTap: (){
                  Navigator.pop(context);
                },
                ),
                AppTextButton(title: "Next",color: AppColors.arcticBreeze,width: 100,height: 40,onTap: (){
                  refNotifier.checkvalidation(context,widget.route, widget.onDetails);
                },),
              ],
             )
            
            ],
          ),
        )
      ),
    );
  }

  Widget screenContentWidget(AddTrialPlanNotifier refNotifier, AddTrialPlanState refState){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      child: Column(
        children: [
         conductTypeWidget(refState),
         const SizedBox(height: 20,),
          dateTimeWidget(refNotifier),
          const SizedBox(height: 19,),
          LabelTextTextfield(title: 'Trail location', isRequiredStar: false),
          const SizedBox(height: 5),
          CustomDropDown(
            isEnable: !disableToEdit(),
            items: DropdownItemHelper().dropdownListt(AppConstants.triaLocList),
          hintText: "Select trail location",
          onChanged: (val){
            refNotifier.trialLocationController.text = val;
            setState(() {
            });
          },
          validator: (val){
            if((val??'').isEmpty){
              return "Required";
            }
            return null;
          },
          ),
          const SizedBox(height: 15,),
          LabelTextTextfield(title: 'Trail Type', isRequiredStar: false),
          const SizedBox(height: 5),
      CustomDropDown(
        isEnable: !disableToEdit(),
        selectedValue: selectedTrialType,
        items: DropdownItemHelper().dropdownListt(AppConstants.trailTypeList),
       hintText: "Select trail type",
          onChanged: (val){
            selectedTrialType  =val;
            refNotifier.onChangedTrailType(val);
            setState(() {
              
            });
          },
          validator: (val){
              if((val??'').isEmpty){
                return "Required";
              }
              return null;
            },
          ),
          widget.route == 'visit'? EmptyWidget() :
        userDetailsTextField(refNotifier, refState),
          const SizedBox(height: 15),
        LabelTextTextfield(title: 'Appointment Date', isRequiredStar: true),
        const SizedBox(height: 5),
         AppTextfield(
            fillColor: false,
            isReadOnly: true,
            controller: refNotifier.appointmentController,
            onTap: () {
              disableToEdit() ? null :
              DatePickerService.datePicker(context, selectedDate: selectedDate)
                  .then((picked) {
                if (picked != null) {
                  var day = picked.day < 10 ? '0${picked.day}' : picked.day;
                  var month =
                      picked.month < 10 ? '0${picked.month}' : picked.month;
                   refNotifier.appointmentController.text =
                      "${picked.year}-$month-$day";
                  setState(() {
                    selectedDate = picked;
                  });
                }
              });
            },
            suffixWidget: Container(
              height: 33,
              width: 33,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.add,
                color: AppColors.whiteColor,
                size: 20,
              ),
            ),
            validator: (val){
              if((val ?? '').isEmpty){
                return "Required";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget userDetailsTextField(AddTrialPlanNotifier refNotifier, AddTrialPlanState refState){
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            LabelTextTextfield(title: 'Visit Type', isRequiredStar: false),
          const SizedBox(height: 5),
          CustomDropDown(
            selectedValue: refNotifier.selectedVisitType,
            items: DropdownItemHelper().dropdownListt(AppConstants.visitTypeList),
          hintText: "Select visit type",
          onChanged: refNotifier.onChangedVisitType,
          validator: (val){
              if((val??'').isEmpty){
                return "Required";
              }
              return null;
            },
          ),
          if(refNotifier.visitTypeController.text == 'Secondary')...[
          const SizedBox(height: 15,),
           LabelTextTextfield(title: 'Channel Partner', isRequiredStar: false),
            const SizedBox(height: 5),
            AppTextfield(
              fillColor: false,
              isReadOnly: true,
              hintText: "channel partner",
              onTap: () {
                _handleChannelPartner(refNotifier);
              },
            controller: refNotifier.channelPartnerController,
            validator: (val){
              if((val??'').isEmpty){
                return "Required";
              }
              return null;
            },
            ),
          ],
            const SizedBox(height: 15,),
           LabelTextTextfield(title: 'Customer Name', isRequiredStar: false),
            const SizedBox(height: 5),
            AppTextfield(
              fillColor: false,
              isReadOnly: true,
              hintText: "customer name",
              onTap: () {
              _handleCustomerName(refNotifer: refNotifier, refState: refState);
              },
            controller: refNotifier.customerNameController,
            validator: (val){
              if((val??'').isEmpty){
                return "Required";
              }
              return null;
            },
            ),
      
            const SizedBox(height: 15,),
            LabelTextTextfield(title: 'Business Name', isRequiredStar: false),
            const SizedBox(height: 5),
            AppTextfield(fillColor: false,
            controller: refNotifier.businessNameController,
            hintText: "business name",
            isReadOnly: true,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              removeLeadingWhiteSpace(),
              emojiRestrict()
            ],
            validator: (val){
              if((val??'').isEmpty){
                return "Required";
              }
              return null;
            },
            ),
      
            const SizedBox(height: 15,),
            LabelTextTextfield(title: 'ContactNo.', isRequiredStar: false),
            const SizedBox(height: 5),
            AppTextfield(fillColor: false,
            isReadOnly: true,
            controller: refNotifier.contactNumberController,
            hintText: "contact number",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            validator: numberValidation
            ),
            // const SizedBox(height: 15,),
            // LabelTextTextfield(title: 'Location', isRequiredStar: false),
            // const SizedBox(height: 5),
            // AppTextfield(fillColor: false,
            // controller: refNotifier.locationController,
            // textInputAction: TextInputAction.next,
            // inputFormatters: [
            //   removeLeadingWhiteSpace(),
            //   emojiRestrict()
            // ],
            // validator: (val){
            //   if((val??'').isEmpty){
            //     return "Required";
            //   }
            //   return null;
            // },
            // ),
            const SizedBox(height: 15,),
            LabelTextTextfield(title: 'Address-1', isRequiredStar: true),
          const SizedBox(height: 5),
          AppTextfield(
            hintText: "Enter address1",
            fillColor: false,
            isReadOnly: true,
            textInputAction: TextInputAction.next,
            controller: refNotifier.address1Controller,
            inputFormatters: [
                  removeLeadingWhiteSpace(),
              emojiRestrict()
            ],
            validator: (val) {
              if (val!.isEmpty) {
                return "Required";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          LabelTextTextfield(title: 'Address-2', isRequiredStar: false),
          const SizedBox(height: 5),
          AppTextfield(
            hintText: "Enter address2",
            fillColor: false,
            isReadOnly: true,
            controller: refNotifier.address2Controller,
            inputFormatters: [
                  removeLeadingWhiteSpace(),
              emojiRestrict()
            ],
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 15),
            LabelTextTextfield(title: 'State', isRequiredStar: true),
          const SizedBox(height: 5),
            AppTextfield(
            controller: refNotifier.stateController,
            isReadOnly: true,
            fillColor: false,
            hintText: "State",
            suffixWidget: Icon(Icons.expand_more),
            validator: (val){
               if ((val??'').isEmpty) {
                return "Required";
              }
              return null;
            },
          ),
          // CustomDropDown(
          //   selectedValue: refNotifier.selectedStateValue,
          //   items: [],
          //   // refNotifier.stateController.text.isEmpty ? DropdownItemHelper().stateItems((refState.stateModel?.data??[])) : [],
          //   hintText:refNotifier.stateController.text.isEmpty ? "state" :refNotifier.stateController.text,
          //   onChanged: (val){
          //     refNotifier.onChangedStateVal(context, val);
          //     setState(() {
                
          //     });
          //   },
          // validator: (val) {
          //     if ((val??'').isEmpty) {
          //       return "Required";
          //     }
          //     return null;
          //   },
          // ),
          const SizedBox(height: 15),
          LabelTextTextfield(title: 'District', isRequiredStar: true),
          const SizedBox(height: 5),
          AppTextfield(
            controller: refNotifier.districtController,
            isReadOnly: true,

            fillColor: false,
            hintText: "District",
            suffixWidget: Icon(Icons.expand_more),
            validator: (val){
               if ((val??'').isEmpty) {
                return "Required";
              }
              return null;
            },
          ),
        //  CustomDropDown(
        //     selectedValue: refNotifier.selectedDistrictValue,
        //     items: 
        //      DropdownItemHelper().districtItems((refState.districtModel?.data??[])),
        //     hintText: "Select district",
        //     onChanged: (val){
        //       refNotifier.districtController.text = val;
        //       refNotifier.selectedDistrictValue = val;
        //       setState(() {
                
        //       });
        //     },
        //   validator: (val) {
        //       if ((val??'').isEmpty) {
        //         return "Required";
        //       }
        //       return null;
        //     },
        //   ),
           const SizedBox(height: 15),
          LabelTextTextfield(title: 'Pincode', isRequiredStar: true),
          const SizedBox(height: 5),
          AppTextfield(
            hintText: "Enter pincode",
            fillColor: false,
            isReadOnly: true,
            controller: refNotifier.pincodeController,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: pincodeValidation
          ),
          
        ],
      ),
    );
  }

  dateTimeWidget(AddTrialPlanNotifier refNotifier){
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelTextTextfield(title: "Date", isRequiredStar: false),
            const SizedBox(height: 10,),
            AppDateWidget(
              title: refNotifier.dateController.text,
              onTap: (){
                disableToEdit() ? null :
                datePickerBottomsheet(context);
              },
            )
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelTextTextfield(title: "Time", isRequiredStar: false),
            const SizedBox(height: 10,),
            AppDateWidget(
              hintText: 'HH-MM',
              title: refNotifier.timeController.text,
              onTap: (){
                disableToEdit() ? null :
                _selectTime(context);
              },
            )
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget conductTypeWidget(AddTrialPlanState refState){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Select Conduct Type", isRequiredStar: false),
        const SizedBox(height: 10,),
        Row(
          children: [
            customRadioButton(isSelected: refState.selectedConductType==0? true:false, title: 'Self',
            onTap: (){
              disableToEdit() ? null :
              refState.selectedConductType=0;
              setState(() {
                
              });
            }),
            const Spacer(),
            customRadioButton(isSelected:refState.selectedConductType==1?true: false, title: 'TSM Required',
            onTap: (){
              disableToEdit() ? null :
              refState.selectedConductType=1;
              setState(() { 
              });
            }),
            const Spacer(),
          ],
        )
      ],
    );
  }

  selectItemWidget(AddTrialPlanNotifier refNotifier){
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
         border: Border.all(color: AppColors.e2Color),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.black.withValues(alpha: .1),
            blurRadius: 1
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title: refNotifier.trailTypeController.text == 'Product'? "Selected Products": 'Selected Items',fontFamily:AppFontfamily.poppinsSemibold,fontsize: 12,),
             disableToEdit() ? EmptyWidget() :
              GestureDetector(
                onTap: (){
                  if(refNotifier.trailTypeController.text == 'Product'){
                    addItemBottomSheet(context, refNotifier);
                  }
                  else{
                    AppRouter.pushCupertinoNavigation(const SearchScreen(route: 'itemTemplateSalesOrder')).then((value){
              if((value??'').isNotEmpty){
                itemTemplate = value;
                 itemsApiFunction(context, searchText: '').then((val){
              if(val!=null){
                addItemBottomSheet(context, refNotifier);
              }
              setState(() {
                
              });
            });
           
              }
            });

                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.lightBlue62Color,width: .5)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                  child: Row(
                    children: [
                      Icon(Icons.add,color: AppColors.lightBlue62Color,size: 15,),
                      AppText(title: "Add ${refNotifier.trailTypeController.text == 'Product'?"Products":"Items"}",fontsize: 12,)
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          refNotifier.selectedItem.isEmpty && refNotifier.selectedProduct.isEmpty?
          EmptyWidget():
             Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.e2Color, width: .5),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
              child: refNotifier.trailTypeController.text == "Product"?
               ListView.separated(
                  separatorBuilder: (ctx, sb) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: refNotifier.selectedProduct.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    var model = refNotifier.selectedProduct[index];
                    return Row(
                      children: [
                        Expanded(
                            child: AppText(
                          title: (model.productName ?? ''),
                        )),
                        disableToEdit() ? EmptyWidget() :
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: InkWell(
                              onTap: () {
                                model.isSelected=false;
                                refNotifier.selectedProduct.removeAt(index);
                                setState(() {});
                              },
                              child: SizedBox(
                                height: 20,width: 30,
                                child: SvgPicture.asset(AppAssetPaths.deleteIcon))),
                        )
                      ],
                    );
                  }):
               ListView.separated(
                  separatorBuilder: (ctx, sb) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: refNotifier.selectedItem.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    var model = refNotifier.selectedItem[index];
                    return Row(
                      children: [
                        Expanded(
                            child: AppText(
                          title: (model.itemName ?? ''),
                        )),
                         disableToEdit() ? EmptyWidget() :
                        InkWell(
                            onTap: () {
                              model.isSelected=false;
                              refNotifier.selectedItem.removeAt(index);
                              setState(() {});
                            },
                            child: SizedBox(
                              height: 20,width: 30,
                              child: SvgPicture.asset(AppAssetPaths.deleteIcon)))
                      ],
                    );
                  })),
      
        ],
      ),
    );
  }
  datePickerBottomsheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors.whiteColor,
        context: context,
        builder: (context) {
          return Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              child: StatefulBuilder(builder: (context, state) {
                return ViewDatePickerWidget(
                    selectedDay: selectedDay,
                    focusedDay: focusedDay,
                    onDaySelected: (selectedDay, focusedDay) {
                      state(() {});
                      this.selectedDay = selectedDay;
                      this.focusedDay = focusedDay;
                      setState(() {
                        
                      });
                    },
                    applyTap: () {
                      state(() {});
                      setState(() {
                        
                      });
                      ref
                          .read(addTrialPlanProvider.notifier)
                          .dateController
                          .text = AppDateFormat.datePickerView(selectedDay);
                      Navigator.pop(context);
                    });
              }),
            );
          });
        });
  }
   

  addItemBottomSheet(BuildContext context,AddTrialPlanNotifier refNotifier ) {
    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: 14, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 11),
                      child: Row(
                        children: [
                          const Spacer(),
                          AppText(
                            title: refNotifier.trailTypeController.text == 'Product'? "Select Products": 'Select Items', 
                            fontsize: 16,
                            fontFamily: AppFontfamily.poppinsSemibold,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 24,
                              width: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.edColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.close,
                                size: 19,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: AppTextfield(
                        fillColor: false,
                        suffixWidget: Container(
                          padding: EdgeInsets.all(10),
                          child: SvgPicture.asset(AppAssetPaths.searchIcon),
                        ),
                        onChanged: (val){
                          _onChangedSearchForItem(val, state, refNotifier);
                        },
                      ),
                    ),
                    refNotifier.trailTypeController.text == 'Product'?
                    _createProductsForBottomSheetWidget(state, refNotifier: refNotifier):
                    _createItemsForBottomSheetWidget(state, refNotifier: refNotifier)
                    // (itemModel?.dataz?.length ?? 0) > 0
                    //     ? ListView.separated(
                    //         separatorBuilder: (ctx, index) {
                    //           return const SizedBox(
                    //             height: 10,
                    //           );
                    //         },
                    //         shrinkWrap: true,
                    //         padding: EdgeInsets.only(
                    //             left: 15, right: 15, top: 20, bottom: 15),
                    //         itemCount: (itemModel?.data?.length ?? 0),
                    //         itemBuilder: (ctx, index) {
                    //           var model = itemModel?.data![index];
                    //           return Container(
                    //             height: 40,
                    //             alignment: Alignment.centerLeft,
                    //             decoration: BoxDecoration(
                    //                 border: Border(
                    //                     bottom: BorderSide(
                    //                         width: 1,
                    //                         color: AppColors.light92Color
                    //                             .withValues(alpha: .5)))),
                    //             child: Row(
                    //               children: [
                    //                 Expanded(
                    //                     child: AppText(
                    //                   title: model?.itemName ?? '',
                    //                   maxLines: 1,
                    //                 )),
                    //                 InkWell(
                    //                   onTap: () {
                    //                     if (model?.isSelected == false) {
                    //                       model?.isSelected = true;
                    //                       refNotifier.selectedItem.add(model!);
                    //                     } else {
                    //                       model?.isSelected = false;
                    //                       for (int i = 0;
                    //                           i < refNotifier.selectedItem.length;
                    //                           i++) {
                    //                         if (refNotifier.selectedItem[i].isSelected ==
                    //                             false) {
                    //                           refNotifier.selectedItem.removeAt(i);
                    //                         }
                    //                       }
                    //                     }
                    //                     setState(() {
                                          
                    //                     });
                    //                     state(() {});
                    //                   },
                    //                   child: Container(
                    //                     height: 20,
                    //                     width: 20,
                    //                     alignment: Alignment.center,
                    //                     decoration: BoxDecoration(
                    //                         color: AppColors.edColor,
                    //                         borderRadius:
                    //                             BorderRadius.circular(5)),
                    //                     child: Icon(
                    //                       (model?.isSelected ?? false) == false
                    //                           ? Icons.add
                    //                           : Icons.remove,
                    //                       size: 20,
                    //                       color: (model?.isSelected ?? false) ==
                    //                               false
                    //                           ? AppColors.greenColor
                    //                           : AppColors.redColor,
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           );
                    //         })
                    //     : Padding(
                    //       padding: const EdgeInsets.only(top: 15),
                    //       child: NoDataFound(title: "No items found"),
                    //     )
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget _createItemsForBottomSheetWidget(state, {required AddTrialPlanNotifier refNotifier}){
return     (itemModel?.data?.length ?? 0) > 0
                      ? ListView.separated(
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 15),
                          itemCount: (itemModel?.data?.length ?? 0),
                          itemBuilder: (ctx, index) {
                            var model = itemModel?.data![index];
                            return Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: AppColors.light92Color
                                              .withValues(alpha: .5)))),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: AppText(
                                    title: model?.itemName ?? '',
                                    maxLines: 1,
                                  )),
                                  InkWell(
                                    onTap: () {
                                      if((model?.isSelected ?? false)==true){
                                        model?.isSelected = false;
                                        for (int i = 0;
                                            i < refNotifier.selectedItem.length;
                                            i++) {
                                          if (refNotifier.selectedItem[i].isSelected ==
                                              false) {
                                            refNotifier.selectedItem.removeAt(i);
                                          }
                                        } 
                                      }
                                      else{
                                      bool isMatchingItemFound =
                                         refNotifier.selectedItem.any((selectedValue) {
                                        return model?.itemCode ==
                                            selectedValue.itemCode ? true : false;
                                      });
                                       if(isMatchingItemFound){
                                      MessageHelper.showToast("Already added");
                                      }
                                      else{
                                      if (model?.isSelected == false) {
                                        model?.isSelected = true;
                                        refNotifier.selectedItem.add(model!);
                                      } else {
                                        model?.isSelected = false;
                                        for (int i = 0;
                                            i < refNotifier.selectedItem.length;
                                            i++) {
                                          if (refNotifier.selectedItem[i].isSelected ==
                                              false) {
                                            refNotifier.selectedItem.removeAt(i);
                                          }
                                        }
                                      }
                                      }
                                      } setState(() {
                                        
                                      });
                                      state(() {}); },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.edColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Icon(
                                        (model?.isSelected ?? false) == false
                                            ? Icons.add
                                            : Icons.remove,
                                        size: 20,
                                        color: (model?.isSelected ?? false) ==
                                                false
                                            ? AppColors.greenColor
                                            : AppColors.redColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                      : Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: NoDataFound(title: "No items found"),
                      );
  }

  Widget _createProductsForBottomSheetWidget(state, {required AddTrialPlanNotifier refNotifier}){
return     (productModel?.data?.length ?? 0) > 0
                      ? ListView.separated(
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 15),
                          itemCount: (productModel?.data?.length ?? 0),
                          itemBuilder: (ctx, index) {
                            var model = productModel?.data![index];
                            return Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: AppColors.light92Color
                                              .withValues(alpha: .5)))),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: AppText(
                                    title: model?.productName ?? '',
                                    maxLines: 1,
                                  )),
                                  InkWell(
                                    onTap: () {
                                      bool isMatchingItemFound =
                                         refNotifier.selectedProduct.any((selectedValue) {
                                        return model?.productName ==
                                            selectedValue.productName ? true : false;
                                      });
                                       if(isMatchingItemFound){
                                      MessageHelper.showToast("Already added");
                                      }
                                      else{
                                      if (model?.isSelected == false) {
                                        model?.isSelected = true;
                                        refNotifier.selectedProduct.add(model!);
                                      } else {
                                        model?.isSelected = false;
                                        for (int i = 0;
                                            i < refNotifier.selectedProduct.length;
                                            i++) {
                                          if (refNotifier.selectedProduct[i].isSelected ==
                                              false) {
                                            refNotifier.selectedProduct.removeAt(i);
                                          }
                                        }
                                      }
                                      }
                                      print(refNotifier.selectedProduct);
                                      setState(() {
                                        
                                      });
                                      state(() {});
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.edColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Icon(
                                        (model?.isSelected ?? false) == false
                                            ? Icons.add
                                            : Icons.remove,
                                        size: 20,
                                        color: (model?.isSelected ?? false) ==
                                                false
                                            ? AppColors.greenColor
                                            : AppColors.redColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                      : Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: NoDataFound(title: "No items found"),
                      );
  }

 
 //// helper method

Future<void> _selectTime(BuildContext context) async {
    // Display the time picker
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked; // Update the selected time
         final hour = _selectedTime.hour < 10 ? '0${_selectedTime.hour}' : '${_selectedTime.hour}';
    final minute = _selectedTime.minute < 10 ? '0${_selectedTime.minute}' : '${_selectedTime.minute}';
        ref.read(addTrialPlanProvider.notifier).timeController.text = "$hour:$minute";
      });
    }
  }


   _onChangedSearchForItem(String val, state, AddTrialPlanNotifier refNotifier) {
    if(val.isEmpty){
      if(refNotifier.trailTypeController.text == 'Product'){
        productApiFunction('');
        state((){});
      }
      else{
        itemsApiFunction(context, searchText: '');
        state((){});
      }
    }
    else{
      if(refNotifier.trailTypeController.text == 'Product'){
        productApiFunction(val).then((val){
        if(val!=null){
          state((){});
        }
      });
      }
      else{
      itemsApiFunction(context,searchText:  val,).then((val){
        if(val!=null){
          state((){});
        }
      });
      }
      
    }
    setState(() {
      
    });
  }



Future itemsApiFunction(BuildContext context, {required String searchText})async{ 
  itemModel = null;
  final response = await ApiService().makeRequest(apiUrl: "${ApiUrls.salesItemVariantUrl}?search_text=$searchText&item_template=$itemTemplate", method: ApiMethod.get.name);
  if(response!=null){
    itemModel =  ItemModel.fromJson(response.data);
    return response;
  }
  else{
  }
  setState((){});
}

_handleChannelPartner(AddTrialPlanNotifier refNotifier){
   AppRouter.pushCupertinoNavigation(SearchScreen(
              route: 'channel',
            )).then((val) {
              if (val != null) {
                if(refNotifier.channelPartnerController.text != val){
                  refNotifier.resetOnChangedVerifyType();
                }
                refNotifier.channelPartnerController.text = val;
                setState(() {});
              }
            });
}


_handleCustomerName({required AddTrialPlanNotifier refNotifer, required AddTrialPlanState refState,}){
        if (refNotifer.visitTypeController.text.isEmpty) {
            MessageHelper.showToast("Please select the visit type");
          } else if(refNotifer.visitTypeController.text == "Secondary" && refNotifer.channelPartnerController.text.isEmpty){
              MessageHelper.showToast("Please select the channel partner");
          }
           else {
            refState.customerInfoModel = null;
            refState.unvCustomerModel = null;
            AppRouter.pushCupertinoNavigation(SearchScreen(
              route: 'verified',
              visitType: refNotifer.visitTypeController.text,
              showCustomerStatus: true,
            )).then((val) {
              if (val != null) {
               refNotifer. selectedStateValue = null;
               refNotifer. selectedDistrictValue = null;
                refNotifer.resetOnChangedVerifyType();
                ///
                  CustomerDetails model = val;
                      refNotifer.contactNumberList = (model.contact??[]);
                    refNotifer.businessNameController.text = model.shopName ?? '';
                    refNotifer.customer = model.name ?? '';
                    refNotifer.customerNameController.text = model.customerName ?? '';
                    refNotifer.selectedVerifyType = model.verificType ?? '';
                    refNotifer.selectedShop = model.shop ?? '';
                    if (refNotifer.contactNumberList.isNotEmpty) {
                      refNotifer.contactNumberController.text =
                          refNotifer.contactNumberList[0];
                    }
                    /// calling address api
                  refNotifer
                      .customerAddressApiFunction(context, model.name ?? '', model.verificType ?? '')
                      .then((response) {
                        if(response!=null&& response['data'].isNotEmpty){
                    CustomerAddressModel addressModel =
                        CustomerAddressModel.fromJson(response);
                       refNotifer.verifiedCustomerLocation = (addressModel.data?.name??'');
                    refNotifer.address1Controller.text = addressModel.data?.addressLine1 ?? '';
                    refNotifer.address2Controller.text = addressModel.data?.addressLine2 ?? '';
                    refNotifer.districtController.text = addressModel.data?.district ?? '';
                    refNotifer.stateController.text = addressModel.data?.state ?? '';
                    refNotifer.pincodeController.text = addressModel.data?.pincode ?? '';
                    refNotifer.addressTypeController.text = addressModel.data?.addressTitle ?? '';
                    // refNotifer.selectedStateValue = addressModel.data?.state;
                        // if((addressModel.data?.state??'').isNotEmpty){
                        //   refNotifer.districtApiFunction(context, stateText: addressModel.data?.state);
                        //   refNotifer.selectedDistrictValue = addressModel.data?.district;
                        // }
                    
                        }
                  });
                
                setState(() {});
              }
            });
          }
}

productApiFunction(String searchText)async{
  productModel =  null;
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.productUrl}?fields=["product_name"]&filters=[["product_name", "like", "%$searchText%"]]', method:ApiMethod.get.name);
  if(response!=null){
  productModel = ProductModel.fromJson(response.data);
  //  print(state.productModel?.data);
  } 
  setState(() {
    
  });
}


}
class LabelTextTextfield extends StatelessWidget {
  final String title;
  final bool isRequiredStar;
  const LabelTextTextfield({required this.title, required this.isRequiredStar});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(title: title,color: AppColors.black,fontFamily: AppFontfamily.poppinsMedium,),
      ],
    );
  }
}
