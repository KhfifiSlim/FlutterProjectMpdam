import 'package:flutter/material.dart';
import 'package:flutterproject/Views/FormPage.dart';
import 'package:flutterproject/Views/InfoPage.dart';
import 'package:flutterproject/Views/welcome.dart';
import 'package:flutterproject/Views/table.dart';
import 'package:flutterproject/Views/Absences.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Views/preinscription.dart';



class Consts {
   static final navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: Colors.purple,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.info),
      title: const Text("Info"),
      selectedColor: Colors.pink,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.contact_mail),
      title: const Text("Contact Us"),
      selectedColor: Colors.orange,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.format_list_bulleted),
      title: const Text("Préinscription"),
      selectedColor: Colors.teal,
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
        case 6:

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  Absences(),
          ),
        );
        break;
    }
  }
}