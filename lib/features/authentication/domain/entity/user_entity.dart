// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  List<Object> get props {
    return [
      userId ?? '',
      username,
      image ?? '',
      firstname,
      lastname,
      email,
      password,
    ];
  }


  factory AuthEntity.fromjson(Map<String, dynamic> json) {
    return AuthEntity(
        userId: json['userId'],
        username: json['username'],
        image: json['image'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "image": image,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
      };

  @override
  bool get stringify => true;
}
