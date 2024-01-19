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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userDetailsViewModelProvider);
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
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'Discussion Forum',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
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
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        child: Text(
                          users.firstname[0],
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      title: Text(
                        '${users.firstname} ${users.lastname}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(users.email),
                    );
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
