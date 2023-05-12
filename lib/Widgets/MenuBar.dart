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
            child: const Column(
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Consts.onItemTapped(context, 0);
            },
            selected: selectedIndex == 0,
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Info Page'),
            onTap: () {
              Consts.onItemTapped(context, 1);
            },
            selected: selectedIndex == 1,
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contact Us'),
            onTap: () {
              Consts.onItemTapped(context, 2);
            },
            selected: selectedIndex == 2,
          ),
          ListTile(
            leading: const Icon(Icons.contact_page),
            title: const Text('Pré-inscription'),
            onTap: () {
              Consts.onItemTapped(context, 3);
            },
            selected: selectedIndex == 3,
          ),
          ListTile(
            leading: const Icon(Icons.note),
            title: const Text('Liste des notes'),
            onTap: () {
              Consts.onItemTapped(context, 4);
            },
            selected: selectedIndex == 4,
          ),
          ListTile(
            leading: const Icon(Icons.table_rows),
            title: const Text('Listes des enseignants'),
            onTap: () {
              Consts.onItemTapped(context, 5);
            },
            selected: selectedIndex == 5,
          ),
          ListTile(
            leading: const Icon(Icons.table_rows_outlined),
            title: const Text('Liste des absences'),
            onTap: () {
              Consts.onItemTapped(context, 6);
            },
            selected: selectedIndex == 6,
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              Consts.onItemTapped(context, 7);
            },
            selected: selectedIndex == 7,
          ),
          
        ],
      ),
    );
  }
}
