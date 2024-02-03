class ApiEndPoints {
  ApiEndPoints._();

  static const Duration connectionTimeOut = Duration(seconds: 1000);
  static const Duration receivedTimeOut = Duration(seconds: 1000);

  //for mac
  // static const String baseUrl = "http://localhost:5500/api/";

  //for windows
  static const String baseUrl = "http://192.168.1.65:5500/api/";
  // route for signing up users
  static const String signUp = "signup";
  //route for fetching all the user details
  static const String userDetails = 'getAllUsers';
  // route for users to set questions
  static const String addQuestion = 'questions/setQuestions';
  // route for fetching userSpecific questions
  static const String getAllquestion = 'questions/getQuestions';
  // route for fetching all the questions added by users
  static const String getAllPublicQuestions = 'questions/getAllQuestions';

  static const String login = "login";

  static const limitPage = 5;
}
