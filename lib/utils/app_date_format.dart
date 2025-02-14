import 'package:intl/intl.dart';

class AppDateFormat {

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

}