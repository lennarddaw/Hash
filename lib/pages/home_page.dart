import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hash/assets/colors.dart';
import 'package:hash/pages/dashboard_page.dart';
import 'package:hash/pages/token_page.dart';

import '../services/usage_stats_service.dart';
import '../util/smart_device_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  Timer? _trackingTimer;
  Map<String, Duration> usageStats = {};
  String? currentApp;
  DateTime? appStartTime;

  List mySmartDevices = [
    ["Track Eyes", "lib/icons/view.png", true],
    ["View Screen", "lib/icons/monitor-up.png", false],
    ["Web Search", "lib/icons/globe-lock.png", false],
    ["See GPS", "lib/icons/locate-fixed.png", false],
  ];

  @override
  void initState() {
    super.initState();
    checkForegroundApp();
    startTracking();
  }

  void startTracking() {
    _trackingTimer?.cancel();
    _trackingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkForegroundApp();
    });
  }

  void checkForegroundApp() async {
    final newApp = await UsageStatsService.getTopApp();
    if (newApp != null && newApp != currentApp) {
      final now = DateTime.now();
      if (currentApp != null && appStartTime != null) {
        final duration = now.difference(appStartTime!);
        usageStats.update(currentApp!, (d) => d + duration, ifAbsent: () => duration);
      }
      currentApp = newApp;
      appStartTime = now;
      print(usageStats);
    }
  }

  void openUsageAccessSettings() {
    const intent = AndroidIntent(
      action: 'android.settings.USAGE_ACCESS_SETTINGS',
    );
    intent.launch();
  }

  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }

  @override
  void dispose() {
    _trackingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
          Navigator.of(context).push(
  PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => const Dashboard(),
    transitionsBuilder: (_, animation, __, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOut));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  ),
);} else if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
  Navigator.of(context).push(
  PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => const TokenPage(),
    transitionsBuilder: (_, animation, __, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOut));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  ),
);
        }
      },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'lib/icons/menu.png',
                      height: 45,
                      color: AppColors.cyan,
                    ),
                    GestureDetector(
                      onTap: () {
                        openUsageAccessSettings();
                      },
                      child: Icon(
                        Icons.person,
                        size: 45,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Home,",
                      style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                    ),
                    Text(
                      'Lennard',
                      style: GoogleFonts.bebasNeue(fontSize: 72),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 204, 204, 204),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  "Active Overview",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return SmartDeviceBox(
                      smartDeviceName: mySmartDevices[index][0],
                      iconPath: mySmartDevices[index][1],
                      powerOn: mySmartDevices[index][2],
                      onChanged: (value) => powerSwitchChanged(value, index),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
