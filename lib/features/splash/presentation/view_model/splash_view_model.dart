import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs _userSharedPrefs;
  SplashViewModel(this._userSharedPrefs) : super(null);

  init(BuildContext context) async {
    final data = await _userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) {
      if (token != null) {
        bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
          // We will not do navigation like this,
          // we will use mixin and navigator class for this
          Navigator.popAndPushNamed(context, AppRoute.loginRoute);
        } else {
          Navigator.popAndPushNamed(context, AppRoute.dashboard);
        }
      } else {
        Navigator.popAndPushNamed(context, AppRoute.loginRoute);
      }
    });
  }

  bool isValidToken(String token) {
  try {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // Check if the 'exp' field is present and not null
    if (decodedToken.containsKey('exp') && decodedToken['exp'] != null) {
      int expirationTimestamp = decodedToken['exp'];
      final currentDate = DateTime.now().millisecondsSinceEpoch;

      // If current date is greater than expiration timestamp then token is expired
      return currentDate > expirationTimestamp * 1000;
    } else {
      // If 'exp' field is not present or is null, consider the token as always valid
      return false;
    }
  } catch (e) {
    // Handle decoding errors (invalid token format, etc.)
    return false;
  }
}
}

