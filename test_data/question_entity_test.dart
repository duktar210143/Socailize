import 'dart:convert';

import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:flutter/services.dart';

Future<List<QuestionEntity>> getAllQuestions() async {
  final response =
      await rootBundle.loadString('test_data/question_test_data.json');
  final jsonList = await json.decode(response);
  final List<QuestionEntity> questionList = jsonList
      .map<QuestionEntity>((json) => QuestionEntity.fromJson(json))
      .toList();
  return Future.value(questionList);
}
