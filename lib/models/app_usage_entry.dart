class AppUsageEntry {
  final String packageName;
  Duration duration;
  DateTime lastSeen;

  AppUsageEntry({
    required this.packageName,
    required this.duration,
    required this.lastSeen,
  });

  Map<String, dynamic> toJson() => {
        'packageName': packageName,
        'duration': duration.inSeconds,
        'lastSeen': lastSeen.toIso8601String(),
      };

  static AppUsageEntry fromJson(Map<String, dynamic> json) {
    return AppUsageEntry(
      packageName: json['packageName'],
      duration: Duration(seconds: json['duration']),
      lastSeen: DateTime.parse(json['lastSeen']),
    );
  }
}
