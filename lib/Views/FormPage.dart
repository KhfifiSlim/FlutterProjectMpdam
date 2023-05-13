import 'package:flutter/material.dart';
import 'package:flutterproject/Views/preinscription.dart';
import 'package:flutterproject/Views/welcome.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Utils/Consts.dart';
import '../Views/InfoPage.dart';
import '../Widgets/MenuBar.dart';


void main() {
  runApp(const FormApp());
}

class FormApp extends StatelessWidget {
  const FormApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Us',
      home: const FormPage(title: 'Contact Us'),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
   int _selectedIndex = 2;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 80.2,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contact Form',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 350,
              child: Container(
                child: ContactForm(),
                margin: const EdgeInsets.symmetric(horizontal: 15),

              ),
            ),
          ],
        ),
      ),bottomNavigationBar: SalomonBottomBar(
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
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoPage(),
                  fullscreenDialog: true,
                  maintainState: true,
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormApp(),
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
        items: Consts.navBarItems,
      ),
   
    );
  }
}


class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _Message = '';



  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value.toString();
        });
      },
    ));

    validateEmail(String? value) {
      if (value!.isEmpty) {
        return 'Please enter mail';
      }

      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value.toString())) {
        return 'Enter Valid Email';
      } else {
        return null;
      }
    }

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Enter Email', hintText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (value) {
        setState(() {
          _email = value.toString();
        });
      },
    ));

   formWidget.add(SizedBox(
  height: 150,
  child: TextFormField(
    decoration: const InputDecoration(
      hintText: 'Message',
      labelText: 'Enter Message',
      contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),

    ),
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter Message';
      } else {
        return null;
      }
    },
  ),
));




    void onPressedSubmit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));
      }
    }

   formWidget.add(ElevatedButton(
  onPressed: onPressedSubmit,
  child: const Text('Submit'),
  style: ElevatedButton.styleFrom(
    fixedSize: Size(150, 50), // sets the size of the button
    textStyle: TextStyle(fontSize: 20), 
    backgroundColor: Colors.green[400],
// sets the size of the text
  ),
));

    return formWidget;
  }
}
