import 'package:discussion_forum/features/authentication/presentation/view/login_view.dart';
import 'package:discussion_forum/features/authentication/presentation/view/signup_view.dart';
import 'package:discussion_forum/features/home/dashboard_view.dart';

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
