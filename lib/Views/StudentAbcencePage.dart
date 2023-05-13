import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/AbsenceResp.dart';
import '../Services/ApiClient.dart';

class StudentAbcencePage extends StatefulWidget {
  @override
  _StudentAbcencePageState createState() => _StudentAbcencePageState();
}
class _StudentAbcencePageState extends State<StudentAbcencePage> {
  late Future<AbsenceResp> futureStudent;

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
        backgroundColor: Colors.blue,
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
                      itemCount: snapshot.data?.absences.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data?.absences[index].mat ?? ""),
                          subtitle: Text('Session manquée: ${snapshot.data?.absences[index].absence.toString() ?? "" }'),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
