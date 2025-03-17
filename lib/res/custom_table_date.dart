import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:table_calendar/table_calendar.dart';

  Widget customTableWidget({
    required DateTime selectedDay,required DateTime focusedDay, Function(DateTime, DateTime)? onDaySelected,
     DateTime? firstDay
    }) {
      DateTime currentDay = DateTime.now();
    return TableCalendar(
      firstDay: firstDay ?? DateTime.now(),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: onDaySelected,
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: false,
          titleTextStyle:  TextStyle(
              fontSize: 15,
              color: AppColors.black,
              fontFamily: AppFontfamily.poppinsMedium),
          headerPadding: EdgeInsets.zero,
          decoration: const BoxDecoration(),
          headerMargin: EdgeInsets.only(
              // left: ScreenSize.screenWidth * .09,
              // right: ScreenSize.screenWidth * .09,
              bottom: 10)),
      calendarStyle: CalendarStyle(
        selectedDecoration:  BoxDecoration(
          color: AppColors.greenColor,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.white,
        ),
        todayDecoration: BoxDecoration(
          color: isSameDay(currentDay, selectedDay) ? AppColors.greenColor :
          AppColors.greenColor.withOpacity(.5),
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(
          color: Colors.white,
        ),
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        defaultTextStyle: const TextStyle(
          color: AppColors.black,
          fontFamily: AppFontfamily.poppinsMedium
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: 12,
          color: Color(0xffAAAAAA),
          // fontFamily: FontfamilyHelper.interSemiBold,
        ),
        // weekendStyle: TextStyle(
        //   fontSize: 12,
        //   color: AppColors.appTheme,
        //   fontFamily: FontfamilyHelper.interSemiBold,
        // ),
      ),
    );
  }

