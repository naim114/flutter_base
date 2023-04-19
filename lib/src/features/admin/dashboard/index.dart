import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/features/admin/dashboard/user_growth_overall.dart';
import 'package:news_app/src/features/admin/dashboard/user_growth_year.dart';

import '../../../services/helpers.dart';
import './user_count_report.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColor.neutral2,
          ),
        ),
        title: Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListView(
          children: [
            userCountReport(
              totalUsers: 1000,
              totalUsersBanned: 13,
              totalUsersThisMonth: 53,
              totalUsersThisWeek: 84,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                'This Year User Growth',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            userGrowthYear(
              janData: 3,
              febData: 1,
              marData: 10,
              aprData: 5,
              mayData: 6,
              junData: 2,
              julData: 8,
              augData: 35,
              sepData: 15,
              octData: 14,
              novData: 7,
              disData: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                'Overall User Growth',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            userGrowthOverall(
              spots: const [
                FlSpot(2020, 14),
                FlSpot(2021, 100),
                FlSpot(2022, 5),
                FlSpot(2023, 19),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
