class ApiEndPoints {
  ApiEndPoints._();

  static const Duration connectionTimeOut = Duration(seconds: 1000);
  static const Duration receivedTimeOut = Duration(seconds: 1000);

  //for mac
  static const String baseUrl = "http://localhost:5500/api/";

  //for windows
  // static const String baseUrl = "http://192.168.1.65:3000/api/";
  static const String signUp = "signup";
  static const String userDetails = 'getAllUsers';

  static const String login = "login";

  static const limitPage = 9;
}
