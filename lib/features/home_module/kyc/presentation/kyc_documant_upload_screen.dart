import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/kyc_page_number.dart';
import 'package:mohan_impex/core/widget/app_text_field/label_text_textfield.dart';
import 'package:mohan_impex/features/home_module/kyc/widgets/documents_widget.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';

import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/app_text.dart';
import '../../../../res/app_fontfamily.dart';
import 'kyc_review_screen.dart';

class KycDocumentUploadScreen extends StatefulWidget {
  const KycDocumentUploadScreen({super.key});

  @override
  State<KycDocumentUploadScreen> createState() =>
      _KycDocumentUploadScreenState();
}

class _KycDocumentUploadScreenState extends State<KycDocumentUploadScreen> {
  int tabBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'KYC'),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 19, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDividerWidget(
              number: '2',
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: AppText(
                title: "Document Upload",
                  fontFamily: AppFontfamily.poppinsSemibold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            LabelTextTextfieldDocument(
                title: 'Customer Declaration (CD)', isRequiredStar: true),
            const SizedBox(
              height: 5,
            ),
            AppText(
              title:
                  "Upload or capture a clear photo of your signed declaration form",
              color: AppColors.mossGreyColor,
              fontsize: 11,
            ),
            const SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: DocumantWidget(
                  image: AppAssetPaths.cameraIcon,
                  title: "Camera",
                  subtitle: "Take a photo",
                )),
                SizedBox(width: 25,),
                Expanded(
                    child: DocumantWidget(
                  image: AppAssetPaths.uploadIcon,
                  title: "Upload",
                  subtitle: "PDF, JPG, PNG",
                )),
              ],
            ),

            const SizedBox(
              height: 24,
            ),
            LabelTextTextfieldDocument(
                title: 'Customer License (CL)', isRequiredStar: true),
            const SizedBox(
              height: 5,
            ),
            AppText(
              title:
              "Upload or capture a clear photo of your valid license",
              color: AppColors.mossGreyColor,
              fontsize: 12,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: DocumantWidget(
                      image: AppAssetPaths.cameraIcon,
                      title: "Camera",
                      subtitle: "Take a photo",
                    )),
                SizedBox(width: 25,),
                Expanded(
                    child: DocumantWidget(
                      image: AppAssetPaths.uploadIcon,
                      title: "Upload",
                  subtitle: "PDF, JPG, PNG",
                    )),
              ],
            ),
           Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: AppButton(
                    width: 95,
                    height: 40,
                    color: AppColors.black,
                    onPressed: () {
                      //AppRouter.pushReplacementNavigation(const KycScreen());
                    },
                    title: "Back",
                  ),
                ),
                Spacer(),
                Flexible(
                    child: AppButton(
                        width: 95,
                        color: AppColors.black,
                        onPressed: () {
                          AppRouter.pushCupertinoNavigation(const KycReviewScreen());
                        },
                        height: 40,
                        title: "Next")),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),

    );
  }
}
