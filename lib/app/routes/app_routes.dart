import 'package:discussion_forum/app/authentication/login_view.dart';
import 'package:discussion_forum/app/authentication/signup_view.dart';
import 'package:discussion_forum/app/home/dashboard_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";
  static const String homeRoute = "/home";

  static getAppliactionRoute() {
    return {
      signUpRoute: (context) => SignUpView(),
      loginRoute: (context) => const LoginView(),
      homeRoute: (context) => const DashboardView(),
    };
  }
}
