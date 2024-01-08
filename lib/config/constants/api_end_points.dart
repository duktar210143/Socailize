class ApiEndPoints {
  ApiEndPoints._();

  static const Duration connectionTimeOut = Duration(seconds: 1000);
  static const Duration receivedTimeOut = Duration(seconds: 1000);

  static const String baseUrl = "http://localhost:3000/api/";
  static const String signUp = "/signup";
}
