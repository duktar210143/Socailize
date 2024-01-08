import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: "id")
  final String? userId;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String email;
  final String? uImage;
  AuthApiModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password,
    required this.email,
    required this.uImage,
  });

  AuthApiModel copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? userName,
    String? password,
    String? email,
    String? uImage,
  }) {
    return AuthApiModel(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      uImage: uImage ?? this.uImage,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'password': password,
      'uImage': uImage,
    };
  }

  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      uImage: json['uImage'],
    );
  }

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
        firstName: entity.firstName,
        lastName: entity.lastName,
        userName: entity.userName,
        email: entity.email,
        password: entity.password,
        uImage: entity.uImage);
  }

  static AuthEntity toEntity(AuthApiModel model) {
    return AuthEntity(
        userName: model.userName,
        firstName: model.firstName,
        lastName: model.lastName,
        email: model.email,
        password: model.password);
  }

  @override
  String toString() {
    return 'AuthApiModel(userId: $userId, firstName: $firstName, lastName: $lastName, userName: $userName, password: $password, uImage: $uImage)';
  }
}
