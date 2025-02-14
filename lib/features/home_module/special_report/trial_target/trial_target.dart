import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../../../../res/app_colors.dart';

class TrialTarget extends StatelessWidget {
  const TrialTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Trial Target'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 9),
            DashboardCard(
              amount: '92%',
              percentage: '+5%',
              subtitle: 'from last period',
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                  )
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 200, child: LineChartWidget()),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LegendWidget(color: AppColors.greenColor, text: 'Target'),
                      SizedBox(width: 20),
                      LegendWidget(color: AppColors.chart, text: 'Achievement'),
                        
                    ],
                  ),
                        
                ],
              ),
            ),
            SizedBox(height: 20),

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


class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
         gridData: FlGridData(
      show: true,
      
      drawHorizontalLine: true, // Show horizontal grid lines
      drawVerticalLine: false,  // Hide vertical grid lines
    ),
        // gridData: FlGridData(show: true, drawHorizontalLine: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 60),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            )),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            )),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(-1, 5),
              const FlSpot(1, 10),
              const FlSpot(2, 15),
              const FlSpot(3, 7),
              const FlSpot(4, 17),
              const FlSpot(5, 22),
              const FlSpot(6, 12),
              const FlSpot(7, 12),
            ],
            isCurved: true,
            color:AppColors.chart,
            barWidth: 1.5,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: [
              const FlSpot(0, 10),
              const FlSpot(1, 5),
              const FlSpot(2, 10),
              const FlSpot(3, 15),
              const FlSpot(4, 15),
              const FlSpot(5, 20),
              const FlSpot(6, 25),
              const FlSpot(7, 25),
            ],
            isCurved: true,
            color: AppColors.greenColor,
            barWidth: 1.5,
            isStrokeCapRound: true,
            dashArray: [10, 5], // Makes the line dashed
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}

class LegendWidget extends StatelessWidget {
  final Color color;
  final String text;

  const LegendWidget({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 5),
        Text(text, style: TextStyle(

            fontSize: 12)),
      ],
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