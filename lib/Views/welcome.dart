import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterproject/Views/FormPage.dart';
import 'package:flutterproject/Views/InfoPage.dart';
import 'package:flutterproject/Views/table.dart';
import 'package:flutterproject/Views/FormPage.dart';
import 'package:flutterproject/Views/preinscription.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Utils/Consts.dart';
import '../Widgets/MenuBar.dart';

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
 

  @override
  void initState() {
    super.initState();
    _fetchWelcome();
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
      drawer: buildMenuBar(selectedIndex: _selectedIndex),
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
                      backgroundImage: NetworkImage(
                          "https://scontent.fnbe1-2.fna.fbcdn.net/v/t39.30808-6/308189261_469439475223960_2889498895712780959_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=e3f864&_nc_ohc=xIzUi5ltVIMAX8b4gbJ&_nc_ht=scontent.fnbe1-2.fna&oh=00_AfC-tETO7ayvvhDCi5tQDxUxp7E_fu3OuHZ4jeHVkISA2Q&oe=64602967"), //NetworkImage
                      radius: 100,
                    ), //CircleAvatar
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
                    // RaisedButton is deprecated and should not be used
                    // Use ElevatedButton instead
 
                    // child: RaisedButton(
                    //   onPressed: () => null,
                    //   color: Colors.green,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(4.0),
                    //     child: Row(
                    //       children: const [
                    //         Icon(Icons.touch_app),
                    //         Text('Visit'),
                    //       ],
                    //     ), //Row
                    //   ), //Padding
                    // ), //RaisedButton
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
          items: Consts.navBarItems),
      );
    
  }
}
