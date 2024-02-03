import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/domain/repository/question_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllPublicQuestionUseCaseProvider =
    Provider.autoDispose<GetAllPublicQuestionUseCase>((ref) {
  return GetAllPublicQuestionUseCase(
      repository: ref.read(iQuestionRepositoryProvider));
});

class GetAllPublicQuestionUseCase {
  final IQuestionRepository repository;

  GetAllPublicQuestionUseCase({required this.repository});

  Future<Either<Failure, List<QuestionEntity>>>
      getAllPublicUserQuestions() async {
    return await repository.getAllPublicUserQuestions();
  }
}
