import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../assets/colors.dart';

class ContentCategoryPieChart extends StatelessWidget {
  final Map<String, double> categoryUsage; // z. B. {"Social": 45, "Productivity": 30, "Entertainment": 25}

  const ContentCategoryPieChart({super.key, required this.categoryUsage});

  @override
  Widget build(BuildContext context) {
    final total = categoryUsage.values.fold(0.0, (sum, value) => sum + value);
    final sections = categoryUsage.entries.map((entry) {
      final percentage = entry.value / total * 100;
      return PieChartSectionData(
        value: entry.value,
        title: "${percentage.toStringAsFixed(1)}%",
        radius: 60,
        color: _colorForCategory(entry.key),
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Nutzung nach Kategorie", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.3,
              child: PieChart(PieChartData(
                sections: sections,
                sectionsSpace: 2,
                centerSpaceRadius: 30,
              )),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: categoryUsage.keys.map((key) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(backgroundColor: _colorForCategory(key), radius: 5),
                    const SizedBox(width: 6),
                    Text(key, style: const TextStyle(fontSize: 12)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _colorForCategory(String key) {
    switch (key) {
      case "Social":
        return AppColors.cyan;
      case "Productivity":
        return AppColors.teal;
      case "Entertainment":
        return AppColors.grey;
      case "Utility":
        return Colors.blueGrey;
      default:
        return Colors.black45;
    }
  }
}
