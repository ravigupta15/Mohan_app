import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_logo.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/features/auth/reset_password/riverpod/reset_password_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/utils/app_validation.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String resetPasswordKey;
  const ResetPasswordScreen({required this.resetPasswordKey});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> with AppValidation {


    @override
  void initState() {
    super.initState();
    Future.microtask((){
      ref.read(resetPasswordProvider.notifier).resetValues();
    });
  }
  @override
  Widget build(BuildContext context) {
     final resetPasswordState = ref.watch(resetPasswordProvider);
    final resetPasswordNotifier = ref.read(resetPasswordProvider.notifier);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
           padding: const EdgeInsets.only(top: 40,left: 19,right: 19),
          child: Form(
            key: resetPasswordNotifier.formKey,
            child: Column(
            children: [
                 appLogoWidget(),
              const SizedBox(height: 40,),
              AppText(title: "Reset Password",fontsize: 22,fontFamily: AppFontfamily.poppinsSemibold,),
              const SizedBox(height: 34,),
              AppTextfield(
                hintText: "Enter your password",
                isObscureText: resetPasswordState.isVisible,
                controller: resetPasswordNotifier.passwordController,
                 prefixWidget: SizedBox(
                      width: 40,
                      child: SvgPicture.asset(AppAssetPaths.keyIcon),
                    ),
                    validator: (val){
                     return newPasswordValidation(val, resetPasswordNotifier.confirmPasswordController.text);
                    },
                    suffixWidget: GestureDetector(
                    onTap: (){
                      resetPasswordNotifier.changeVisible(!resetPasswordState.isVisible);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(!resetPasswordState.isVisible?
                          Icons.visibility_off_outlined:
                          Icons.visibility_outlined,),
                    ),
                  ),
                    ),
              const SizedBox(height: 18,),
              AppTextfield(
                hintText: "Confirm password",
                isObscureText: resetPasswordState.isConfirmVisible,
                controller: resetPasswordNotifier.confirmPasswordController,
              prefixWidget: SizedBox(
                      width: 40,
                      child: SvgPicture.asset(AppAssetPaths.keyIcon),
                    ),
              suffixWidget: GestureDetector(
                    onTap: (){
                      resetPasswordNotifier.changeConfirmPasswordVisible(!resetPasswordState.isConfirmVisible);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(!resetPasswordState.isConfirmVisible?
                          Icons.visibility_off_outlined:
                          Icons.visibility_outlined,),
                    ),
                  ),
                  validator: (val){
                   return confirmPasswordValidation(val, resetPasswordNotifier.passwordController.text);
                  },
              ),
            ],
                    ),
          ),
        )),
         bottomNavigationBar: Padding(padding: EdgeInsets.only(left: 19,right: 19,bottom: 30),
        child: AppButton(title: "Change",height: 50,
        color: AppColors.arcticBreeze,
        isLoading: resetPasswordState.isLoading,
        onPressed: (){
          resetPasswordNotifier.checkValidation(widget.resetPasswordKey);
        },),
        ),
    );
  }
}