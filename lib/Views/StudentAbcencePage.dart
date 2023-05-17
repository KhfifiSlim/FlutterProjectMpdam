import 'package:flutter/material.dart';
import 'package:flutterproject/Views/preinscription.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'dart:convert';

import '../Utils/Consts.dart';
import '../models/AbsenceResp.dart';
import '../Services/ApiClient.dart';
import 'FormPage.dart';
import 'InfoPage.dart';

class StudentAbcencePage extends StatefulWidget {
  @override
  _StudentAbcencePageState createState() => _StudentAbcencePageState();
}
class _StudentAbcencePageState extends State<StudentAbcencePage> {
  late Future<AbsenceResp> futureStudent;
    bool checkuser=true;
      int _selectedIndex = 0;



  @override
  void initState() {
    super.initState();
    futureStudent = ApiClient.fetchStudent();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abcences'),
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
      body: Center(
        child: FutureBuilder<AbsenceResp>(
          future: futureStudent,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    SizedBox(height: 20),
    Expanded(
  child: ListView.builder(
    itemCount: snapshot.data?.absences.length ?? 0,
    itemBuilder: (context, index) {
      int absenceCount = snapshot.data?.absences[index].absence ?? 0;
      bool exceedAbsenceLimit = absenceCount >= 3;

      return Card(
        elevation: 3,
        color: exceedAbsenceLimit ? Colors.red : null,
        child: ListTile(
          title: Text(snapshot.data?.absences[index].mat ?? ""),
          subtitle: Text('Session manquée: ${absenceCount.toString()}'),
        ),
      );
    },
  ),
)
  ],
);

            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
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