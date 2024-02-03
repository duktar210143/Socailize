import 'dart:async';

import 'package:discussion_forum/core/common/widgets/user_card.dart';
import 'package:discussion_forum/features/authentication/presentation/view_model/userdetail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailsView extends ConsumerStatefulWidget {
  const UserDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserDetailsViewState();
}

class _UserDetailsViewState extends ConsumerState<UserDetailsView> {
  final ScrollController _scrollController = ScrollController();
  bool _showNoMoreDataDialog = false;
  Timer? _timer;
  double _initialScrollPosition = 0.0;

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userDetailsViewModelProvider);

    // Show dialog after 5 seconds of continuous loading
    if (state.isLoading && !_showNoMoreDataDialog) {
      // Store the initial scroll position
      _initialScrollPosition = _scrollController.position.pixels;

      // Cancel the existing timer if it's active
      _timer?.cancel();

      _timer = Timer(const Duration(seconds: 5), () {
        // Check if the scroll position has changed during the 5 seconds
        if (_scrollController.position.pixels == _initialScrollPosition &&
            state.isLoading) {
          _showNoMoreDataDialog = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('No More Data'),
                content: const Text('There are no more data to load.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      _showNoMoreDataDialog = false;
                      _timer?.cancel();
                      ref
                          .read(userDetailsViewModelProvider.notifier)
                          .resetState();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    }

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          // Scroll garda feri last ma ho ki haina bhanera check garne ani data call garne
          if (_scrollController.position.extentAfter == 0) {
            // Data fetch gara api bata
            ref.read(userDetailsViewModelProvider.notifier).getAllUsers();
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discussion Forum',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _timer?.cancel();
                ref.read(userDetailsViewModelProvider.notifier).resetState();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: RefreshIndicator(
          // Yo chai pull to refresh ko lagi ho
          color: Colors.red,
          onRefresh: () async {
            _timer?.cancel();
            ref.read(userDetailsViewModelProvider.notifier).resetState();
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  separatorBuilder: (context, index) => const Divider(),
                  controller: _scrollController,
                  itemCount: state.users.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final users = state.users[index];
                    return UserCard(
                        name: users.firstname,
                        email: users.email,
                        avatarInitial: users.firstname[0]);
                  },
                ),
              ),
              // Data load huda feri progress bar dekhaune natra banda garne
              if (state.isLoading)
                const CircularProgressIndicator(color: Colors.red),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
