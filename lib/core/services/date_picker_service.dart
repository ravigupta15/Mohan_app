import 'package:flutter/material.dart';

class DatePickerService {


 static Future datePicker(BuildContext context, { DateTime? selectedDate, DateTime? firstDate}) async {
      // Ensure that initialDate is not before firstDate
    DateTime initialDate = selectedDate ?? DateTime.now();
    if (firstDate != null && initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(1994),
      lastDate: DateTime(2101),
    );
    if (picked != null){
    return picked;
    }
  }

}