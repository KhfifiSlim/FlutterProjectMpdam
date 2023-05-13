import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Consts.dart';
import '../Views/welcome.dart';

Widget buildMenuBar({required int selectedIndex}) {
  return MenuBar(selectedIndex: selectedIndex);
}

class MenuBar extends StatelessWidget {
  const MenuBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade500, Colors.teal.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MPDAM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Consts.onItemTapped(context, 0);
            },
            selected: selectedIndex == 0,
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Info Page'),
            onTap: () {
              Consts.onItemTapped(context, 1);
            },
            selected: selectedIndex == 1,
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Us'),
            onTap: () {
              Consts.onItemTapped(context, 2);
            },
            selected: selectedIndex == 2,
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text('Pré-inscription'),
            onTap: () {
              Consts.onItemTapped(context, 3);
            },
            selected: selectedIndex == 3,
          ),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Liste des notes'),
            onTap: () {
              Consts.onItemTapped(context, 4);
            },
            selected: selectedIndex == 4,
          ),
          ListTile(
            leading: Icon(Icons.table_rows),
            title: Text('Emploi du temp'),
            onTap: () {
              Consts.onItemTapped(context, 5);
            },
            selected: selectedIndex == 5,
          ),
          ListTile(
            leading: Icon(Icons.table_rows_outlined),
            title: Text('Liste des absences'),
            onTap: () {
              Consts.onItemTapped(context, 6);
            },
            selected: selectedIndex == 6,
          ),
          
        ],
      ),
    );
  }
}
