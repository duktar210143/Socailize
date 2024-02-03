import 'dart:io';

import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String username;
  final String? image;
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  const AuthEntity({
    this.userId,
    required this.username,
    this.image,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });

  AuthEntity copyWith({
    String? userId,
    String? username,
    String? image,
    String? firstname,
    String? lastname,
    String? email,
    String? password,
  }) {
    return AuthEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      image: image ?? this.image,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [userId,username, firstname, lastname, password];
}
