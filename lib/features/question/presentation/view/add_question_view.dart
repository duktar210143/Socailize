import 'dart:io';

import 'package:discussion_forum/core/common/widgets/list_question_widget.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/presentation/view_model/question_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddQuestionView extends ConsumerStatefulWidget {
  const AddQuestionView({Key? key}) : super(key: key);

  @override
  _AddQuestionViewState createState() => _AddQuestionViewState();
}

class _AddQuestionViewState extends ConsumerState {
  final questionController = TextEditingController();
  final descriptionController = TextEditingController();
  File? _image;

  Future<void> checkCameraPermission() async {
    if (Platform.isIOS) {
      if (await Permission.camera.request().isRestricted ||
          await Permission.camera.request().isDenied) {
        await Permission.camera.request();
      }
    } else if (Platform.isAndroid) {
      // Android-specific permission handling
      // Example:
      if (await Permission.camera.request().isRestricted ||
          await Permission.camera.request().isDenied) {
        await Permission.camera.request();
      }
    }
  }

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _buildPreviewImage() {
    return _image != null
        ? Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(_image!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionViewModelProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Add question',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: questionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ask a Question',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter question';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Question Description',
              ),
            ),
            const SizedBox(height: 8),
            _buildPreviewImage(),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await checkCameraPermission();
                      await _browseImage(ImageSource.gallery);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Text(
                      'Pick Image',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                QuestionEntity question = QuestionEntity(
                  question: questionController.text,
                  questionDescription: descriptionController.text,
                  questionImageUrl: _image?.path.split('/').last,
                );
                await ref
                    .read(questionViewModelProvider.notifier)
                    .addQuestions(question, _image);
                questionController.clear();
                descriptionController.clear();
                setState(() {
                  _image = null;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: Text(
                'Add question',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            questionState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListQuestionWidget(
                    questionProvider: questionViewModelProvider,
                  ),
          ],
        ),
      ),
    );
  }
}
