import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_logo.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/core/widget/app_text_field/app_textfield.dart';
import 'package:mohan_impex/features/auth/forgot_pasword/presentation/forget_password_screen.dart';
import 'package:mohan_impex/features/auth/sign-in/riverpod/sign_in_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/utils/app_validation.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen();

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> with AppValidation {
  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(signInProvider);
    final loginNotifier = ref.read(signInProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 19, right: 19),
        child: Align(
          alignment: Alignment.center,
          child: Form(
            key: loginNotifier.formKey,
            child: Column(
              children: [
                appLogoWidget(),
                const SizedBox(
                  height: 40,
                ),
                AppText(
                  title: "Login",
                  fontsize: 22,
                  fontFamily: AppFontfamily.poppinsSemibold,
                ),
                const SizedBox(
                  height: 31,
                ),
                AppTextfield(
                  hintText: "Email",
                  controller: loginNotifier.emailController,
                  prefixWidget: SizedBox(
                    width: 40,
                    child: SvgPicture.asset(AppAssetPaths.profileIcon),
                  ),
                  inputFormatters: [
                    emojiRestrict()
                  ],
                  validator: emailValidator
                ),
                const SizedBox(
                  height: 15,
                ),
                AppTextfield(
                  hintText: "Password",
                  controller: loginNotifier.passwordController,
                  inputFormatters: [
                   removeLeadingWhiteSpace(),
                   emojiRestrict()
                  ],
                  isObscureText: loginState.isVisible,
                  prefixWidget: SizedBox(
                    width: 40,
                    child: SvgPicture.asset(AppAssetPaths.keyIcon),
                  ),
                  suffixWidget: GestureDetector(
                    onTap: (){
                      loginNotifier.changeVisible(!loginState.isVisible);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(!loginState.isVisible?
                          Icons.visibility_off_outlined:
                          Icons.visibility_outlined,),
                    ),
                  ),
                  validator: passwordValidation
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        AppRouter.pushCupertinoNavigation(
                             ForgetPasswordScreen(email: loginNotifier.emailController.text,));
                      },
                      child: AppText(
                        title: "Forget Password",
                        decoration: TextDecoration.underline,
                        color: AppColors.lightTextColor,
                        fontsize: 13,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 19, right: 19, bottom: 30),
        child: AppButton(
          title: "Sign In",
          color: AppColors.arcticBreeze,
          height: 50,
          isLoading: loginState.isLoading,
          onPressed: () {
            loginNotifier.checkValidation();
          },
        ),
      ),
    );
  }
}
