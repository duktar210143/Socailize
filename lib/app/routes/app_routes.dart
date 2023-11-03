import 'package:discussion_forum/app/authentication/login_view.dart';
import 'package:discussion_forum/app/authentication/signup_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";

  static getAppliactionRoute() {
    return {
      signUpRoute: (context) => SignUpView(),
      loginRoute: (context) => const LoginView(),
    };
  }
}
