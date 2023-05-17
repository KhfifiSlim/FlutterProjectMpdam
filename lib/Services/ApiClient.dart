import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/AbsenceResp.dart';

import '../models/NotesResp.dart';
import '../models/login_request_model.dart';
class ApiClient {
    static var client = http.Client();
static String idlogged = "";
  static int userTel = 0;

  
 static const String url="127.0.0.1:4000";

 //student absences
 static Future<AbsenceResp> fetchStudent() async {
   
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('userid');
    final response =
    await http.get(Uri.parse('http://127.0.0.1:4000/absence/list/${uid}'));

    if (response.statusCode == 200) {
      return AbsenceResp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load student abcenses');
    }
  }
  //student notes
 static Future<NotesResp> fetchStudentNotes() async {
   
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('userid');
    final response =
    await http.get(Uri.parse('http://127.0.0.1:4000/note/list/${uid}'));

    if (response.statusCode == 200) {
      return NotesResp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load notes');
    }
  }
 static Future<void> postpreinscription(String requestBodyJson) async {
  Uri url = Uri.parse('http://127.0.0.1:4000/preinscription/insert');

  http.Response response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: requestBodyJson,
  );

 
  if (response.statusCode == 200) {
    // test commit
    print(response.body);
  } else {
   
    print('Error: ${response.statusCode}');
  }
}

static Future<String> login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

  const loginAPI = "/users/login";
    var url2 = Uri.http(
      url,
      loginAPI,
    );

    var response = await client.post(
      url2,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    var responseBody = jsonDecode(response.body);
    var message = responseBody['message'];
    if (message == "Success") {
   
      var responseBody = jsonDecode(response.body);
      var token = responseBody['data']['token'];
      idlogged = responseBody['data']['id'];
      userTel = responseBody['data']['tel'];  
       SharedPreferences.getInstance().then((SharedPreferences prefs) {
       prefs.setString('token' , token);
       prefs.setString('userid' , idlogged);
       
      
    });
    

      return "Success";
    } else if (message == "Invalid Email!") {
      return "Invalid Email!";
    } else if (message == "Invalid Password!") {
      return "Invalid Password!";
    } else {
      return "error";
    }
  }


}