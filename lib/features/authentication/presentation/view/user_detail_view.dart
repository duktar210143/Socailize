import 'dart:io';

import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:discussion_forum/features/question/presentation/view_model/public_question_view_model.dart';
import 'package:discussion_forum/features/question/presentation/view_model/question_view_model.dart';
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
        setState(() async {
          _image = File(image.path);
          await ref.read(authViewModelProvider.notifier).uploadprofile(_image!);
          ref.read(questionViewModelProvider.notifier).getAllQuestions();
          ref
              .read(publicQuestionViewModelProvider.notifier)
              .getAllPublicUserQuestions();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
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
                        userState.userData.firstname,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '@${userState.userData.username}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondary,
                        )),
                        onPressed: () {
                          _browseImage(ImageSource.gallery);
                        },
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
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
                  trailing:
                      Text('200'), // Replace with actual number of followers
                ),
                const ListTile(
                  title: Text('Following',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing:
                      Text('10'), // Replace with actual number of following
                ),
                const Divider(),
                // Add more sections as needed
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary,
                )),
                onPressed: () async {
                  ref.read(authViewModelProvider.notifier).logout(context);
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
