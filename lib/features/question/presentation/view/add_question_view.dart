// import 'dart:io';

// import 'package:discussion_forum/core/common/widgets/list_question_widget.dart';
// import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
// import 'package:discussion_forum/features/question/presentation/view_model/question_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class AddQuestionView extends ConsumerStatefulWidget {
//   const AddQuestionView({Key? key}) : super(key: key);

//   @override
//   _AddQuestionViewState createState() => _AddQuestionViewState();
// }

// class _AddQuestionViewState extends ConsumerState {
//   final questionController = TextEditingController();
//   final descriptionController = TextEditingController();
//   File? _image;

//   Future<void> checkCameraPermission() async {
//     if (Platform.isIOS) {
//       if (await Permission.camera.request().isRestricted ||
//           await Permission.camera.request().isDenied) {
//         await Permission.camera.request();
//       }
//     } else if (Platform.isAndroid) {
//       // Android-specific permission handling
//       // Example:
//       if (await Permission.camera.request().isRestricted ||
//           await Permission.camera.request().isDenied) {
//         await Permission.camera.request();
//       }
//     }
//   }

//   Future<void> _browseImage(ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _image = File(image.path);
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   Widget _buildPreviewImage() {
//     return _image != null
//         ? Container(
//             width: double.infinity,
//             height: 200,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: FileImage(_image!),
//                 fit: BoxFit.cover,
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//           )
//         : Container();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final questionState = ref.watch(questionViewModelProvider);

//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 8),
//             const Align(
//               alignment: Alignment.center,
//               child: Text(
//                 'Add question',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             _buildPreviewImage(),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       await checkCameraPermission();
//                       await _browseImage(ImageSource.gallery);
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: WidgetStateProperty.all<Color>(
//                         Theme.of(context).colorScheme.secondary,
//                       ),
//                     ),
//                     child: Text(
//                       'Pick Image',
//                       style: TextStyle(
//                         color: Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             TextFormField(
//               controller: questionController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Add a caption if you want to',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter question';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () async {
//                 QuestionEntity question = QuestionEntity(
//                   question: questionController.text,
//                   questionImageUrl: _image?.path.split('/').last,
//                 );
//                 await ref
//                     .read(questionViewModelProvider.notifier)
//                     .addQuestions(question, _image);
//                 questionController.clear();
//                 descriptionController.clear();
//                 setState(() {
//                   _image = null;
//                 });
//               },
//               style: ButtonStyle(
//                 backgroundColor: WidgetStateProperty.all<Color>(
//                   Theme.of(context).colorScheme.secondary,
//                 ),
//               ),
//               child: Text(
//                 'Post',
//                 style: TextStyle(
//                   color: Theme.of(context).brightness == Brightness.dark
//                       ? Colors.white
//                       : Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             const SizedBox(height: 8),
//             questionState.isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListQuestionWidget(
//                     questionProvider: questionViewModelProvider,
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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

class _AddQuestionViewState extends ConsumerState<AddQuestionView> {
  final questionController = TextEditingController();
  File? _image;
  bool _isImageLoading = false;
  bool _isPosting = false;

  Future<void> checkCameraPermission() async {
    if (Platform.isIOS || Platform.isAndroid) {
      if (await Permission.camera.request().isRestricted ||
          await Permission.camera.request().isDenied) {
        await Permission.camera.request();
      }
    }
  }

  Future<File?> _browseImage(ImageSource imageSource) async {
    try {
      setState(() {
        _isImageLoading = true;
      });
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
    } finally {
      setState(() {
        _isImageLoading = false;
      });
    }
    return null;
  }

  Widget _buildPreviewImage() {
    if (_isImageLoading) {
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return _image != null
        ? AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _image = null;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  void _showAddPostModal() async {
    await checkCameraPermission();
    final File? image = await _browseImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
      _showCaptionAndShareModal();
    }
  }

  void _showCaptionAndShareModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        const Text(
                          'New Post',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: _isPosting
                              ? null
                              : () async {
                                  setModalState(() {
                                    _isPosting = true;
                                  });
                                  QuestionEntity question = QuestionEntity(
                                    question: questionController.text,
                                    questionImageUrl:
                                        _image?.path.split('/').last,
                                  );
                                  await ref
                                      .read(questionViewModelProvider.notifier)
                                      .addQuestions(question, _image);
                                  questionController.clear();
                                  setState(() {
                                    _image = null;
                                  });
                                  setModalState(() {
                                    _isPosting = false;
                                  });
                                  Navigator.pop(context);
                                },
                          child: _isPosting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Share',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildPreviewImage(),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: questionController,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write a caption...',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: questionState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListQuestionWidget(
                        questionProvider: questionViewModelProvider,
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPostModal,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
