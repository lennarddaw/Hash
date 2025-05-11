import 'package:flutter/material.dart';
import '../assets/colors.dart';

class TotalUsageBox extends StatelessWidget {
  final Duration totalUsage;

  const TotalUsageBox({super.key, required this.totalUsage});

  @override
  Widget build(BuildContext context) {
    final hours = totalUsage.inHours;
    final minutes = totalUsage.inMinutes % 60;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Usage Today",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              "${hours}h ${minutes}min",
              style:  TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
