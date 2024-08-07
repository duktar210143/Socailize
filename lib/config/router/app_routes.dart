import 'package:discussion_forum/features/authentication/presentation/view/forget_pass_form.dart';
import 'package:discussion_forum/features/authentication/presentation/view/login_view.dart';
import 'package:discussion_forum/features/authentication/presentation/view/signup_view.dart';
import 'package:discussion_forum/features/authentication/presentation/view/user_detail_view.dart';
import 'package:discussion_forum/features/home/presentation/view/home_view.dart';

import 'package:discussion_forum/features/splash/presentation/view/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = "/splashRoute";
  static const String signUpRoute = '/';
  static const String loginRoute = "/login";
  static const String userDetailRoute = "/userDetails";
  static const String dashboard = "/dashboard";
  static const String forgotPassRoute = "/forgotPass";
  static const String chatsScreenRoute = "/chatsScreen";
  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      signUpRoute: (context) => const SignUpView(),
      userDetailRoute: (context) => const UserDetailView(),
      loginRoute: (context) => const LoginView(),
      dashboard: (context) => const DashboardView(),
      forgotPassRoute: (context) => const GeneralForm(),
      // batchStudentRoute: (context) => const BatchStudentView(null),
      // googleMapRoute: (context) => const GoogleMapView(),
    };
  }
}
