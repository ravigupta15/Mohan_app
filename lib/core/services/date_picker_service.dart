import 'package:flutter/material.dart';

class DatePickerService {


 static Future datePicker(BuildContext context, { DateTime? selectedDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null){
    return picked;
    }
  }

}