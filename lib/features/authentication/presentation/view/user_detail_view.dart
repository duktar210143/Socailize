// import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class UserDetailView extends ConsumerWidget {
//   const UserDetailView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userState = ref.watch(authViewModelProvider);
//     return Column(
//       children: [
//         Text(
//           userState.userData.firstname,
//           style: const TextStyle(color: Colors.black, fontSize: 100),
//         )
//       ],
//     );
//   }
// }

import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailView extends ConsumerWidget {
  const UserDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        "${userState.userData.image}"), // Use the default profile image here
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${userState.userData.firstname} ${userState.userData.lastname}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '@${userState.userData.username}',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Implement edit profile functionality
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              title:
                  Text('questions', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text('10'), // Replace with actual number of posts
            ),
            const ListTile(
              title: Text('Replies',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text('200'), // Replace with actual number of followers
            ),
            const ListTile(
              title: Text('Following',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text('10'), // Replace with actual number of following
            ),
            const Divider(),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }
}
