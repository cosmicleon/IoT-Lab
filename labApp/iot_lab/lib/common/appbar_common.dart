import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  // const AppBarQuiz({super.key});
  AppBarCommon(
      {super.key,
      this.topTitle = "",
      this.bgColor = const Color.fromARGB(255, 75, 75, 75),
      this.navBackColor = const Color.fromARGB(255, 110, 110, 110),
      this.navBack = true})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;
  final String topTitle;
  final Color bgColor;
  final Color navBackColor;
  final bool navBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: bgColor,
        title: Text(
          topTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.5,
        leading: navBack
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: navBackColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      const Image(image: AssetImage('images/left-arrow.png')),
                ))
            : null,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              width: 37,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 97, 205, 101),
                borderRadius: BorderRadius.circular(10),
              ),
              // child: const Image(image: AssetImage('images/user.png')),
              child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://toquoc.mediacdn.vn/280518851207290880/2022/1/10/lee-do-hyun-081121-1-1641800779888-1641800780173402848607-1641819776359-16418197764341275356645.jpeg'),
                  radius: 20),
            ),
          ),
        ]);
  }
}
