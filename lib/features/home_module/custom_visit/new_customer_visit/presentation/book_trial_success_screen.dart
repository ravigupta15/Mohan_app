import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/riverpod/new_customer_visit_state.dart';
import 'package:mohan_impex/res/app_colors.dart';

import '../../../../../res/app_asset_paths.dart';

class BookTrialSuccessScreen extends ConsumerStatefulWidget {
  final String id;
  const BookTrialSuccessScreen({super.key, required this.id});

  @override
  ConsumerState<BookTrialSuccessScreen> createState() => _BookTrialSuccessScreenState();
}

class _BookTrialSuccessScreenState extends ConsumerState<BookTrialSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final refNotifier= ref.read(newCustomVisitProvider.notifier);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 40,bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: AppColors.black.withOpacity(.2),
                      blurRadius: 6
                    )
                  ]
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(AppAssetPaths.successIcon),
                    const SizedBox(height: 21,),
                    AppText(title: "You have successfully created ticket",
                    textAlign: TextAlign.center,fontsize: 15,
                    ),
                    const SizedBox(height: 26,),
                    AppTextButton(title: "Convert to Order",width: 165,height: 42,color: AppColors.arcticBreeze,
                    onTap: (){
                      refNotifier.convertToOrderApiFunction(context, widget.id);
                      //  Navigator.pop(context);
                      //  Navigator.pop(context);
                    }
                    ),
                    const SizedBox(height: 12,),
                    GestureDetector(
                      onTap: (){
                         Navigator.pop(context, true);
                       Navigator.pop(context,true);
                      //  Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.black)
                        ),
                        child: AppText(title: 'Home'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}