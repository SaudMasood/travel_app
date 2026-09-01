import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception(
        'GET failed: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('GET Error: $e');
    }
  }

  Future<dynamic> post(
      String url,
      Map<String, dynamic> data,
      ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return jsonDecode(response.body);
      }

      throw Exception(
        'POST failed: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('POST Error: $e');
    }
  }

  Future<dynamic> put(
      String url,
      Map<String, dynamic> data,
      ) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception(
        'PUT failed: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('PUT Error: $e');
    }
  }


  Future<bool> delete(String url) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 204) {
        return true;
      }

      throw Exception(
        'DELETE failed: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('DELETE Error: $e');
    }
  }
}