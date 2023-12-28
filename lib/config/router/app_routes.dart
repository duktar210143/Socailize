import 'package:discussion_forum/features/authentication/presentation/view/signup_view.dart';

class AppRoute {
  AppRoute._();

  static const String signUpRoute = '/';

  static getApplicationRoute() {
    return {
      signUpRoute: (context) => const SignUpView(),
      // batchStudentRoute: (context) => const BatchStudentView(null),
      // googleMapRoute: (context) => const GoogleMapView(),
    };
  }
}
