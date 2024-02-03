import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/question/data/data_source/question_remote_data_source.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/domain/repository/question_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionRemoteRepositoryImplProvider =
    Provider.autoDispose<IQuestionRepository>(
  (ref) => QuestionRemoteRepoImpl(
    questionRemoteDataSource: ref.read(questionRemoteDatasourceProvider),
  ),
);

class QuestionRemoteRepoImpl implements IQuestionRepository {
  final QuestionRemoteDataSource questionRemoteDataSource;

  const QuestionRemoteRepoImpl({required this.questionRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addQuestions(
      QuestionEntity question, File? file) {
    // TODO: implement addQuestions
    return questionRemoteDataSource.addQuestions(question, file);
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> getAllQuestions() {
    // TODO: implement getAllQuestions
    return questionRemoteDataSource.getAllQuestions();
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> getAllPublicUserQuestions() {
    // TODO: implement getAllPublicUserQuestions
    return questionRemoteDataSource.getAllPublicUserQuestions();
  }
}
