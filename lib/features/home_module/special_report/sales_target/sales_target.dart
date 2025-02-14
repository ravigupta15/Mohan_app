

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../../../../res/app_colors.dart';

class SalesTarget extends StatelessWidget {
  const SalesTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Sales Target'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            DashboardCard(
              amount: '₹3,51,000',
              percentage: '+12%',
              subtitle: 'from last period',
            ),
            const SizedBox(height: 20),
        Container(
          // height: 200,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 10,color: AppColors.black.withValues(alpha: .2)
              )
            ]
          ),
          child: Column(
            children: [
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 25000,
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(
                                toY: 22000,
                                color: AppColors.greenColor,
                                width: 50,
                                borderRadius: BorderRadius.circular(4)),
                          ]),
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(
                                toY: 20000,
                                color: AppColors.chart,
                                width: 50,
                                borderRadius: BorderRadius.circular(4)),
                          ]),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 50,
                                getTitlesWidget: (value, meta) {
                                  if (value % 5000 == 0) {
                                    return Text("${value.toInt()} ",
                                        style: TextStyle(fontSize: 14));
                                  }
                                  return Container();
                                }),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                          border: Border.all(
                              color: Colors.black, width: 2), // Outer border
                        ),
                        gridData: FlGridData(
                          show: true, // Show grid lines
                          drawHorizontalLine:
                              true, // Draw horizontal grid lines
                          horizontalInterval:
                              5000, // Grid interval (for horizontal lines)
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: AppColors.lightEBColor, // Solid grid lines
                              strokeWidth: 1, // Width of the grid lines
                            );
                          },
                          drawVerticalLine:
                              true, // Show vertical grid lines (optional)
                          verticalInterval:
                              1, // Adjust for vertical lines if needed
                          getDrawingVerticalLine: (value) {
                            return FlLine(
                              color: AppColors.lightEBColor,
                              strokeWidth: 1,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                 SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Legend(color: AppColors.greenColor, text: 'Target'),
            SizedBox(width: 20),
            Legend(color: AppColors.chart, text: 'Achievement'),
          ],
        ),
            ],
          ),
        )
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String amount;
  final String percentage;
  final String subtitle;

  const DashboardCard({
    super.key,
    required this.amount,
    required this.percentage,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            amount,
            style: const TextStyle(
              fontFamily: AppFontfamily.poppinsMedium,
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: AppColors.greenColor,
            ),
          ),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(
              text: percentage,
              style: const TextStyle(
                fontFamily: AppFontfamily.poppinsRegular,
                fontSize: 16,

                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: ' $subtitle',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: AppFontfamily.poppinsLight,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Legend extends StatelessWidget {
  final Color color;
  final String text;

  Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 5),
        Text(text, style: TextStyle(

            fontSize: 12)),
      ],
    );
  }
}