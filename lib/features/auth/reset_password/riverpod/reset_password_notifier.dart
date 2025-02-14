// Define a StateNotifier to manage the state
import 'package:flutter/material.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/auth/reset_password/riverpod/reset_password_state.dart';
import 'package:mohan_impex/features/success_screen.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../api_config/api_service.dart';

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  ResetPasswordNotifier()
      : super(ResetPasswordState(
            isLoading: false, isConfirmVisible: true, isVisible: true));

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();


resetValues(){
passwordController.clear();
confirmPasswordController.clear();
}

  final formKey = GlobalKey<FormState>();

  updateLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  checkValidation(String pwdId) {
    if (formKey.currentState!.validate()) {
      callApiFunction(pwdId);
    }
  }

  void changeVisible(bool value) {
    state = state.copyWith(isVisible: value);
  }

  void changeConfirmPasswordVisible(bool value) {
    state = state.copyWith(isConfirmVisible: value);
  }

  callApiFunction(String pwdId) async {
    TextfieldUtils.hideKeyboard();
    final data = {"new_password": confirmPasswordController.text, "key": pwdId};
    updateLoading(true);
    final response = await ApiService().makeRequest(
        apiUrl: ApiUrls.updateResetPasswordUrl,
        method: ApiMethod.post.name,
        data: data);
    updateLoading(false);
    if (response != null) {
      AppRouter.pushCupertinoNavigation(SuccessScreen(
        title: '',
        des: "Your password has been reset successfully",
        btnTitle: "Login",
        onTap: () {
          // AppRouter.pushReplacementNavigation(const SignInScreen());
          Navigator.pop(navigatorKey.currentContext!);
          Navigator.pop(navigatorKey.currentContext!);
          Navigator.pop(navigatorKey.currentContext!);
          Navigator.pop(navigatorKey.currentContext!);
        },
      ));
    }
  }
}
