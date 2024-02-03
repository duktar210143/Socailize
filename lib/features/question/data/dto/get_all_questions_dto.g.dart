// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_questions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllQuestionsDto _$GetAllQuestionsDtoFromJson(Map<String, dynamic> json) =>
    GetAllQuestionsDto(
      success: json['success'] as bool,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllQuestionsDtoToJson(GetAllQuestionsDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questions,
    };
