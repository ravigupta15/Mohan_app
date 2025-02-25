import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/custom_drop_down.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/custom_radio_button.dart';
import 'package:mohan_impex/core/widget/date_picker_bottom_sheet.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/custom_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/trial_plan/riverpod/trial_plan_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/empty_widget.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/utils/app_date_format.dart';
import 'package:mohan_impex/utils/app_validation.dart';
import '../../../../../res/app_fontfamily.dart';

class AddTrialScreen extends ConsumerStatefulWidget {
  const AddTrialScreen({super.key});

  @override
  ConsumerState<AddTrialScreen> createState() => _AddTrialScreenState();
}

class _AddTrialScreenState extends ConsumerState<AddTrialScreen> with AppValidation {
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0); // Default time
 DateTime selectedDay = DateTime.now(); // Track the selected day
  DateTime focusedDay = DateTime.now();
 
ItemModel?itemModel;

 @override
  void initState() {
    Future.microtask(() {
      callInitFunction();
    });
    super.initState();
  }
callInitFunction() {
    final refNotifier = ref.read(trialPlanProvider.notifier);
    refNotifier.resetAddTrialValues();
    itemsApiFunction(context, '');
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(trialPlanProvider.notifier);
    final refState = ref.watch(trialPlanProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(title: 'Trial Plan'),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 18,right: 19,top: 14,bottom: 30),
        child:Form(
          key: refNotifier.formKey,
          child: Column(
            children: [
              screenContentWidget(refNotifier,refState),
              const SizedBox(height: 30,),
              selectItemWidget(refNotifier),
              const SizedBox(height: 30,),
              RemarksWidget(
                controller: refNotifier.remarksController,
                validator: (val){
                  if((val??'').isEmpty){
                    return "Required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30,),
              
           const SizedBox(height: 40,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextButton(title: "Cancel",color: AppColors.arcticBreeze,width: 100,height: 40,
                onTap: (){
                  Navigator.pop(context);
                },
                ),
                AppTextButton(title: "Next",color: AppColors.arcticBreeze,width: 100,height: 40,onTap: (){
                  refNotifier.checkvalidation(context);
                  // AppRouter.pushCupertinoNavigation( SuccessScreen(
                  //   title: '',
                  //   des: "You have successfukky Submitted", btnTitle: "Track", onTap: (){
                  //   Navigator.pop(context);
                  //   Navigator.pop(context);
                  // }));
                },),
              ],
             )
            
            ],
          ),
        )
      ),
    );
  }

  Widget screenContentWidget(TrialPlanNotifier refNotifier, TrialPlanState refState){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.e2Color),
      ),
      child: Column(
        children: [
         trialTypeWidget(refState),
         const SizedBox(height: 20,),
          dateTimeWidget(refNotifier),
          const SizedBox(height: 19,),
          LabelTextTextfield(title: 'Trial location', isRequiredStar: false),
          const SizedBox(height: 5),
          AppTextfield(fillColor: false,
          controller:refNotifier.trialLocationController,
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
          LabelTextTextfield(title: 'Trail Type', isRequiredStar: false),
          const SizedBox(height: 5),
         
      CustomDropDown(items:refNotifier. dropDownMenuItems(refNotifier.trailTypeList),
          onChanged: refNotifier.onChangedVisitType,
          validator: (val){
              if((val??'').isEmpty){
                return "Required";
              }
              return null;
            },
          ),

          const SizedBox(height: 15,),
          LabelTextTextfield(title: 'Visit Type', isRequiredStar: false),
          const SizedBox(height: 5),
          CustomDropDown(items: refNotifier.dropDownMenuItems(refNotifier.visitTypeList),
          onChanged: refNotifier.onChangedVisitType,
          validator: (val){
              if((val??'').isEmpty){
                return "Required";
              }
              return null;
            },
          ),

          const SizedBox(height: 15,),
          LabelTextTextfield(title: 'Customer Name', isRequiredStar: false),
          const SizedBox(height: 5),
          AppTextfield(fillColor: false,
          controller: refNotifier.customerNameController,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            removeLeadingWhiteSpace(),
          ],
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
          controller: refNotifier.customerNameController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10)
          ],
          validator: numberValidation
          ),
          const SizedBox(height: 15,),
          LabelTextTextfield(title: 'Location', isRequiredStar: false),
          const SizedBox(height: 5),
          AppTextfield(fillColor: false,
          controller: refNotifier.locationController,
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
          LabelTextTextfield(title: 'Address-1', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter address1",
          fillColor: false,
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
        LabelTextTextfield(title: 'Address-2', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter address2",
          fillColor: false,
          controller: refNotifier.address2Controller,
          inputFormatters: [
                removeLeadingWhiteSpace(),
            emojiRestrict()
          ],
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "Required";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'City', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter city",
          fillColor: false,
          controller: refNotifier.cityController,
          inputFormatters: [
                removeLeadingWhiteSpace(),
            emojiRestrict()
          ],
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "Required";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'State', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter state",
          fillColor: false,
          controller: refNotifier.stateController,
          inputFormatters: [
                removeLeadingWhiteSpace(),
            emojiRestrict()
          ],
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val!.isEmpty) {
              return "Required";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        LabelTextTextfield(title: 'Pincode', isRequiredStar: true),
        const SizedBox(height: 5),
        AppTextfield(
          hintText: "Enter pincode",
          fillColor: false,
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

  dateTimeWidget(TrialPlanNotifier refNotifier){
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
                _selectTime(context);
              },
            )
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget trialTypeWidget(TrialPlanState refState){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextTextfield(title: "Select Trial Type", isRequiredStar: false),
        const SizedBox(height: 10,),
        Row(
          children: [
            customRadioButton(isSelected: refState.selectedTrialPlan==0? true:false, title: 'Self',
            onTap: (){
              refState.selectedTrialPlan=0;
              setState(() {
                
              });
            }),
            const Spacer(),
            customRadioButton(isSelected:refState.selectedTrialPlan==1?true: false, title: 'TSM Required',
            onTap: (){
              refState.selectedTrialPlan=1;
              setState(() { 
              });
            }),
            const Spacer(),
          ],
        )
      ],
    );
  }

  selectItemWidget(TrialPlanNotifier refNotifier){
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
              AppText(title: 'Selected Items',fontFamily:AppFontfamily.poppinsSemibold,fontsize: 12,),
              GestureDetector(
                onTap: (){
                  addItemBottomSheet(context, refNotifier);
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
                      AppText(title: "Add Items",fontsize: 12,)
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          refNotifier.selectedItem.isEmpty?
          EmptyWidget():
             Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.e2Color, width: .5),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
              child: ListView.separated(
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
                        InkWell(
                            onTap: () {
                              model.isSelected=false;
                              refNotifier.selectedItem.removeAt(index);
                              if (index > 0) {
                                refNotifier.selectedItem.clear();
                              } else {}
                              setState(() {});
                            },
                            child: SvgPicture.asset(AppAssetPaths.deleteIcon))
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
                          .read(trialPlanProvider.notifier)
                          .dateController
                          .text = AppDateFormat.datePickerView(selectedDay);
                      Navigator.pop(context);
                    });
              }),
            );
          });
        });
  }
   

  addItemBottomSheet(BuildContext context,TrialPlanNotifier refNotifier ) {
    showModalBottomSheet(
        backgroundColor: AppColors.whiteColor,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
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
                          title: "Select Items",
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
                        _onChangedSearchForItem(val, state);
                      },
                    ),
                  ),
                  (itemModel?.data?.length ?? 0) > 0
                      ? ListView.separated(
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          shrinkWrap: true,
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
                      )
                ],
              ),
            );
          });
        });
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
        ref.read(trialPlanProvider.notifier).timeController.text = "$hour-$minute";
      });
    }
  }


   _onChangedSearchForItem(String val, state) {
    if(val.isEmpty){
      itemsApiFunction(context,'');
    }
    else{
      itemsApiFunction(context,val,).then((val){
        if(val!=null){
          state((){});
        }
      });
    }
    state(() {
      
    });
  }



Future itemsApiFunction(BuildContext context, String searchText,)async{ 
  itemModel = null;
  final response = await ApiService().makeRequest(apiUrl: '${ApiUrls.itemListUrl}?fields=["item_code", "item_name","item_category", "competitor"]&filters=[["item_name", "like", "%$searchText%"]]', method: ApiMethod.get.name);
  if(response!=null){
    itemModel =  ItemModel.fromJson(response.data);
    return response;
  }
  else{
  }
  setState((){});
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
