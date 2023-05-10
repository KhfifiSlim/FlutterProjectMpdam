import 'package:flutter/material.dart';
import 'package:flutterproject/preinscription.dart';
import 'package:flutterproject/welcome.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'dart:convert';
import 'Enseignant.dart';
import 'Semester.dart';
import 'InfoPage.dart';

class contact extends StatefulWidget {
  @override
  _contact createState() => _contact();
}

class _contact extends State<contact> {
  List<Semester>? _semesters;
  List<Enseignant>? _enseignants;
  int _selectedIndex = 2;
  final _navBarItems = [
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


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text('Contact Us'),
   titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Colors.blue,
  ),
  body: SingleChildScrollView(
  child: Column(
  children: [
  SizedBox(height: 20),
  Padding(
  padding: EdgeInsets.symmetric(horizontal: 20),
  child: TextField(
  decoration: InputDecoration(
  labelText: 'Name',
  border: OutlineInputBorder(),
  ),
  ),
  ),
  SizedBox(height: 20),
  Padding(
  padding: EdgeInsets.symmetric(horizontal: 20),
  child: TextField(
  decoration: InputDecoration(
  labelText: 'Email',
  border: OutlineInputBorder(),
  ),
  ),
  ),
  SizedBox(height: 20),
  Padding(
  padding: EdgeInsets.symmetric(horizontal: 20),
  child: TextField(
  maxLines: 5,
  decoration: InputDecoration(
  labelText: 'Message',
  border: OutlineInputBorder(),
  ),
  ),
  ),
  SizedBox(height: 20),
  ElevatedButton(
  onPressed: () {},
  child: Text('Submit'),
  ),
  ],
  ),
  ),

    bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          switch (index) {
               case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  welcome(),
                    fullscreenDialog: true,
                    maintainState: true,

                  ),
                );
                break; 
              
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  InfoPage(),
                  fullscreenDialog: true,
                  maintainState: true,

                ),
              );
              break;
            case 3:

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  preinscription(),
                  fullscreenDialog: true,
                  maintainState: true,

                ),
              );
              break;

          }

          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems),    );

  }
}
