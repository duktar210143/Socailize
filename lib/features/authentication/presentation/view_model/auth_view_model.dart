// import 'dart:io';

// import 'package:discussion_forum/config/router/app_routes.dart';
// import 'package:discussion_forum/core/common/snackbar/my_snack_bar.dart';
// import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
// import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
// import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
// import 'package:discussion_forum/features/authentication/domain/use_case/login_usecase.dart';
// import 'package:discussion_forum/features/authentication/presentation/state/auth_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

// final authViewModelProvider =
//     StateNotifierProvider.autoDispose<AuthViewModel, AuthState>(
//   (ref) {
//     return AuthViewModel(
//         authUseCase: ref.read(authUseCaseProvider),
//         loginUseCase: ref.read(loginUseCaseProvider),
//         userSharedPrefs: ref.read(userSharedPrefsProvider));
//   },
// );

// class AuthViewModel extends StateNotifier<AuthState> {
//   final AuthUseCase authUseCase;
//   final LoginUseCase loginUseCase;
//   final UserSharedPrefs userSharedPrefs;

//   AuthViewModel({
//     required this.authUseCase,
//     required this.loginUseCase,
//     required this.userSharedPrefs,
//   }) : super(AuthState.initialState()) {
//     getUserData();
//   }

//   Future<void> signUpUser(BuildContext context, AuthEntity user) async {
//     state = state.copyWith(isLoading: true);
//     var data = await authUseCase.signUpUser(user);
//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         showSnackBar(
//             color: Colors.red, message: failure.error, context: context);
//       },
//       (success) {
//         state = state.copyWith(isLoading: false, error: null);
//         showSnackBar(message: "Registered successfully", context: context);
//         Navigator.pushNamed(context, AppRoute.loginRoute);
//       },
//     );
//   }

//   Future<void> uploadProfile(File image) async {
//     state = state.copyWith(isLoading: true);
//     var data = await authUseCase.uploadProfile(image);
//     data.fold((failure) {
//       return state = state.copyWith(isLoading: false, error: failure.error);
//     }, (user) {
//       return state = state.copyWith(isLoading: false, userData: user);
//     });
//   }

// Future<void> updateStreamChatProfile(BuildContext context, String imageUrl) async {
//   state = state.copyWith(isLoading: true);

//   try {
//     // Get the Stream Chat client
//     final client = StreamChatCore.of(context).client;

//     // Create a new user object with updated information
//     final updatedUser = User(
//       id: state.userData.username, // Assuming username as ID
//       extraData: {
//         'name': state.userData.username,
//         'image': imageUrl, // Use the uploaded image URL here
//       },
//     );

//     // Update the user, which will also handle the image URL update
//     final response = await client.updateUser(updatedUser);

//     // The response might not have a direct user property, so we need to check the users map
//     final updatedUserData = response.users[state.userData.username];
//     if (updatedUserData == null || updatedUserData.image == null) {
//       throw Exception('Failed to update user image');
//     }

//     // Update local state
//     state = state.copyWith(
//       isLoading: false,
//       userData: state.userData.copyWith(image: updatedUserData.image),
//     );

//     // Refresh the user data in your app if needed
//     getUserData();
//   } catch (e) {
//     state = state.copyWith(isLoading: false, error: e.toString());
//     print('Error updating Stream Chat profile: $e');
//     throw e; // Optionally rethrow the error for handling in the UI
//   }
// }
//   Future<bool> signInUser(BuildContext context, String userName, String password) async {
//     bool isLogin = false;
//     state = state.copyWith(isLoading: true);

//     var data = await loginUseCase.login(userName, password);
//     data.fold((failure) {
//       state = state.copyWith(isLoading: false, error: failure.error);
//       showSnackBar(message: failure.error, context: context, color: Colors.red);
//     }, (success) async {
//       print("Login success data ${success.userData}");
//       state = state.copyWith(isLoading: false, error: null, userData: success.userData);
//       isLogin = true;

//       // Save token and user data to SharedPreferences
//       await userSharedPrefs.setUserToken(success.token);
//       await userSharedPrefs.setUserData(success.userData);

//       // Connect user to Stream Chat
//       final client = StreamChatCore.of(context).client;
//       try {
//         await client.connectUser(
//           User(
//             id: success.userData.username,  // Assuming username as ID
//             extraData: {
//               'name': success.userData.username,
//               'image': success.userData.image,
//             },
//           ),
//           client.devToken(success.userData.username).rawValue,
//         );
//         Navigator.pushNamed(context, AppRoute.dashboard);
//       } catch (e) {
//         showSnackBar(message: 'Could not connect user to chat', context: context, color: Colors.red);
//       }
//     });

//     return isLogin;
//   }

//   void getUserData() {
//     state = state.copyWith(isLoading: true);
//     authUseCase.getUserData().then((value) {
//       value.fold((failure) {
//         return state = state.copyWith(isLoading: false);
//       }, (authEntity) {
//         return state = state.copyWith(isLoading: false, userData: authEntity);
//       });
//     });
//   }

//   Future<void> logout(BuildContext context) async {
//     state = state.copyWith(isLoading: true);
//     await loginUseCase.logout();
//     await userSharedPrefs.deleteUserToken();
//     await userSharedPrefs.deleteUserData();

//     // Disconnect user from Stream Chat
//     final client = StreamChatCore.of(context).client;
//     await client.disconnectUser();

//     Navigator.pushNamed(context, AppRoute.loginRoute);
//     showSnackBar(message: 'Logged out', context: context, color: Colors.green);
//   }

//   Future<void> resetPass(BuildContext context, String email) async {
//     state = state.copyWith(isLoading: true);
//     final data = await loginUseCase.forgotPassword(email);
//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         showSnackBar(
//             message: failure.error, context: context, color: Colors.red);
//       },
//       (success) {
//         state = state.copyWith(isLoading: false, error: null);
//         showSnackBar(
//             message: "OTP sent successfully, check your email",
//             context: context,
//             color: Colors.green);
//         Navigator.pushNamed(context, AppRoute.loginRoute);
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/core/common/snackbar/my_snack_bar.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/login_usecase.dart';
import 'package:discussion_forum/features/authentication/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

final authViewModelProvider =
    StateNotifierProvider.autoDispose<AuthViewModel, AuthState>(
  (ref) {
    return AuthViewModel(
        authUseCase: ref.read(authUseCaseProvider),
        loginUseCase: ref.read(loginUseCaseProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider));
  },
);

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;
  final LoginUseCase loginUseCase;
  final UserSharedPrefs userSharedPrefs;

  AuthViewModel({
    required this.authUseCase,
    required this.loginUseCase,
    required this.userSharedPrefs,
  }) : super(AuthState.initialState()) {
    getUserData();
  }

  Future<void> signUpUser(BuildContext context, AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.signUpUser(user);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            color: Colors.red, message: failure.error, context: context);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "Registered successfully", context: context);
        Navigator.pushNamed(context, AppRoute.loginRoute);
      },
    );
  }

  Future<String> uploadProfile(File image) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.uploadProfile(image);
    return data.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      throw Exception('Failed to upload profile image');
    }, (authEntity) {
      state = state.copyWith(isLoading: false);
      return state.userData.image!; // Extract image URL from userData in state
    });
  }

  Future<void> updateStreamChatProfile(
      BuildContext context, String imageUrl) async {
    state = state.copyWith(isLoading: true);

    try {
      // Get the Stream Chat client
      final client = StreamChatCore.of(context).client;

      // Create a new user object with updated information
      final updatedUser = User(
        id: state.userData.username, // Assuming username as ID
        extraData: {
          'name': state.userData.username,
          'image': imageUrl, // Use the uploaded image URL here
        },
      );

      // Update the user, which will also handle the image URL update
      final response = await client.updateUser(updatedUser);

      // The response might not have a direct user property, so we need to check the users map
      final updatedUserData = response.users[state.userData.username];
      if (updatedUserData == null || updatedUserData.image == null) {
        throw Exception('Failed to update user image');
      }

      // Update local state
      state = state.copyWith(
        isLoading: false,
        userData: state.userData.copyWith(image: updatedUserData.image),
      );

      // Refresh the user data in your app if needed
      getUserData();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      print('Error updating Stream Chat profile: $e');
      rethrow; // Optionally rethrow the error for handling in the UI
    }
  }

  Future<bool> signInUser(
      BuildContext context, String userName, String password) async {
    bool isLogin = false;
    state = state.copyWith(isLoading: true);

    var data = await loginUseCase.login(userName, password);
    data.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showSnackBar(message: failure.error, context: context, color: Colors.red);
    }, (success) async {
      print("Login success data ${success.userData}");
      state = state.copyWith(
          isLoading: false, error: null, userData: success.userData);
      isLogin = true;

      // Save token and user data to SharedPreferences
      await userSharedPrefs.setUserToken(success.token);
      await userSharedPrefs.setUserData(success.userData);

      // Connect user to Stream Chat
      final client = StreamChatCore.of(context).client;
      try {
        await client.connectUser(
          User(
            id: success.userData.username, // Assuming username as ID
            extraData: {
              'name': success.userData.username,
              'image': success.userData.image,
            },
          ),
          client.devToken(success.userData.username).rawValue,
        );
        Navigator.pushNamed(context, AppRoute.dashboard);
      } catch (e) {
        showSnackBar(
            message: 'Could not connect user to chat',
            context: context,
            color: Colors.red);
      }
    });

    return isLogin;
  }

  void getUserData() {
    state = state.copyWith(isLoading: true);
    authUseCase.getUserData().then((value) {
      value.fold((failure) {
        return state = state.copyWith(isLoading: false);
      }, (authEntity) {
        return state = state.copyWith(isLoading: false, userData: authEntity);
      });
    });
  }

  Future<void> logout(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    await loginUseCase.logout();
    await userSharedPrefs.deleteUserToken();
    await userSharedPrefs.deleteUserData();

    // Disconnect user from Stream Chat
    final client = StreamChatCore.of(context).client;
    await client.disconnectUser();

    Navigator.pushNamed(context, AppRoute.loginRoute);
    showSnackBar(message: 'Logged out', context: context, color: Colors.green);
  }

  Future<void> resetPass(BuildContext context, String email) async {
    state = state.copyWith(isLoading: true);
    final data = await loginUseCase.forgotPassword(email);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
            message: "OTP sent successfully, check your email",
            context: context,
            color: Colors.green);
        Navigator.pushNamed(context, AppRoute.loginRoute);
      },
    );
  }
}
