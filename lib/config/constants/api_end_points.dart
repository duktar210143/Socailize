class ApiEndPoints {
  ApiEndPoints._();

  static const Duration connectionTimeOut = Duration(seconds: 1000);
  static const Duration receivedTimeOut = Duration(seconds: 1000);

  //for mac
  // static const String baseUrl = "http://localhost:5500/api/";

  //for windows
  static const String baseUrl = "http://192.168.1.68:5500/api/";

  // route for socket service
  static const String socketUrl = "http://192.168.1.68:8801";
  // route for signing up users
  static const String signUp = "signup";
  // route to sign in the users
  static const String login = "login";
  //route for fetching all the user details
  static const String userDetails = 'getAllUsers';
  // route for updating profile image
  static const String setProfile = 'profile/setProfile';
  // route for users to set questions
  static const String addQuestion = 'questions/setQuestions';
  // route for fetching userSpecific questions
  static const String getAllquestion = 'questions/getQuestions';
  // route for fetching all the questions added by users
  static const String getAllPublicQuestions = 'questions/getAllQuestions';
  // route for fetching user Specific replies
  static const String setUserSpecificReplies = 'questions/setReply/';
  static const String getUserSpecificReplies = 'questions/getReplies/';
  // route to delete particular question
  static const String deletequestion = "questions/deleteQuestion/";

  // forget password Route
  static const String forgotPassword = "user/forgot_password";

  static const limitPage = 5;
}
