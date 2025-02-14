import 'package:flutter/services.dart';
import 'package:mohan_impex/utils/validation_helper.dart';

mixin class AppValidation {
  removeLeadingWhiteSpace() {
    return FilteringTextInputFormatter.deny(
      RegExp(r'^\s+'),
    );
  }

  emojiRestrict() {
    return FilteringTextInputFormatter.deny(
        RegExp(ValidationHelper.regexToRemoveEmoji));
  }

  String? emailValidator(val) {
    if (val.isEmpty) {
      return "Please enter your email id";
    }
    RegExp regExp = RegExp(ValidationHelper.emailPattern);
    if (!regExp.hasMatch(val)) {
      return "Please enter valid email ID";
    }
    return null;
  }

  String? passwordValidation(val) {
    if (val.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }

  String? newPasswordValidation(val, confirmPassword) {
    if (val.isEmpty) {
      return "Enter new password";
    } else if (val != confirmPassword) {
      return 'Password does not match';
    }
    return null;
  }

  String? confirmPasswordValidation(val, password) {
    if (val.isEmpty) {
      return "Enter confirm password";
    } else if (val != password) {
      return 'Password does not match';
    }
    return null;
  }
}
