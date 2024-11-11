import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiServices {
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://api.example.com';

  static Map<String, String> _headers([String? token]) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  static Map<String, dynamic> _processResponse(http.Response response) {
    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(utf8.decode(response.bodyBytes)),
    };
  }

  static Future<Map<String, dynamic>> get(String url, [String? token]) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + url),
        headers: _headers(token ?? ''),
      );

      return _processResponse(response);
    } catch (e) {
      return {
        'statusCode': 500,
        'body': {'error': 'Internal Server Error => ${e.toString()}'},
      };
    }
  }

  static Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> body,
      [String? token]) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: _headers(token ?? ''),
        body: jsonEncode(body),
      );

      return _processResponse(response);
    } catch (e) {
      return {
        'statusCode': 500,
        'body': {'error': 'Internal Server Error => ${e.toString()}'},
      };
    }
  }

  static Future<Map<String, dynamic>> put(String url, Map<String, dynamic> body,
      [String? token]) async {
    try {
      final response = await http.put(
        Uri.parse(baseUrl + url),
        headers: _headers(token ?? ''),
        body: jsonEncode(body),
      );

      return _processResponse(response);
    } catch (e) {
      return {
        'statusCode': 500,
        'body': {'error': 'Internal Server Error => ${e.toString()}'},
      };
    }
  }

  static Future<Map<String, dynamic>> delete(String url,
      [String? token]) async {
    try {
      final response = await http.delete(
        Uri.parse(baseUrl + url),
        headers: _headers(token ?? ''),
      );

      return _processResponse(response);
    } catch (e) {
      return {
        'statusCode': 500,
        'body': {'error': 'Internal Server Error => ${e.toString()}'},
      };
    }
  }
}
