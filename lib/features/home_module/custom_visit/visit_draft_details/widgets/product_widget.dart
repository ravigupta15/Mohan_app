import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/features/home_module/seles_order/model/view_sales_order_model.dart';
import 'package:mohan_impex/features/home_module/seles_order/riverpod/sales_order_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

class ProductWidget extends StatelessWidget {
  final SalesOrderState refState;
  const ProductWidget({super.key, required this.refState});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.itemsBG,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffE2E2E2)),
      ),
      child: ListView.separated(
          separatorBuilder: (ctx, index) {
            return const SizedBox(
              height: 15,
            );
          },
          shrinkWrap: true,
          itemCount:
              (refState.viewSalesOrderModel?.data?[0].itemsTemplate ?? [])
                  .length,
          itemBuilder: (ctx, index) {
            var model =
                refState.viewSalesOrderModel?.data?[0].itemsTemplate?[index];
            return _prodcutsWidget(
                model?.itemTemplate ?? '', model?.items ?? []);
          }),
    );
  }

  Widget _prodcutsWidget(String title, List<Items> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.oliveGray.withValues(alpha: .3)),
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title: title,
            fontFamily: AppFontfamily.poppinsMedium,
          ),
          Padding(
            padding: EdgeInsets.only(top: 9, bottom: 4),
            child: dotteDivierWidget(
                dividerColor: AppColors.edColor, thickness: 1.6),
          ),
          ListView.separated(
            padding: EdgeInsets.only(top: 15),
              separatorBuilder: (ctx, sb) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                var model = items[index];
                return Row(
                  children: [
                    Expanded(
                        child: AppText(
                      title: model.itemName,
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AppText(
                        title: model.qty.toString(),
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }
}
