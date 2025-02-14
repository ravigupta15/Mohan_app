import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_logo.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/features/auth/forgot_pasword/riverpod/fogot_password_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/utils/app_validation.dart';
import 'package:mohan_impex/utils/validation_helper.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  final String email;
  const ForgetPasswordScreen({required this.email});

  @override
  ConsumerState<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> with AppValidation {


@override
  void initState() {
    Future.microtask((){
      ref.read(forgotProvider.notifier).setInitalValues(email: widget.email);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     final forgotState = ref.watch(forgotProvider);
    final forgotNotifier = ref.read(forgotProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40,left: 19,right: 19),
          child: Form(
            key: forgotNotifier.formKey,
            child: Column(
              children: [
               appLogoWidget(),
               const SizedBox(height: 40,),
                AppText(title: "OTP Verification",fontsize: 22,fontFamily: AppFontfamily.poppinsSemibold,),
                const SizedBox(height: 5,),
                 AppText(title: "We will send you one-time password to you mobile number",fontsize: 13,
                 color: AppColors.light92Color,textAlign: TextAlign.center,),
                 const SizedBox(height: 20,),
                 AppTextfield(
                  hintText: "Enter email",
                  controller: forgotNotifier.emailController,
                 prefixWidget: SizedBox(
                      width: 40,
                      child: SvgPicture.asset(AppAssetPaths.callIcon),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                          RegExp(ValidationHelper.regexToRemoveEmoji)),
                    ],
                    validator: emailValidator
                    ),
              ],
            ),
          ),
        )),
        bottomNavigationBar: Padding(padding: EdgeInsets.only(left: 19,right: 19,bottom: 30),
        child: AppButton(title: "Get OTP",
        height: 50,
        color: AppColors.arcticBreeze,
        isLoading: forgotState.isLoading,
         onPressed: (){
          forgotNotifier.checkValidation();
        },),
        ),
    );
  }
}