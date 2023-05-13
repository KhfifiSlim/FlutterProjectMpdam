import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/AbsenceResp.dart';
class ApiClient {
 static const String url="127.0.0.1:4000";
 //load absences par user
 static Future<AbsenceResp> fetchStudent() async {
    //id par defaut=64600036e0b41de95f4aff4d
    //change it with shared pref after login
    final response =
    await http.get(Uri.parse('http://127.0.0.1:4000/absence/list/64600036e0b41de95f4aff4d'));

    if (response.statusCode == 200) {
      return AbsenceResp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load student');
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

}

