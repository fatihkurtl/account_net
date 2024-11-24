import 'package:account_net/core/services/api.dart';

class AuthService {
  static String prefix = '/api/v1/users';

  static Future<Map<String, dynamic>> authenticate({
    required String route,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await ApiServices.post(
        '$prefix$route',
        body,
      );

      return response;
    } catch (e) {
      return {
        'statusCode': 500,
        'body': {'error': e.toString()},
      };
    }
  }
}
