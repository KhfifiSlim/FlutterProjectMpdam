import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterproject/InfoPage.dart';
import 'package:flutterproject/contact.dart';
import 'package:flutterproject/preinscription.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
  List<WelcomeData>? WelcomeDatas;
  int _selectedIndex = 0;
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
      title: const Text("Join"),
      selectedColor: Colors.teal,
    ),
  ];


  @override
  void initState() {
    super.initState();
    _fetchWelcome();
  }

void _fetchWelcome() async {
    final response = await http.get(Uri.parse('http://172.16.21.162:3005/welcome'));
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
        title: Text('Welcome '),
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
      body: WelcomeDatas != null 
          ? ListView.builder(
        itemCount: WelcomeDatas!.length,
        itemBuilder: (BuildContext context, int index) {
          final welcome = WelcomeDatas![index];
          return Card(
            child: Column(
              children: [
                if (index == 0)
                   ListTile(
                    title: Text(welcome.title,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    
                    textColor: Colors.blue,
                  ),
                  ListTile(
                    title: Text(welcome.desc,
                    ),
                    
                    
                  ),
              ],
            ),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
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
                    builder: (context) =>  contact(),
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
          items: _navBarItems),
      );
    
  }
}
