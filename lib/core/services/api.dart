import 'dart:convert';
import 'package:account_net/features/auth/auth_helpers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiServices {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:8000';

  static Future<Map<String, String>> _headers() async {
    final token = await AuthHelpers().getData('token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Map<String, dynamic> _processResponse(http.Response response) {
    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(utf8.decode(response.bodyBytes)),
    };
  }

  static Future<Map<String, dynamic>> get(String url) async {
    try {
      final headers = await _headers();
      final response = await http.get(
        Uri.parse(baseUrl + url),
        headers: headers,
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
      String url, Map<String, dynamic> body) async {
    try {
      final headers = await _headers();
      debugPrint('API Request to: ${baseUrl + url}');
      final response = await http.post(
        Uri.parse(baseUrl + url),
        headers: headers,
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

  static Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> body) async {
    try {
      final headers = await _headers();
      final response = await http.put(
        Uri.parse(baseUrl + url),
        headers: headers,
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

  static Future<Map<String, dynamic>> delete(String url) async {
    try {
      final headers = await _headers();
      final response = await http.delete(
        Uri.parse(baseUrl + url),
        headers: headers,
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
