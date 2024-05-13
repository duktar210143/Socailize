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
    final ValueNotifier<String> title =
        // fetching list of title from homeState and changing as index from bottom navigation bar changes
        ValueNotifier(homeState.lstPageTitle[homeState.index]);
    // title value

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: title,
            builder: (BuildContext context, String value, _) {
              return Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            },
            child: Text(title.value,
                style: const TextStyle(
                    color: Color.fromARGB(255, 222, 104, 96),
                    fontFamily: 'lobster')),
          ),
          backgroundColor: Colors.transparent,
          // , // Adjust opacity as needed
          elevation: 0, // Remove the shadow
          iconTheme: const IconThemeData(
              color: Colors.transparent), // Hide the back arrow icon
        ),
        body: homeState.lstWidgets[homeState.index],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.question_answer,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              label: 'Questions',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              label: 'add new Question',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.portable_wifi_off_outlined,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              label: 'Location',
            ),
          ],
          currentIndex: homeState.index,
          onTap: (index) {
            setState(() {
              ref.read(homeViewModelProvider.notifier).changeIndex(index);
              title.value = homeState.lstPageTitle[index];
            });
          },
        ),
      ),
    );
  }
}
