import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Views/preinscription.dart';
import 'package:flutterproject/Views/welcome.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Utils/Consts.dart';
import 'FormPage.dart';
import 'InfoPage.dart';
import '../Widgets/MenuBar.dart';


class Absences extends StatefulWidget {
    const Absences({Key? key}) : super(key: key);

  @override
  _AbsenceState createState() => _AbsenceState();
}

class _AbsenceState extends State<Absences> {
   int _selectedIndex = 6;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absences'),
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
        backgroundColor: Colors.green[500],
      ),
      drawer: buildMenuBar(selectedIndex: _selectedIndex),
      body: Column(
  children: <Widget>[
    const Padding(padding: EdgeInsets.only(top: 130)),
    const Text(
      "Liste des Absences :",
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Table(
        border: TableBorder.all(width: 1.0, color: Colors.black),
        children: const [
          TableRow(
            children: [
              Center(child: Text("Matiére", style: TextStyle(fontWeight: FontWeight.bold))),
              Center(child: Text("Nombre d'absence", style: TextStyle(fontWeight: FontWeight.bold))),
              Center(child: Text("Semestre", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          TableRow(
            children: [
              Center(child: Text("Architecture", style: TextStyle(fontWeight: FontWeight.bold))),
              Center(child: Text("2")),
              Center(child: Text("S1", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          TableRow(
            children: [
              Center(child: Text("UI/UX", style: TextStyle(fontWeight: FontWeight.bold))),
              Center(child: Text("5")),
              Center(child: Text("S1", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          TableRow(
            children: [
              Center(child: Text("Dév app web", style: TextStyle(fontWeight: FontWeight.bold))),
              Center(child: Text("1")),
              Center(child: Text("S1", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    ),
  ],
),bottomNavigationBar: SalomonBottomBar(
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
                  builder: (context) => InfoPage(),
                  fullscreenDialog: true,
                  maintainState: true,
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormApp(),
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
        items: Consts.navBarItems,
      ),
    );
  }
}