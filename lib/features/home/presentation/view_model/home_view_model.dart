import 'package:discussion_forum/features/home/presentation/state/home_widget_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) => HomeViewModel());

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState.initialState());

  void changeIndex(int index) {
    state = state.copywith(index: index);
  }

  // void signOut(BuildContext context) {
  //   Navigator.pushReplacement(context, AppRoute.loginRoute);
  // }
}
