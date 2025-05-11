import 'package:flutter/services.dart';

class UsageStatsService {
  static const platform = MethodChannel('trackmint/usage_stats');

  static Future<String?> getTopApp() async {
    try {
      final String? result = await platform.invokeMethod('getTopApp');
      return result;
    } on PlatformException catch (e) {
      print("Failed to get app: '${e.message}'.");
      return null;
    }
  }
}
