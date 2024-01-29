import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/presentation/view_model/question_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddQuestionView extends ConsumerStatefulWidget {
  const AddQuestionView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddQuestionViewState();
}


class _AddQuestionViewState extends ConsumerState {
  final gap = const SizedBox(height: 8);
  final questionController = TextEditingController();
  final descriptionController = TextEditingController();

  File? _image;

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future _browseImage(ImageSource imageSource) async {
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

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionViewModelProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gap,
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
            gap,
            TextFormField(
              controller: questionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Question Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter question';
                }
                return null;
              },
            ),
            gap,
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Question Description',
              ),
            ),
            gap,
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      checkCameraPermission();
                      await _browseImage(ImageSource.gallery);
                    },
                    child: const Text('Pick Image'),
                  ),
                ),
                gap,
                // Display the selected image here if needed
                _image != null
                    ? Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      )
                    : Container(),
              ],
            ),
            gap,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  QuestionEntity question = QuestionEntity(
                    question: questionController.text,
                    questionDescription: descriptionController.text,
                    questionImage: _image?.path.split('/').last, // Include image path in the entity
                  );
                  ref.read(questionViewModelProvider.notifier).addQuestions(question, _image);
                },
                child: const Text('Add question'),
              ),
            ),
            gap,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'List of questions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gap,
            questionState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: questionState.questions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            questionState.questions[index].question,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            questionState.questions[index].questionId ?? 'No id',
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 12,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // ref
                              //     .read(questionViewModelProvider.notifier)
                              //     .deletequestion(
                              //         questionState.questiones[index].questionId);
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
