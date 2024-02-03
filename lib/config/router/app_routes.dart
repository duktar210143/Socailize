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

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      signUpRoute: (context) => const SignUpView(),
      userDetailRoute: (context) => const UserDetailsView(),
      loginRoute: (context) => const LoginView(),
      dashboard: (context) => const DashboardView()
      // batchStudentRoute: (context) => const BatchStudentView(null),
      // googleMapRoute: (context) => const GoogleMapView(),
    };
  }
}
