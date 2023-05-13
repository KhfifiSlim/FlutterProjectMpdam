import 'package:http/http.dart' as http;
class ApiClient {
 static const String url="127.0.0.1:4000";
 static Future<void> postpreinscription(String requestBodyJson) async {
  Uri url = Uri.parse('http://127.0.0.1:4000/preinscription/insert');
  http.Response response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: requestBodyJson,
  );

  // Check the response status code
  if (response.statusCode == 200) {
    // Successful request, do something with the response data
    print(response.body);
  } else {
    // Error, handle the response accordingly
    print('Error: ${response.statusCode}');
  }
}

}

