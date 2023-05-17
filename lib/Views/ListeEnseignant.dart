import 'package:flutter/material.dart';
import 'package:flutterproject/Views/FormPage.dart';
import 'package:flutterproject/Views/preinscription.dart';
import 'package:flutterproject/Views/welcome.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'dart:convert';
import '../Enseignant.dart';

import '../Utils/Consts.dart';
import 'FormPage.dart';
import '../Widgets/MenuBar.dart';
import 'welcome.dart';

class ListeEnsPage extends StatefulWidget {
  @override
  _ListeEnsPageState createState() => _ListeEnsPageState();
}

class _ListeEnsPageState extends State<ListeEnsPage> {
  List<Enseignant>? _enseignants;
  int _selectedIndex = 1;



  @override
  void initState() {
    super.initState();
    _fetchEnseignant();
  }

  void _fetchEnseignant() async {
    final response = await http.get(Uri.parse('http://192.168.1.9:3004/enseignants'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Enseignant> enseignants = [];
      data.forEach((enseignant) {
        enseignants.add(Enseignant.fromJson(enseignant));
      });
      setState(() {
        _enseignants = enseignants;
      });
    } else {
      throw Exception('Failed to fetch enseignants');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Enseignants'),
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
      body: _enseignants != null
          ? Card(
      child: Column(
        children: [
          Text(
              'Enseignants',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _enseignants!.length,
            itemBuilder: (BuildContext context, int index) {
              final enseignant = _enseignants![index];
              return ListTile(
                title: Text(enseignant.nom),
                subtitle: Text(enseignant.email),
              );
            },
          ),
        ],
      ),
    )

          : const Center(
        child: CircularProgressIndicator(),
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
