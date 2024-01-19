import 'package:discussion_forum/features/authentication/domain/use_case/user_details_usecase.dart';
import 'package:discussion_forum/features/authentication/presentation/state/user_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDetailsViewModelProvider =
    StateNotifierProvider<UserDetailsViewModel, UserDetailState>((ref) {
  final userDetailUseCase = ref.read(userDetailUseCaseProvider);
  return UserDetailsViewModel(userDetailUseCase);
});

class UserDetailsViewModel extends StateNotifier<UserDetailState> {
  final UserDetailUseCase _userDetailUseCase;

  UserDetailsViewModel(
    this._userDetailUseCase,
  ) : super(
          UserDetailState.initial(),
        ) {
    getAllUsers();
  }

   Future resetState() async {
    state = UserDetailState.initial();
    getAllUsers();
  }

  Future getAllUsers() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final users = currentState.users;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await _userDetailUseCase.getUserDetails(page);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              users: [...users, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}
