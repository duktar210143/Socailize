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

abstract class IQuestionRepository {
  Future<Either<Failure, bool>> addQuestions(QuestionEntity question, File? image);
}
