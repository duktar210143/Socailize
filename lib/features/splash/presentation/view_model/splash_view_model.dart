import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

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
    final tokenResult = await _userSharedPrefs.getUserToken();
    final userDataResult = await _userSharedPrefs.getUserData();

    tokenResult.fold((l) => Navigator.popAndPushNamed(context, AppRoute.loginRoute), (token) {
      userDataResult.fold((l) => Navigator.popAndPushNamed(context, AppRoute.loginRoute), (userData) {
        if (token != null && userData != null) {
          bool isTokenExpired = isValidToken(token);
          if (!isTokenExpired) {
            _connectUserToStreamChat(context, userData);
            Navigator.popAndPushNamed(context, AppRoute.dashboard);
          } else {
            Navigator.popAndPushNamed(context, AppRoute.loginRoute);
          }
        } else {
          Navigator.popAndPushNamed(context, AppRoute.loginRoute);
        }
      });
    });
  }

  bool isValidToken(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      if (decodedToken.containsKey('exp') && decodedToken['exp'] != null) {
        int expirationTimestamp = decodedToken['exp'];
        final currentDate = DateTime.now().millisecondsSinceEpoch;

        return currentDate < expirationTimestamp * 1000;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void _connectUserToStreamChat(BuildContext context, AuthEntity userData) async {
    final client = StreamChatCore.of(context).client;
    try {
      await client.connectUser(
        User(
          id: userData.username,
          extraData: {
            'name': userData.username,
            'image': userData.image,
          },
        ),
        client.devToken(userData.username).rawValue,
      );
    } catch (e) {
      // Handle connection errors if necessary
    }
  }
}