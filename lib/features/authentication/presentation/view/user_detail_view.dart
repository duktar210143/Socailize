import 'dart:io';

import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailView extends ConsumerStatefulWidget {
  const UserDetailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends ConsumerState<UserDetailView> {
  File? _image;

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _image = File(image.path);
          ref.read(authViewModelProvider.notifier).uploadprofile(_image!);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      _browseImage(ImageSource.gallery);
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            const Divider(),
            const ListTile(
              title: Text('questions',
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
