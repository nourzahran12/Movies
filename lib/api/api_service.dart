import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> getMovies() async {
    try {
      var url = Uri.parse(
        "https://movies-api.accel.li/api/v2/list_movies.json",
      );

      var response = await http.get(url);

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data['data']['movies'] ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print("ERROR: $e");
      return [];
    }
  }
}