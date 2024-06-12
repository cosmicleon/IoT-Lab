import 'package:flutter/material.dart';
import 'package:iot_lab/farm/farm_dashboard.dart';
// import 'package:iot_lab/farm_env/farm_env.dart';
import 'package:iot_lab/homepage.dart';

void main() {
  runApp(const IoTApp());
}

class IoTApp extends StatelessWidget {
  const IoTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'BeVietnamPro'),
      title: "IoTApp",
      home: const HomePage(),
      // home: const FarmDashboard(),
    );
  }
}
