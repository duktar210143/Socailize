import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;
  // Set user token
  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get user token
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return right(token);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete token
  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> setUserData(AuthEntity userData) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // Convert AuthEntity to a Map<String, dynamic>
      final userMap = userData.toJson();

      // Convert the Map to a JSON string
      final userJson = json.encode(userMap);

      // Store the JSON string in SharedPreferences
      await _sharedPreferences.setString('userData', userJson);

      return right(true);
    } catch (e) {
      print('Error storing user data: $e'); // Add this line
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, AuthEntity?>> getUserData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final userJson = _sharedPreferences.getString('userData');
      print("get User Json" + "$userJson");

      if (userJson != null) {
        // Check if userJson is a String
        if (userJson is String) {
          // Decode the JSON string to a Map<String, dynamic>
          final userMap = json.decode(userJson);

          // Convert the Map to an AuthEntity
          final userData = AuthEntity.fromjson(userMap);

          print('User data retrieved from SharedPreferences: $userJson');

          return right(userData);
        } else {
          print('Error: User data is not a valid JSON string');
          return left(Failure(error: 'Invalid user data format'));
        }
      } else {
        print('No user data found in SharedPreferences');
        return right(null);
      }
    } catch (e) {
      print('Error retrieving user data: $e');
      return left(Failure(error: e.toString()));
    }
  }
}
