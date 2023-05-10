import 'package:flutter/material.dart';
import 'package:flutterproject/FormPage.dart';
import 'package:flutterproject/InfoPage.dart';
import 'package:flutterproject/welcome.dart';
import 'package:flutterproject/table.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../preinscription.dart';



class Consts {
  static final navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: Colors.teal,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.calendar_today_outlined),
      title: const Text("Reservation"),
      selectedColor: Colors.pink,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.account_circle),
      title: const Text("Profile"),
      selectedColor: Colors.purple,
    ),
  ];
  static void onItemTapped(BuildContext context,int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  welcome(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  InfoPage(),
          ),
        );
        break;
      case 2:

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  FormApp(),
          ),
        );
        break;
        case 3:

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  preinscription(),
          ),
        );
        break;
        case 4:

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  Tables(),
          ),
        );
        break;
        case 4:

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  Tables(),
          ),
        );
        break;
    }
  }
}