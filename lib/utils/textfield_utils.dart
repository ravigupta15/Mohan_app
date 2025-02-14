import 'package:flutter/material.dart';

class TextfieldUtils{
  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}