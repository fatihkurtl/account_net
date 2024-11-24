class ApiResponse {
  final int statusCode;
  final ResponseBody body;

  ApiResponse({required this.statusCode, required this.body});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode'],
      body: ResponseBody.fromJson(json['body']),
    );
  }
}

class ResponseBody {
  final String message;
  final bool success;
  final Map<String, dynamic>? errors;

  ResponseBody({required this.message, required this.success, this.errors});

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      message: json['message'],
      success: json['success'],
      errors: json['errors'] != null ? Map<String, dynamic>.from(json['errors']) : null,
    );
  }
}
