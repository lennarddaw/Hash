import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../assets/colors.dart';
import '../services/text_to_icon.dart';

class _BarChart extends StatelessWidget {
  final List<String> topPackages;
  late final List<Widget> icons;

  _BarChart({required this.topPackages, super.key}) {
    icons = topPackages
        .take(7)
        .map((pkg) => iconForPackage(pkg))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 60,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              '${rod.toY.round()}',
                TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w300,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final axisSide = meta.axisSide;
    int index = value.toInt();
    if (index < 0 || index >= icons.length) return const SizedBox.shrink();

    return SideTitleWidget(
      axisSide: axisSide,
      space: 4,
      child: SizedBox(width: 24, height: 30, child: icons[index]),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 36,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.grey,
          AppColors.grey,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => List.generate(topPackages.length, (index) {
        final usageDuration = _getMockUsage(topPackages[index]);
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: usageDuration.inMinutes.toDouble(),
              gradient: _barsGradient,
              width: 20,
              borderRadius: BorderRadius.circular(4),
            )
          ],
          showingTooltipIndicators: [0],
        );
      });

  // Mock-Methode, hier kannst du später dynamische Werte einsetzen
  Duration _getMockUsage(String packageName) {
    const defaultDuration = Duration(minutes: 10);
    final mockMap = {
      "com.instagram.android": Duration(minutes: 45),
      "com.whatsapp": Duration(minutes: 30),
      "com.snapchat.android": Duration(minutes: 25),
    };
    return mockMap[packageName] ?? defaultDuration;
  }
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<BarChartSample3> createState() => _BarChartSample3State();
}

class _BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: _BarChart(
          topPackages: const [
            "com.instagram.android",
            "com.whatsapp",
            "com.snapchat.android",
            "com.telegram.android",
            "com.tiktok.android",
            "com.spotify.music",
            "com.youtube.android",
          ],
        ),
      ),
    );
  }
}
