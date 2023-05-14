import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Services/ApiClient.dart';
import 'package:flutterproject/Views/preinscription.dart';
import 'package:flutterproject/Views/welcome.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../Config/size_config.dart';
import '../../models/login_request_model.dart';
import '../Utils/Consts.dart';
import '../Widgets/MenuBar.dart';
import 'FormPage.dart';
import 'InfoPage.dart';
import 'login.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({Key? key}) : super(key: key);

  
  @override
  _PageRegisterState createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
     int _selectedIndex = 7;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late String userName;
  late String email;
  late String password;
  String appName = "Mpdam";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff575de3),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Register'),
      backgroundColor: Colors.green[500],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100),
          bottomLeft: Radius.circular(100),
        ),
      ),
      elevation: 0.0,
    ),
    drawer: buildMenuBar(selectedIndex: _selectedIndex),

    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/login.gif",
                    fit: BoxFit.contain,
                    width: 220,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Center(
              child: Text(
                "Register",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "Username",
              "Username",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Username can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                userName = onSavedVal,
              },
              initialValue: "",
              obscureText: false,
              borderFocusColor: Colors.black,
              prefixIconColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "Email",
              "Email",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Email can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                email = onSavedVal,
              },
              initialValue: "",
              obscureText: false,
              borderFocusColor: Colors.black,
              prefixIconColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "Password",
              "Password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Password can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                password = onSavedVal,
              },
              initialValue: "",
              obscureText: hidePassword,
              borderFocusColor: Colors.black,
              prefixIconColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.black.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Register",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  LoginRequestModel model = LoginRequestModel(
                    email: userName,
                    password: password,
                  );

                  ApiClient.login(model).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                     // print("aaaaaaa123"+response);

                      if (response == "Success") {
                         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => welcome()),
        );
                      } else if (response == "Invalid Email!") {
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid Email')),
                      );
                      } else if (response == "Invalid Password!") {
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid password')),
                      );
                      }
                    },
                  );
                }
              },
              btnColor: Color.fromARGB(255, 67, 203, 76),
              borderColor: Colors.black,
              txtColor: Colors.black,
              borderRadius: 10,
            ),
            
          ),
          Divider(),
          Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PageLogin()),
              );
            },
            child: Text(
              "Already have an account? Login here",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
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

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form!.save();
      return true;
    }
    return false;
  }
}