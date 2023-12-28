import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String userName;
  final String? uImage;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const UserEntity({
     this.userId,
    required this.userName,
    this.uImage,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  UserEntity copyWith({
    String? userId,
    String? userName,
    String? uImage,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      uImage: uImage ?? this.uImage,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [userName, firstName, lastName, email, password];
}
