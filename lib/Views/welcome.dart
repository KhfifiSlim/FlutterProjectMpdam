import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterproject/Views/FormPage.dart';
import 'package:flutterproject/Views/InfoPage.dart';
import 'package:flutterproject/Views/preinscription.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Consts.dart';
import '../Widgets/MenuBar.dart';
import '../Widgets/MenuBar2.dart';

class WelcomeData {
  final String title;
  final String desc;

  WelcomeData({required this.title, required this.desc});

  factory WelcomeData.fromJson(Map<String, dynamic> json) {
    return WelcomeData(
      title: json['title'],
      desc: json['desc'],
    );
  }
}

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<welcome> {
  bool checkuser=false;
  List<WelcomeData>? WelcomeDatas;
  int _selectedIndex = 0;
 
  @override
  void initState() {
    super.initState();
    _checkUserId();
    _fetchWelcome();
    
  }
  void _checkUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasUserId = prefs.containsKey('userid');
    setState(() {
      checkuser = hasUserId;
    });
  }
void _fetchWelcome() async {
    final response = await http.get(Uri.parse('http://192.168.1.9:3005/welcome'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<WelcomeData> datas = [];
      data.forEach((welcomed) {
        datas.add(WelcomeData.fromJson(welcomed));
      });
      setState(() {
        WelcomeDatas = datas;
      });
    } else {
      throw Exception('Failed to fetch welcome datas');
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME PAGE'),
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
      drawer: checkuser ? buildMenuBar2(selectedIndex: _selectedIndex) : buildMenuBar(selectedIndex: _selectedIndex),
      body: Center(
        /** Card Widget **/
        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.greenAccent[100],
          child: SizedBox(
            width: 300,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green[500],
                    radius: 108,
                    child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/institut.gif"),
                    radius: 150,
                  )
                  , //CircleAvatar
                  ), //CircleAvatar
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    'MPDAM',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green[900],
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  WelcomeDatas != null
  ? Text(
      WelcomeDatas![_selectedIndex].desc,
      style: TextStyle(
        fontSize: 15,
        color: Colors.green,
      ),
    )
  : CircularProgressIndicator(),
 //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  SizedBox(
                    width: 100,
                  ) //SizedBox
                ],
              ), //Column
            ), //Padding
          ), //SizedBox
        ), //Card
      ),
  
          
      
           bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            switch (index) {
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
    case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  FormApp(),
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
          items: checkuser ? Consts.navBarItems2: Consts.navBarItems),
      );
    
  }
}