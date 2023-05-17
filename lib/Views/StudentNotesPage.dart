import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Utils/Consts.dart';
import 'package:flutterproject/Views/preinscription.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Services/ApiClient.dart';
import '../models/NotesResp.dart';
import 'FormPage.dart';
import 'InfoPage.dart';

class StudentNotesPage extends StatefulWidget {
  const StudentNotesPage({Key? key}) : super(key: key);

  @override
  _StudentNotesPageState createState() => _StudentNotesPageState();
}

class _StudentNotesPageState extends State<StudentNotesPage> {
  Future<NotesResp>? _notesRespFuture;
    bool checkuser=true;
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    _notesRespFuture = ApiClient.fetchStudentNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
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
      body: FutureBuilder<NotesResp>(
        future: _notesRespFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Note> notes = snapshot.data!.data?.note ?? [];

            return Container(
  alignment: Alignment.topCenter,
  padding: const EdgeInsets.all(10),
  child: Column(
    children: <Widget>[
      const Text(
        "Liste des Notes :",
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      const SizedBox(),
      Expanded(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                label: Text(
                  "Matière",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Set the desired color here
                  ),
                ),
              ),
                DataColumn(
                  label: Text(
                    "Note Np",
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Set the desired color here
                  ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Note DC",
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Set the desired color here
                  ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Note TP",
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Set the desired color here
                  ),
                  ),
                ),
              ],
              rows: notes.map((note) {
                return DataRow(
                  cells: [
                    DataCell(
                      Center(child: Text(note.mat ?? "")),
                    ),
                    DataCell(
                      Center(child: Text(note.noteNp.toString() ?? "")),
                    ),
                    DataCell(
                      Center(child: Text(note.noteDc.toString() ?? "")),
                    ),
                    DataCell(
                      Center(child: Text(note.noteTp.toString() ?? "")),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ],
  ),
);;
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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