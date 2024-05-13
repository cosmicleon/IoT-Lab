import 'package:flutter/material.dart';
// import 'package:flutter_chat_demo/constants/constants.dart';

class TitleSelection extends StatelessWidget {
  const TitleSelection(
      {super.key, this.name = "", this.type = 0, this.status = 0});

  @override
  final String name;
  //0 for lesson, 1 for quiz
  final int type;
  //0 for finish, 1 for in progress, 2 for not done yet
  final int status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            color: () {
              if (status == 0) {
                return const Color.fromARGB(255, 97, 205, 101);
              } else if (status == 1) {
                return const Color.fromARGB(255, 255, 201, 39);
              } else {
                return const Color.fromARGB(255, 100, 100, 100);
              }
            }(),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image(
                //   image: AssetImage(() {
                //     if (type == 0) {
                //       return 'images/lesson-title.png';
                //     } else {
                //       return 'images/quiz-title.png';
                //     }
                //   }()),
                //   width: 100,
                // ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                //   <Widget> () {
                //   if (status == 0) {
                //   return Text(
                //     name,
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 30,
                //     ),
                //   ),
                // } else if (status == 1) {
                //   return Text(
                //     name,
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 30,
                //     ),
                //   ),}}
              ])),
    );
  }
}
