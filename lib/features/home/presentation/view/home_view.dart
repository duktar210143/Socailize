import 'package:discussion_forum/features/home/presentation/state/home_widget_state.dart';
import 'package:discussion_forum/features/home/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    return SafeArea(
      child: Scaffold(
        body: homeState.lstWidgets[homeState.index],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard,color: Colors.black,),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer,color: Colors.black,),
              label: 'Questions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.black,),
              label: 'add new Question',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.black,),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.portable_wifi_off_outlined,color: Colors.black,),
              label: 'Location',
            ),
          ],
          currentIndex: homeState.index,
          onTap: (index) {
            setState(() {
              ref.read(homeViewModelProvider.notifier).changeIndex(index);
            });
          },
        ),
      ),
    );
  }
}
