import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/core/widget/app_text_field/custom_search_drop_down.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/widgets/add_remove_container_widget.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/riverpod/collaterals_request_notifier.dart';
import 'package:mohan_impex/features/home_module/requisitions/marketing_collaterals/riverpod/collaterals_request_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';

class AddMarketingCollateralsScreen extends ConsumerStatefulWidget {
  const AddMarketingCollateralsScreen({super.key});

  @override
  ConsumerState<AddMarketingCollateralsScreen> createState() =>
      _AddMarketingCollateralsScreenState();
}

class _AddMarketingCollateralsScreenState
    extends ConsumerState<AddMarketingCollateralsScreen> {
  @override
  void initState() {
    Future.microtask(() {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final refNotifier = ref.read(collateralRequestProvider.notifier);
    refNotifier.resetAddCollateralsValues();
    refNotifier.materialListApiFunction(context, '');
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final refNotifier = ref.read(collateralRequestProvider.notifier);
    final refState = ref.watch(collateralRequestProvider);
    return Scaffold(
      appBar: customAppBar(title: "Marketing Collaterals"),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 14, left: 17, right: 17, bottom: 20),
        child: Form(
          key: refNotifier.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           LabelTextTextfield(title: "Material", isRequiredStar: false),
              //           const SizedBox(height: 15,),
              //           AppTextfield(
              //             fillColor:false,suffixWidget: Icon(Icons.expand_more),
              //           )
              //         ],
              //       ),
              //     ),
              //     const SizedBox(width: 15,),
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           LabelTextTextfield(title: "Quantity", isRequiredStar: false),
              //           const SizedBox(height: 15,),
              //           AppTextfield(
              //             fillColor:false,
              //           )
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
          
              LabelTextTextfield(title: "Material", isRequiredStar: false),
              const SizedBox(
                height: 15,
              ),
              CustomSearchDropDown(
                searchController: searchController,
                items: refNotifier.materialDropdownItems(
                    (refState.materialItemsModel?.data ?? [])),
                selectedValues: refNotifier.selectedValues,
                onChanged: (val) {
                  refNotifier.onChangedMaterial(val);
                  setState(() {});
                },
                validator: (val) {
                  if ((val ?? '').isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 14,
              ),
              AppText(
                title: "Added Items",
                color: AppColors.mossGreyColor,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 10,
              ),
              addedItemWidget(refNotifier),
              const SizedBox(
                height: 19,
              ),
              LabelTextTextfield(title: "Remarks", isRequiredStar: false),
              const SizedBox(
                height: 15,
              ),
              AppTextfield(
                fillColor: false,
                maxLines: 3,
                controller: refNotifier.remarksController,
                validator: (val) {
                  if ((val ?? '').isEmpty) {
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

  addedItemWidget(CollateralsRequestNotifier refNotifier) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: AppColors.edColor),
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
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.edColor)),
                    child: AppText(
                      title:
                          (model.quantity) > 0 ? model.quantity.toString() : '',
                      fontsize: 12,
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
                        setState(() {
                          model.isSelected = false;
                          model.quantity = 0;
                          refNotifier.selectedItem.removeAt(index);
                        });
                      },
                      child: SvgPicture.asset(AppAssetPaths.deleteIcon))
                ],
              );
            }));
  }
}
