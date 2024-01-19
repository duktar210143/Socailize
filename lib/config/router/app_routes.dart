import 'package:discussion_forum/features/authentication/presentation/view/signup_view.dart';
import 'package:discussion_forum/features/authentication/presentation/view/user_detail_view.dart';

class AppRoute {
  AppRoute._();

  static const String signUpRoute = '/';
  static const String loginRoute = "/login";
  static const String userDerailRoute = "/userDetails";

  static getApplicationRoute() {
    return {
      signUpRoute: (context) => const SignUpView(),
      userDerailRoute: (context) => const UserDetailsView(),
      // loginRoute: (context) => const
      // batchStudentRoute: (context) => const BatchStudentView(null),
      // googleMapRoute: (context) => const GoogleMapView(),
    };
  }
}
