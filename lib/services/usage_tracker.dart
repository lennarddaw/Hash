import 'dart:async';
import '../models/app_usage_entry.dart';
import 'usage_stats_service.dart';

class UsageTracker {
  final Map<String, AppUsageEntry> _usageMap = {};
  String? _lastApp;
  DateTime _lastSwitch = DateTime.now();
  Timer? _timer;

  void startTracking() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _track());
  }

  void stopTracking() {
    _timer?.cancel();
  }

  Future<void> _track() async {
    final currentApp = await UsageStatsService.getTopApp();
    final now = DateTime.now();

    if (currentApp == null) return;

    if (_lastApp != null && _lastApp != currentApp) {
      final duration = now.difference(_lastSwitch);
      _addUsage(_lastApp!, duration, now);
      _lastSwitch = now;
    }

    _lastApp = currentApp;
  }

  void _addUsage(String app, Duration duration, DateTime lastSeen) {
    if (_usageMap.containsKey(app)) {
      _usageMap[app]!.duration += duration;
      _usageMap[app]!.lastSeen = lastSeen;
    } else {
      _usageMap[app] = AppUsageEntry(
        packageName: app,
        duration: duration,
        lastSeen: lastSeen,
      );
    }

    print("Update: $app → ${_usageMap[app]!.duration.inSeconds}s");
  }

  List<AppUsageEntry> get usageStats => _usageMap.values.toList();
}
