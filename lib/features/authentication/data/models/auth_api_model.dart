import 'dart:io';

import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String firstname;
  final String lastname;
  final String username;
  final String password;
  final String? image;
  final String email;
  AuthApiModel({
    this.userId,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.password,
    this.image,
    required this.email,
  });

  AuthApiModel copyWith({
    String? userId,
    String? firstname,
    String? lastname,
    String? username,
    String? password,
    String? email,
    String? image
  }) {
    return AuthApiModel(
      userId: userId ?? this.userId,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      email: email ?? this.email,
      image: image ?? this.image,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'image':image,
      'password': password,
    };
  }

  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      image:json['image'] ?? '',
      password: json['password'] ?? '',
    );
  }

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      firstname: entity.firstname,
      lastname: entity.lastname,
      username: entity.username,
      email: entity.email,
      image: entity.image,
      password: entity.password,
    );
  }

  static AuthEntity toEntity(AuthApiModel model) {
    return AuthEntity(
      userId: model.userId,
      username: model.username,
      firstname: model.firstname,
      lastname: model.lastname,
      email: model.email,
      image: model.image,
      password: model.password,
    );
  }

  @override
  String toString() {
    return 'AuthApiModel(userId: $userId, firstname: $firstname, lastname: $lastname, username: $username, password: $password)';
  }
}
