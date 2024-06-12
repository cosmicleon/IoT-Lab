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
            // bgColor: const Color.fromARGB(255, 255, 201, 39),
            // navBackColor: const Color.fromARGB(255, 255, 201, 39),
            navBack: false),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: NetworkImage(
                  "https://img.freepik.com/free-vector/automatic-sprinkler-system-watering-fresh-green-lawn-realistic-illustration_1284-65427.jpg?size=626&ext=jpg&ga=GA1.1.1518270500.1717286400&semt=ais_user"),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'System connection',
                style: TextStyle(
                    // color: Color(0xff46793A),
                    // fontWeight: FontWeight.bold,
                    ),
              ),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   mixer++;
                    //   if (mixer > 4) {
                    //     mixer = 0;
                    //   }
                    // });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 138, 240, 94),
                        // color: () {
                        //   if (mixer < index) {
                        //     return Color.fromARGB(255, 94, 240, 228);
                        //   } else if (mixer == index) {
                        //     return Color.fromARGB(255, 138, 240, 94);
                        //   } else {
                        //     return Color.fromARGB(255, 240, 199, 94);
                        //   }
                        // }(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Connected',
                        style: TextStyle(
                          color: Color(0xff46793A),
                          fontWeight: FontWeight.bold,
                        ),
                      )))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Mixer ingredient setup',
                style: TextStyle(
                    // color: Color(0xff46793A),
                    // fontWeight: FontWeight.bold,
                    ),
              ),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   mixer++;
                    //   if (mixer > 4) {
                    //     mixer = 0;
                    //   }
                    // });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 138, 240, 94),
                        // color: () {
                        //   if (mixer < index) {
                        //     return Color.fromARGB(255, 94, 240, 228);
                        //   } else if (mixer == index) {
                        //     return Color.fromARGB(255, 138, 240, 94);
                        //   } else {
                        //     return Color.fromARGB(255, 240, 199, 94);
                        //   }
                        // }(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Ready',
                        style: TextStyle(
                          color: Color(0xff46793A),
                          fontWeight: FontWeight.bold,
                        ),
                      )))
            ]),
            const SizedBox(
              height: 70,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FarmDashboard()),
                  );
                },
                child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F05E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'START',
                      style: TextStyle(
                        color: Color(0xff46793A),
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
            const SizedBox(
              height: 10,
            ),
          ],
          // children: [
          //   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //     ElevatedButton(
          //       child: const Text("Farm Watering and Fertilizing"),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (_) => FarmDashboard()),
          //         );
          //       },
          //     ),
          //   ]),
          //   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //     ElevatedButton(
          //       child: const Text("Farm Censor Data"),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (_) => FarmEnvironment()),
          //         );
          //       },
          //     )
          //   ]
          //   )
          // ],
        ));
  }
}
