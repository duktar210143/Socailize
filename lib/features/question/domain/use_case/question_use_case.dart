import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/domain/repository/question_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addQuestionUseCaseProvider = Provider.autoDispose<AddQuestionUseCase>(
  (ref) => AddQuestionUseCase(
    repository: ref.read(iQuestionRepositoryProvider),
  ),
);

class AddQuestionUseCase {
  final IQuestionRepository repository;

  AddQuestionUseCase({required this.repository});

  Future<Either<Failure, bool>> addQuestion(QuestionEntity question, File? file) async {
    return await repository.addQuestions(question, file);

    // shared preferences ko code or some other logic
  }
}
