import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/question/domain/repository/question_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteQuestionUseCaseProvider =
    Provider.autoDispose<DeletequestionUsecase>((ref) {
  return DeletequestionUsecase(
      repository: ref.read(iQuestionRepositoryProvider));
});

class DeletequestionUsecase {
  final IQuestionRepository repository;

  DeletequestionUsecase({required this.repository});

  Future<Either<Failure, bool>> deleteQuestion(String questionId) {
    return repository.deleteQuestion(questionId);
  }
}
