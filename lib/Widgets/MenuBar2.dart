import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Consts.dart';
import '../Views/welcome.dart';

Widget buildMenuBar2({required int selectedIndex}) {
  return MenuBar2(selectedIndex: selectedIndex);
}

class MenuBar2 extends StatelessWidget {
  const MenuBar2({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
    color: Colors.white,
    child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/institut.gif",
                    fit: BoxFit.contain,
                    width: 300,
                    height: 300,
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
         ExpansionTile(
            leading: const Icon(Icons.list),
            title: const Text('Listes'),
            children: [
              ListTile(
                leading: const Icon(Icons.table_rows_outlined),
                title: const Text('Liste des absences'),
                onTap: () {
                  Consts.onItemTapped(context, 4);
                },
                selected: selectedIndex == 4,
              ),
              ListTile(
                leading: const Icon(Icons.note),
                title: const Text('Liste des notes'),
                onTap: () {
                  Consts.onItemTapped(context, 6);
                },
                selected: selectedIndex == 4,
              ),
              // Add more ListTiles for additional options
            ],
          ),
          Divider(),
          Spacer(),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Logout'),
            onTap: () {
              Consts.onItemTapped(context, 7);
            },
            selected: selectedIndex == 7,
          ),
          
        ],
      ),
    ),
    );
  }
}
