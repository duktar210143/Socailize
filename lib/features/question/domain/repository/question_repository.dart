import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/question/data/repository/question_remote_repo_impl.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final iQuestionRepositoryProvider = Provider.autoDispose<IQuestionRepository>(
  (ref) {
    // internet chaina bhane local bata tana
    return ref.read(questionRemoteRepositoryImplProvider);
  },
);

// abstract class to define features
abstract class IQuestionRepository {
// set question repo
  Future<Either<Failure, bool>> addQuestions(
      QuestionEntity question, File? image);

//get userSpecific questions Repo
  Future<Either<Failure, List<QuestionEntity>>> getAllQuestions();

//get every users questions Repo
  Future<Either<Failure, List<QuestionEntity>>> getAllPublicUserQuestions();

  // delete specific question Repo
  Future<Either<Failure, bool>> deleteQuestion(String questionId);
}
