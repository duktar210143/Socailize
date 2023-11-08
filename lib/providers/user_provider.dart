import 'dart:convert';

import 'package:discussion_forum/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// provider with state and notifier
final userStateProvider =
    StateNotifierProvider<UserStateNotifier, UserModel>((ref) {
  return UserStateNotifier();
});

// Notifier with methods to change the state and notify the consumer
class UserStateNotifier extends StateNotifier<UserModel> {
  UserStateNotifier()
      : super(
          UserModel(email: 'error', password: 'error'),
        );

  // Post request to api end point to register a User
  Future<void> signUp(String email, String password) async {
    final apiUrl = Uri.parse('http://localhost:1337/api/signup');

    try {
      final request = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (request.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(request.body);

        if (responseBody is Map<String, dynamic>) {
          final String userEmail = responseBody['email']?.toString() ?? '';
          final String userPassword =
              responseBody['password']?.toString() ?? '';

          if (userEmail.isNotEmpty && userPassword.isNotEmpty) {
            final UserModel newUser = UserModel(
              email: userEmail,
              password: userPassword,
            );

            state = newUser; // Update the state with the new user data

            // Now print the newUser
            print(state);
          } else {
            // Handle the case where some values are empty
            print('Some user data is empty in the API response');
            // You can handle this situation according to your app's logic
          }
        } else {
          // Handle the case where the user data is not provided in the response
          print('User data is missing in the API response');
          // You can handle this situation according to your app's logic
        }
      } else {
        // Handle HTTP errors
        print('HTTP Error: ${request.statusCode}');
        // You can handle specific HTTP status codes here, e.g., 404, 500, etc.
      }
    } catch (error) {
      // Handle general errors, such as network issues or unexpected exceptions
      print('Error: $error');
      // You can provide appropriate error messages or UI feedback to the user
    }
  }

  // Post request to login a registered User
  Future<bool> login(String email, String password) async {
    final apiUrl = Uri.parse('http://localhost:1337/api/login');

    try {
      final request = await http.post(
        apiUrl,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      if (request.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(request.body);

        if (responseBody is Map<String, dynamic>) {
          // fetch the token from the backend apiEndPoint
          final String token = responseBody['user']?.toString() ?? '';

          // if the token exist store it in the shared_preference
          if (token.isNotEmpty) {
            // Store the token in shared_preferences
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('token', token);

            final String userEmail = responseBody['email']?.toString() ?? '';
            final String userPassword =
                responseBody['password']?.toString() ?? '';

            if (userEmail.isNotEmpty && userPassword.isNotEmpty) {
              final UserModel newUser = UserModel(
                email: userEmail,
                password: userPassword,
              );

              state = newUser; // Update the state with the new user data

              // Now print the newUser
              print(state);
            } else {
              // Handle the case where some values are empty
              print('Some user data is empty in the API response');
              // You can handle this situation according to your app's logic
            }

            return true;
          } else {
            // Handle the case where the token is empty
            print('Token is empty in the API response');
            return false;
          }
        } else {
          // Handle the case where the user data is not provided in the response
          print('User data is missing in the API response');
          // You can handle this situation according to your app's logic
          return false;
        }
      } else {
        // Handle HTTP errors
        print('HTTP Error: ${request.statusCode}');
        // You can handle specific HTTP status codes here, e.g., 404, 500, etc.
        return false;
      }
    } catch (error) {
      // Handle general errors, such as network issues or unexpected exceptions
      print('Error: $error');
      // You can provide appropriate error messages or UI feedback to the user
      return false;
    }
  }
}
