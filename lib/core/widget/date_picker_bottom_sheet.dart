
  import 'package:flutter/material.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/res/custom_table_date.dart';
import 'package:mohan_impex/core/widget/dotted_divider.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

import 'app_text.dart';

// ignore: must_be_immutable
class ViewDatePickerWidget extends StatelessWidget {
  DateTime selectedDay;
  DateTime focusedDay;
  Function(DateTime, DateTime)? onDaySelected;
  Function()?applyTap;
  DateTime? firstDay;
   ViewDatePickerWidget({required  this.selectedDay,required this.focusedDay, 
 this.onDaySelected, this.applyTap, this.firstDay});

  @override
  Widget build(BuildContext context) {
    return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        AppText(title: "Select Date",fontFamily:AppFontfamily.poppinsSemibold,),
                        const Spacer(),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.e2Color
                            ),
                            alignment: Alignment.center,
                            child: Icon(Icons.close,size: 19,),
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15),
                    child: dotteDivierWidget(dividerColor: AppColors.edColor),
                    ),
                    customTableWidget(
                        focusedDay: focusedDay,
                        selectedDay: selectedDay,
                        onDaySelected: onDaySelected,
                        firstDay: firstDay
                      ),
                      const SizedBox(height: 10,),
                      AppTextButton(title: "Apply",
                      height: 40,width: 100,color: AppColors.arcticBreeze,
                      onTap:applyTap
                      )
                  ],
                );
  }
}
