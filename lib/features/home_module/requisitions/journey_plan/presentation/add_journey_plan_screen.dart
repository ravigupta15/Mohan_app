import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/services/date_picker_service.dart';
import 'package:mohan_impex/core/widget/app_date_widget.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/custom_drop_down.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/riverpod/journey_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/riverpod/journey_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/empty_widget.dart';

class AddJourneyPlanScreen extends ConsumerStatefulWidget {
  const AddJourneyPlanScreen({super.key});

  @override
  ConsumerState<AddJourneyPlanScreen> createState() => _AddJourneyPlanScreenState();
}

class _AddJourneyPlanScreenState extends ConsumerState<AddJourneyPlanScreen> {
DateTime? fromDate;
  DateTime? todDate;
  String? selectedDistrictValue;
  String? selectedStateValue;
  @override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

callInitFunction(){
final refNotifier = ref.read(journeyProvider.notifier);
ref.watch(journeyProvider).districtModel=null;
setState(() {
refNotifier.resetAddValues();
});

refNotifier.stateApiFunction(context);

}

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(journeyProvider.notifier);
    final refState = ref.watch(journeyProvider);
    return Scaffold(
      appBar: customAppBar(title: "Journey Plan",),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 19,right: 18,top: 12,bottom: 20),
        child: Form(
          key: refNotifier.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              visitDateWidget(refNotifier),
              const SizedBox(height: 15,),
              LabelTextTextfield(title: "Nature of Travel", isRequiredStar: false),
              const SizedBox(height: 8,),
                CustomDropDown(items: naturalTravelItems(refNotifier.naturalTravelList),
             hintText: "Select nature of travel",
             onChanged: (val){
              refNotifier.onChangedNaturalTravl(val);
              setState(() {
                
              });
             },
             validator: (val) {
                    if ((val ?? "").isEmpty) {
                      return "Please select nature of travel";
                    }
                    return null;
                  },
             ),
             refNotifier.naturalOfTravelController.text.toLowerCase() == "night out"?
             Padding(
               padding: const EdgeInsets.only(top: 15),
               child: Column(
                children: [
                   LabelTextTextfield(title: "Night Out Location", isRequiredStar: false),
                const SizedBox(height: 8,),
                AppTextfield(
                fillColor: false,
                controller: refNotifier.naturalOutLocationController,
                textInputAction: TextInputAction.next,
                validator: (val){
                  if((val??'').isEmpty){
                    return "Please enter night out location";
                  }
                  return null;
                }
               ),
                ],
               ),
             ) : EmptyWidget(),
             const SizedBox(height: 15,),
              LabelTextTextfield(title: "Travel To State", isRequiredStar: false),
              const SizedBox(height: 8,),
              CustomDropDown(items: stateItems((refState.stateModel?.data??[])),
             hintText: "Select state",
            //  selectedValue: selectedStateValue,
             onChanged: (val){
                selectedDistrictValue = null;
                selectedStateValue = val;
              refNotifier.onChangedState(context, val);
              setState(() {
                
              });
             },
             validator: (val) {
                    if ((val ?? "").isEmpty) {
                      return "Please select the state";
                    }
                    return null;
                  },
             ),
             const SizedBox(height: 15,),
              LabelTextTextfield(title: "Travel To District", isRequiredStar: false),
            const SizedBox(height: 8,),
            CustomDropDown(items: districtItems((refState.districtModel?.data??[])),
             hintText: "Select district",
             onChanged: (val){
              refNotifier.onChangedDistrict(val);
              selectedDistrictValue = val;
              setState(() {
              });
             },
             selectedValue: selectedDistrictValue,
             validator: (val) {
                    if ((val ?? "").isEmpty) {
                      return "Please select the district";
                    }
                    return null;
                  },
             ),
           const SizedBox(height: 15,),
              LabelTextTextfield(title: "Mode of travel", isRequiredStar: false),
              const SizedBox(height: 8,),
               CustomDropDown(items: naturalTravelItems(refNotifier.modelTravelList),
             hintText: "Select mode of travel",
             onChanged: refNotifier.onChangedModeTravel,
             validator: (val) {
                    if ((val ?? "").isEmpty) {
                      return "Please select mode of travel";
                    }
                    return null;
                  },
             ),
             const SizedBox(height: 15,),
              LabelTextTextfield(title: "Remarks", isRequiredStar: false),
              const SizedBox(height: 8,),
              AppTextfield(
                controller: refNotifier.remarksController,
              fillColor: false,
              maxLines: 3,
              validator: (val){
                if((val??'').isEmpty){
                  return "Please enter remakrs";
                }
                return null;
              },
             ),
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
                  print(refState.districtModel?.data);
                  refNotifier.checkvalidation(context);
                },),
              ],
             )
            ],
          ),
        ),
      ),
    );
  }

  Widget visitDateWidget(JourneyNotifier refNotifier){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title: "Visit Date",color: AppColors.lightTextColor),
            const SizedBox(height: 10,),
             Row(
                children: [
                       AppDateWidget(
              onTap: () {
                DatePickerService.datePicker(context, selectedDate: fromDate)
                    .then((picked) {
                  if (picked != null) {
                    var day = picked.day < 10 ? '0${picked.day}' : picked.day;
                    var month =
                        picked.month < 10 ? '0${picked.month}' : picked.month;
                    refNotifier.fromDateController.text =
                        "${picked.year}-$month-$day";
                    setState(() {
                      fromDate = picked;
                    });
                  }
                });
              },
              title: refNotifier.fromDateController.text,
            ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    width: 8,height: 2,
                    color: AppColors.black,
                  ),
                           AppDateWidget(
              onTap: () {
                DatePickerService.datePicker(context, selectedDate: todDate)
                    .then((picked) {
                  if (picked != null) {
                    var day = picked.day < 10 ? '0${picked.day}' : picked.day;
                    var month =
                        picked.month < 10 ? '0${picked.month}' : picked.month;
                    refNotifier.toController.text =
                        "${picked.year}-$month-$day";
                    setState(() {
                      todDate = picked;
                    });
                  }
                });
              },
              title: refNotifier.toController.text,
            ),
                ],
              ),
      ],
    );
  }


  List<DropdownMenuItem<String>> naturalTravelItems(List list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item,
            child: Text(
              item,
            ),
          ),
          if (item != list.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }



  List<DropdownMenuItem<String>> stateItems(List<StateItems> list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item.name,
            child: Text(
              item.name,
            ),
          ),
          if (item != list.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }


  List<DropdownMenuItem<String>> districtItems(List<DistrictItem> list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item.district,
            child: Text(
              item.district??'',
            ),
          ),
          if (item != list.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

}