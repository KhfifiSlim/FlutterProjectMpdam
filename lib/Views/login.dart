import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterproject/Views/InfoPage.dart';
import 'package:flutterproject/Views/welcome.dart';
import '../Config/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Widgets/MenuBar.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
    int _selectedIndex = 7;


  bool remember = false;
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String url ="http://192.168.1.9:5000";


  void _submitlog() async {

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if ( _email != "" && _password != "")
      {

        final response = await http.post(
          Uri.parse('${url}/users/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "email": _email,
            "password": _password,
          }),
        );


        if (response.statusCode == 201) {
          final jsonResponse = json.decode(response.body);
          final token = jsonResponse['token'];
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoPage()),
          );
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid credentials"),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }

      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Fill Credientiels"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Sign in'),
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

      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Welcome MPDAM",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(20),
                          child: Icon(Icons.email),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        if (value != null) {
                          _email = value;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your Password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(20),
                          child: Icon(Icons.key),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (value) {
                        if (value != null) {
                          _password = value;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(56),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    _submitlog();
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
            
            ],
          ),
        ),
      ),
    );
  }

  TextFormField formEmail(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(20),
          child: Icon(Icons.email),
        ),

      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  TextFormField formPassword(){
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(20),
          child: Icon(Icons.key),
        ),

      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }
}



