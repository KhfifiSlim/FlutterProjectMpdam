import 'package:flutter/material.dart';
import 'package:flutterproject/Services/ApiClient.dart';
import 'package:flutterproject/Views/preinscription.dart';
import 'package:flutterproject/Views/register.dart';
import 'package:flutterproject/Views/welcome.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../models/login_request_model.dart';
import '../Utils/Consts.dart';
import '../Widgets/MenuBar.dart';
import 'FormPage.dart';
import 'InfoPage.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
     int _selectedIndex = 7;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late String email;
  late String password;
  String appName = "Mpdam";
  bool checkuser=false;

  @override
  void initState() {
    super.initState();
    _checkUserId();
  }
   void _checkUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasUserId = prefs.containsKey('userid');
    setState(() {
      checkuser = hasUserId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff575de3),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Login'),
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
                "Login",
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
              "Email",
              "Email",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'email can\'t be empty.';
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
              "Login",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  LoginRequestModel model = LoginRequestModel(
                    email: email,
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
                MaterialPageRoute(builder: (context) => PageRegister()),
              );
            },
            child: Text(
              "Register now ",
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
          
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        items: checkuser ? Consts.navBarItems2: Consts.navBarItems),
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