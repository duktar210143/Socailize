import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/domain/repository/question_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllQuestionsUseCaseProvider = Provider.autoDispose<GetAllQuestionsUseCase>(
  (ref) => GetAllQuestionsUseCase(
    repository: ref.read(iQuestionRepositoryProvider),
  ),
);

class GetAllQuestionsUseCase {
  final IQuestionRepository repository;

  GetAllQuestionsUseCase({required this.repository});

  Future<Either<Failure, List<QuestionEntity>>> getAllQuestions() async {
    return await repository.getAllQuestions();
  }
}
