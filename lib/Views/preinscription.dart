import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutterproject/Views/welcome.dart';
import 'package:http/http.dart' as http;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'dart:convert';
import '../Enseignant.dart';
import '../Semester.dart';
import '../Services/ApiClient.dart';
import '../Utils/Consts.dart';
import 'InfoPage.dart';
import 'FormPage.dart';
import '../Widgets/MenuBar.dart';

class preinscription extends StatefulWidget {
  @override
  _preinscription createState() => _preinscription();
}

class _preinscription extends State<preinscription> {
  int _selectedIndex = 3;
 
   final formKey = GlobalKey<FormState>();
  String? name = "";
  String? email = "";
  int? phone = 0;
  String? baccalaureate = "";
  String? l1 = "";
  String? l2 = "";
  String? l3 = "";
  String? pfe = "";
  String? formattedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
  }
 void submitForm() async {
  if (!formKey.currentState!.validate()) {
    // Form is not valid
    return;
  }

  // Form is valid, save the data
  formKey.currentState!.save();

  // prepare the request body
  Map<String, dynamic> body = {
    'nom': name,
    'email': email,
    'num': phone,
    'date': formattedDate,
    'moyBac': baccalaureate,
    'moy1': l1,
    'moy2': l2,
    'moy3': l3,
    'pfe': pfe,
  };
  String requestBodyJson = json.encode(body);

  try {
    // Make the API call
    await ApiClient.postpreinscription(requestBodyJson);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Form submitted successfully')),
    );
  } catch (e) {
    // Show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to submit form')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Préinscription'),
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

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
               TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ), TextFormField(
                   decoration: InputDecoration(labelText: 'Phone'),
                   validator: (value) {
                 if (value!.isEmpty) {
                   return 'Please enter your Phone';
                     }
                       return null;
                                 },
                  onSaved: (value) {
                         phone = int.parse(value!);
                                      },
                    ),

             TextFormField(
                decoration: InputDecoration(labelText: 'moy1'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your moy1';
                  }
                  return null;
                },
                onSaved: (value) {
                  l1 = value;
                },
              ), TextFormField(
                decoration: InputDecoration(labelText: 'moy2'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your moy2';
                  }
                  return null;
                },
                onSaved: (value) {
                  l2 = value;
                },
              ), TextFormField(
                decoration: InputDecoration(labelText: 'moy3'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your moy3';
                  }
                  return null;
                },
                onSaved: (value) {
                  l3 = value;
                },
              ), TextFormField(
                decoration: InputDecoration(labelText: 'pfe'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your pfe';
                  }
                  return null;
                },
                onSaved: (value) {
                  pfe = value;
                },
              ), TextFormField(
                decoration: InputDecoration(labelText: 'moyBac'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your moyBac';
                  }
                  return null;
                },
                onSaved: (value) {
                  baccalaureate = value;
                },
              ),  SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
              
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                      submitForm();
                    }
                 ,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),]
      ),)),


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

            }

            setState(() {
              _selectedIndex = index;
            });
          },
          items: Consts.navBarItems),    );

  }
}
