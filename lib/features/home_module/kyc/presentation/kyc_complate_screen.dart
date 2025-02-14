import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';
import '../../../../core/widget/app_text.dart';
import '../../../../res/app_fontfamily.dart';
import 'kyc_screen.dart';

class kycComplate extends StatefulWidget {
  const kycComplate({super.key});

  @override
  State<kycComplate> createState() => _kycComplateState();
}

class _kycComplateState extends State<kycComplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'KYC'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            color: Colors.white,
            elevation: 1, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners for card
              side: BorderSide(
                  color: AppColors.cardBorder, width: 1), // Card border color and width
            ),
            child: Padding(
              padding: EdgeInsets.all(20),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssetPaths.successIcon,width: 108,height: 108,),
                  SizedBox(height: 10), // Space between the image and text
                  AppText(title: "KYC #12345",fontsize: 25,fontFamily: AppFontfamily.poppinsBold,),
                  SizedBox(height: 5),
                  AppText(title: "You have successfully created Ticket ",color: AppColors.cardText,
                    textAlign: TextAlign.center,
                    fontsize: 15,fontFamily: AppFontfamily.poppinsMedium,),
                  SizedBox(height: 15), // Space between message and button
                  // Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(34, (index) {
                      return Container(
                        width: 7,
                        // Width of each dash
                        height: 2,
                        // Line thickness
                        color: index % 2 == 0 ?AppColors.edColor : Colors.transparent,
                        // Alternating between black and transparent
                        margin: EdgeInsets.symmetric(
                            horizontal: 0), // Spacing between dashes
                      );
                    }),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: AppTextButton(title: "Track",color: Colors.black,height: 33,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // AppRouter.pushCupertinoNavigation(KycScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
