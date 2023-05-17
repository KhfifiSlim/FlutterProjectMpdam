import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterproject/Views/InfoPage.dart';
import 'package:flutterproject/Views/welcome.dart';
import '../Config/size_config.dart';

class PageSplashScreen extends StatefulWidget {
  const PageSplashScreen({Key? key}) : super(key: key);

  @override
  State<PageSplashScreen> createState() => _PageSplashScreenState();
}

class _PageSplashScreenState extends State<PageSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
  /*  _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: 2 * 3.14,
    ).animate(_controller);*/
    Timer(
      const Duration(seconds: 5),
          () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>   welcome(),
            ),
          );

      },
    );

  }

  @override
Widget build(BuildContext context) {
  SizeConfig().init(context);
    // ignore: avoid_unnecessary_containers
  return Container(
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
      image: DecorationImage(
        image: AssetImage('assets/secreen.gif'),
        fit: BoxFit.contain,
      ),
    ),
    height: 600,
 // set the opacity to 0.5
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight *0.5),
         
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
        ],
      ),
    
  );
}
}
