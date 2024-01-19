import 'package:discussion_forum/features/authentication/data/models/auth_api_model.dart';

class UserDetailState {
  final List<AuthApiModel> users;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  UserDetailState({
    required this.users,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory UserDetailState.initial() {
    return UserDetailState(
      users: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  UserDetailState copyWith({
    List<AuthApiModel>? users,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return UserDetailState(
      users:  users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
