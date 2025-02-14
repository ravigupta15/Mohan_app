import 'package:flutter/material.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_fontfamily.dart';
import '../../../../core/widget/app_text.dart';

class CustomDividerWidget extends StatelessWidget {
  final String number;
  CustomDividerWidget({required this.number});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 2,
            color: AppColors.greenColor,
          ),
          SizedBox(width: 10),
          Container(
            height: 30, // Fixed height to make sure the circle is visible
            width: 30,  // Fixed width for a perfect circle
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.light92Color),
              borderRadius: BorderRadius.circular(50), // Makes it round
            ),
            child: Center( // Center the text inside the circle
              child: AppText(
                title: number,
                fontsize: 14,
                fontFamily: AppFontfamily.poppinsSemibold,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 80,
            height: 2,
            color: AppColors.greenColor,
          ),
        ],
      ),
    );
  }
}
