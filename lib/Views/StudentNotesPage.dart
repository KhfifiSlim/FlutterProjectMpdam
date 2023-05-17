import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Utils/Consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Services/ApiClient.dart';
import '../models/NotesResp.dart';

class StudentNotesPage extends StatefulWidget {
  const StudentNotesPage({Key? key}) : super(key: key);

  @override
  _StudentNotesPageState createState() => _StudentNotesPageState();
}

class _StudentNotesPageState extends State<StudentNotesPage> {
  Future<NotesResp>? _notesRespFuture;

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

            return Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 130)),
                const Text(
                  "Liste des Notes :",
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
                    children: [
                      const TableRow(
                        children: [
                          Center(
                            child: Text(
                              "Matière",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Note Np",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Note DC",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                            Center(
                            child: Text(
                              "Note TP",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      for (Note note in notes)
                        TableRow(
                          children: [
                            Center(child: Text(note.mat ?? "")),
                            Center(child: Text(note.noteNp.toString() ?? "" )),
                            Center(child: Text(note.noteDc.toString() ?? "" )),
                            Center(child: Text(note.noteTp.toString() ?? "" )),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
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
    );
  }
}
