import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/domain/use_case/delete_question_use_case.dart';
import 'package:discussion_forum/features/question/domain/use_case/get_all_questions_usecase.dart';
import 'package:discussion_forum/features/question/domain/use_case/question_use_case.dart';
import 'package:discussion_forum/features/question/presentation/view_model/question_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/question_entity_test.dart';
import 'question_mock_unit_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<GetAllQuestionsUseCase>(),
    MockSpec<AddQuestionUseCase>(),
    MockSpec<DeletequestionUsecase>(),
  ],
)
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late AddQuestionUseCase mockAddQuestionUseCase;
  late GetAllQuestionsUseCase mockGetAllQuestionUseCase;
  late DeletequestionUsecase mockDeleteQuestionUseCase;
  late List<QuestionEntity> lstQuestions;

  setUpAll(() async {
    mockGetAllQuestionUseCase = MockGetAllQuestionsUseCase();
    mockAddQuestionUseCase = MockAddQuestionUseCase();
    mockDeleteQuestionUseCase = MockDeletequestionUsecase();
    lstQuestions = await getAllQuestionsList();
    when(mockGetAllQuestionUseCase.getAllQuestions()).thenAnswer(
      (realInvocation) => Future.value(
        Right(lstQuestions),
      ),
    );
    container = ProviderContainer(overrides: [
      questionViewModelProvider.overrideWith((ref) => QuestionViewModel(
          addQuestionUseCase: mockAddQuestionUseCase,
          getAllQuestionsUseCase: mockGetAllQuestionUseCase,
          deletequestionUsecase: mockDeleteQuestionUseCase))
    ]);
  });

  test('check initial state', () {
    final questionState = container.read(questionViewModelProvider);

    expect(questionState.questions, isEmpty);
  });

  test('check for the length of the question in getALlQuestion UseCase',
      () async {
    when(mockGetAllQuestionUseCase.getAllQuestions()).thenAnswer(
      (realInvocation) => Future.value(
        Right(lstQuestions),
      ),
    );

    await container.read(questionViewModelProvider.notifier).getAllQuestions();

    final questionState = container.read(questionViewModelProvider);

    expect(questionState.questions, isNotEmpty);
  });

  test('add question test', () async {
    when(
      mockAddQuestionUseCase.addQuestion(lstQuestions[0], null),
    ).thenAnswer((realInvocation) => Future.value(const Right(true)));

    await container
        .read(questionViewModelProvider.notifier)
        .addQuestions(lstQuestions[0], null);

    final questionState = container.read(questionViewModelProvider);

    expect(questionState.error, '');
  });


    test('failed add question test', () async {
    when(
      mockAddQuestionUseCase.addQuestion(lstQuestions[0], null),
    ).thenAnswer((realInvocation) => Future.value(Left(Failure(error: 'try again'))));

    await container
        .read(questionViewModelProvider.notifier)
        .addQuestions(lstQuestions[0], null);

    final questionState = container.read(questionViewModelProvider);

    expect(questionState.error, 'try again');
  });
}
