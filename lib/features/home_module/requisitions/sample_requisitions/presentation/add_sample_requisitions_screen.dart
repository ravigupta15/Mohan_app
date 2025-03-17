import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/core/widget/date_picker_bottom_sheet.dart';
import 'package:mohan_impex/features/common_widgets/remarks_widgets.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/item_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/add_remove_container_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/riverpod/sample_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/sample_requisitions/riverpod/sample_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/utils/app_date_format.dart';
import 'package:mohan_impex/utils/message_helper.dart';

import '../../../../../res/no_data_found_widget.dart';

class AddSampleRequisitionsScreen extends ConsumerStatefulWidget {
  const AddSampleRequisitionsScreen({super.key});

  @override
  ConsumerState<AddSampleRequisitionsScreen> createState() =>
      _AddSampleRequisitionsScreenState();
}

class _AddSampleRequisitionsScreenState
    extends ConsumerState<AddSampleRequisitionsScreen> {
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
    final refNotifier = ref.read(sampleProvider.notifier);
    refNotifier.resetAddSampleValues();
    itemsApiFunction(context, '');
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(sampleProvider.notifier);
    return Scaffold(
      appBar: customAppBar(
        title: "Sample Requisitions",
      ),
      body: Form(
        key: refNotifier.formKey,
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 19, top: 14, right: 18, bottom: 20),
          child: Column(
            children: [
              _selectedItemWidget(refNotifier),
              const SizedBox(
                height: 15,
              ),
              sampleDateWidget(refNotifier),
              const SizedBox(
                height: 15,
              ),
              RemarksWidget(
                controller: refNotifier.remarksController,
                validator: (val) {
                  if ((val ?? "").isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 20, left: 120, right: 120),
        child: AppTextButton(
          title: "Submit",
          color: AppColors.arcticBreeze,
          height: 38,
          width: 100,
          onTap: () {
            refNotifier.checkvalidation(context);
          },
        ),
      ),
    );
  }

  sampleDateWidget(SampleNotifier refNotifier) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withValues(alpha: .2),
                blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title: 'Sample Required date',
            fontFamily: AppFontfamily.poppinsSemibold,
            fontsize: 12,
          ),
          const SizedBox(
            height: 12,
          ),
          AppTextfield(
            fillColor: false,
            isReadOnly: true,
            controller: refNotifier.sampleDateController,
            onTap: () {
              datePickerBottomsheet(
                context,
              );
            },
            suffixWidget: Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(6)),
              child: Icon(
                Icons.add,
                color: AppColors.whiteColor,
                size: 30,
              ),
            ),
            validator: (val) {
              if ((val ?? '').isEmpty) {
                return "Required";
              }
              return null;
            },
          )
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
                    },
                    applyTap: () {
                      state(() {});
                      ref
                          .read(sampleProvider.notifier)
                          .sampleDateController
                          .text = AppDateFormat.datePickerView(selectedDay);
                      Navigator.pop(context);
                    });
              }),
            );
          });
        });
  }

  Widget _selectedItemWidget(SampleNotifier refNotifier) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: AppColors.black.withValues(alpha: .2),
                blurRadius: 10)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                title: 'Selected Items',
                fontFamily: AppFontfamily.poppinsSemibold,
                fontsize: 12,
              ),
              GestureDetector(
                onTap: () {
                  addItemBottomSheet(context,refNotifier);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.edColor)),
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColors.lightBlue62Color,
                        size: 15,
                      ),
                      AppText(
                        title: "Add Items",
                        fontsize: 12,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
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
                        customContainerForAddRemove(
                            isAdd: false,
                            onTap: () {
                              if ((model.quantity) > 0) {
                                model.quantity = model.quantity - 1;
                                setState(() {});
                              }
                            }),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: 20,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.greenColor)),
                          child: AppText(
                            title: (model.quantity) == 0
                                ? ''
                                : (model.quantity).toString(),
                            fontsize: 13,
                          ),
                        ),
                        customContainerForAddRemove(
                            isAdd: true,
                            onTap: () {
                              model.quantity = model.quantity + 1;
                              setState(() {});
                            }),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: () {
                              model.isSelected=false;
                              model.quantity=0;
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

  addItemBottomSheet(BuildContext context,SampleNotifier refNotifier ) {
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
