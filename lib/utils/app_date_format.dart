import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateFormat {

static String datePickerView(DateTime selectedDay){
  return "${selectedDay.year}-${selectedDay.month>9?selectedDay.month: "0${selectedDay.month}"}-${selectedDay.day >9? selectedDay.day : "0${selectedDay.day}"}";
}

static String formatTime(TimeOfDay time) {
    final hour = time.hour < 10 ? '0${time.hour}' : '${time.hour}';
    final minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
    return '$hour:$minute'; // Returns time in HH:mm format
  }

static String timeWithMilisecond(String dateString){
  if(dateString.isNotEmpty){
     DateTime dateTime = DateTime.parse(dateString);
      String timeFormatted = DateFormat('h:mm:ss a').format(dateTime);
  return timeFormatted;
  }
  return '';
}

static String formatDate(String dateString) {
if(dateString.isNotEmpty){
    DateTime dateTime = DateTime.parse(dateString);
    String dateFormatted = DateFormat('d MMM, yyyy').format(dateTime);
    return dateFormatted;
}
return '';
  }

  static String formatDateYYMMDD(String dateString) {
if(dateString.isNotEmpty){
    DateTime dateTime = DateTime.parse(dateString);
    String dateFormatted = DateFormat('yyyy MM, d').format(dateTime);
    return dateFormatted;
}
return '';
  }


static String convertTo12HourFormat(String timeIn24Hour) {
  if(timeIn24Hour.isEmpty){
    return '';
  }
  List<String> timeParts = timeIn24Hour.split(':');
  
  int hour = int.parse(timeParts[0]);  
  int minute = int.parse(timeParts[1]);
  String second = timeParts[2]; 
  
  String period = hour >= 12 ? 'PM' : 'AM';

  if (hour > 12) {
    hour -= 12;
  } else if (hour == 0) {
    hour = 12; // 12 AM case
  }

  return '$hour:${minute.toString().padLeft(2, '0')} $period';
}
 static String formatDateToRelative(String dateString) {
   if(dateString.isNotEmpty){
     DateTime dateTime = DateTime.parse(dateString);

    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    String timeFormatted = DateFormat.jm().format(dateTime);

    if (difference.inDays == 0) {
      return '$timeFormatted, today';
    } else if (difference.inDays == 1) {
      return '$timeFormatted, yesterday';
    } else if (difference.inDays < 30) {
      return '$timeFormatted, ${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      int monthsAgo = (difference.inDays / 30).floor();
      return '$timeFormatted, $monthsAgo month${monthsAgo > 1 ? 's' : ''} ago';
    } else {
      int yearsAgo = (difference.inDays / 365).floor();
      return '$timeFormatted, $yearsAgo year${yearsAgo > 1 ? 's' : ''} ago';
    }
   }
   return '';
  }

static String formatDuration(int seconds) {
  int hours = (seconds / 3600).floor(); // Get hours
  int minutes = ((seconds % 3600) / 60).floor(); // Get minutes
  int remainingSeconds = seconds % 60; // Get remaining seconds

  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}

}