import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

Widget dotteDivierWidget({required Color dividerColor, double thickness = 1.0}){
  return DottedLine(
              direction: Axis.horizontal, // You can also set Axis.vertical
              lineLength: double.infinity,
              lineThickness:thickness,
              dashLength: 6.0,
              dashColor: dividerColor,
              dashRadius: 0.0,
              dashGapLength: 4.0, // Spacing between dots
              dashGapColor: Colors.transparent, // Can be set to transparent
            );

}