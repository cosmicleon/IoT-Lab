import 'package:flutter/material.dart';
import 'package:iot_lab/common/appbar_common.dart';
import 'package:iot_lab/farm/farm_dashboard.dart';
import 'package:iot_lab/farm_env/farm_env.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCommon(
            topTitle: 'HOME',
            bgColor: const Color.fromARGB(255, 255, 201, 39),
            navBackColor: const Color.fromARGB(255, 255, 201, 39),
            navBack: false),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                child: const Text("Farm Watering and Fertilizing"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FarmDashboard()),
                  );
                },
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                child: const Text("Farm Censor Data"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FarmEnvironment()),
                  );
                },
              )
            ])
          ],
        ));
  }
}
