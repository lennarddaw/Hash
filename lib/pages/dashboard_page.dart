import 'package:flutter/material.dart';
import 'package:hash/util/usage_chart_box.dart';

import '../assets/colors.dart';
import '../util/content_category.dart';
import '../util/daily_usage.dart';
import '../util/total_usage_box.dart';
import 'home_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => const HomePage(),
                transitionsBuilder: (_, animation, __, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end).chain(
                    CurveTween(curve: Curves.easeOut),
                  );
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          }
        },
        child: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TotalUsageBox(totalUsage: Duration(minutes: 135)),
                SizedBox(height: 5),
                DailyUsageChart(hourlyUsage: {
                  0: 5,
                  1: 3,
                  2: 0,
                  3: 0,
                  4: 2,
                  5: 7,
                }),
                SizedBox(height: 5),
                ContentCategoryPieChart(categoryUsage: {
                  "Social": 120,
                  "Productivity": 80,
                  "Entertainment": 60,
                }),
                SizedBox(height: 5),
                SizedBox(height: 300, child: BarChartSample3()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
