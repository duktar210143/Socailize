import 'dart:convert';

import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:flutter/services.dart';
Future<List<QuestionEntity>> getAllQuestionsList() async {
  try {
    final jsonString =
        await rootBundle.loadString('test_data/question_test_data.json');
    final dynamic jsonValue = json.decode(jsonString);
    
    List<dynamic> jsonList;
    if (jsonValue is List) {
      jsonList = jsonValue;
    } else if (jsonValue is Map) {
      jsonList = [jsonValue];
    } else {
      throw FormatException('Invalid JSON format');
    }

    
    final List<QuestionEntity> questionList = jsonList
        .map<QuestionEntity>((json) => QuestionEntity.fromJson(json))
        .toList();
    
    return questionList;
  } catch (e) {
    print('Error loading or parsing JSON: $e');
    return [];
  }
}



