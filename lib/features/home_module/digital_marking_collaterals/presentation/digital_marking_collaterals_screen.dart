import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/digital_marking_collaterals/riverpod/digital_marking_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DigitalMarkingCollateralsScreen extends ConsumerStatefulWidget {
  const DigitalMarkingCollateralsScreen({super.key});

  @override
  ConsumerState<DigitalMarkingCollateralsScreen> createState() => _DigitalMarkingCollateralsScreenState();
}

class _DigitalMarkingCollateralsScreenState extends ConsumerState<DigitalMarkingCollateralsScreen> {


@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(digitalMarkingProvider.notifier);
    refNotifier.digitalMarkingApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(digitalMarkingProvider);
    final refNotifier = ref.read(digitalMarkingProvider.notifier);
    return Scaffold(
    appBar: customAppBar(title: "Marketing Collaterals"),
     body: Padding(
      padding: const EdgeInsets.only(top: 14),
     child: Column(
      children: [
          Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppSearchBar(
                  hintText: "Search by product,campaigns",
                  onChanged: refNotifier.onChangedSearch,
                  suffixWidget: SvgPicture.asset(AppAssetPaths.searchIcon),
                ),
              ),
              Expanded(
                child:  refState.isLoading?
              shimmerList(): (refState.digitalMarkingModel?.data?.length??0)>0?
                 ListView.separated(
                  separatorBuilder: (ctx,sb){
                    return const SizedBox(height: 15,);
                  },
                itemCount: (refState.digitalMarkingModel?.data?.length??0),
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var model =refState.digitalMarkingModel?.data?[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          color: AppColors.black.withValues(alpha: .2),
                          blurRadius: 2
                        )
                      ]
                    ),
                    // padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15,top: 15,right: 15),
                          child: AppNetworkImage(imgUrl: model?.productAttachment??''),
                        ), 
                        const SizedBox(height: 12,),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: AppColors.edColor,
                        ),
                        const SizedBox(height: 7,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(model?.name??"",
                              style: TextStyle(
                                fontSize: 14,fontFamily: AppFontfamily.poppinsMedium,
                              ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.greenColor,width: .5
                                  ),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Text("Jpg"),
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(15),
                        child: buttonWidget(),
                        ),
                      ],
                    ),
                  );
              }): NoDataFound(title: "No marking collaterals found"))
      ],
     ),
     ),
           
    );
  }

  shimmerList(){
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        separatorBuilder: (ctx,sb){
          return const SizedBox(height: 15,);
        },
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context,index){
        return Container(
           decoration: BoxDecoration(
            color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          color: AppColors.black.withValues(alpha: .2),
                          blurRadius: 2
                        )
                      ]
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Image.asset('assets/dummy/slider.png'),
                        const SizedBox(height: 10,),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: AppColors.edColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("product"),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.greenColor,width: .5
                                ),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text("Jpg"),
                            )
                          ],
                        ),
                        const SizedBox(height: 15,),
                        buttonWidget()
                      ],
                    ),
        );
      }),
    );
  }

  buttonWidget({Function()?downloadTap,Function()?shareTap,}){
    return        Row(
                          children: [
                            Expanded(child: 
                            AppTextButton(title: "Download",color: AppColors.arcticBreeze, height: 40,width: double.infinity,onTap: downloadTap,)),
                            const SizedBox(width: 6,),
                            AppTextButton(title: "Share",color: AppColors.arcticBreeze,
                            width: 100,onTap: shareTap,height: 40,
                            )
                          ],
                        );
  }
}