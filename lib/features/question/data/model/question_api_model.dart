import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class QuestionApiModel {
  @JsonKey(name: '_id')
  // Server ko name lai batchId sanga map gareko
  final String? questionId;
  // J name server ma cha tei name ya lekhne
  final String question;

  final String? questionDescription;

  final String? questionCategory;

  final String? questionImageUrl;

  QuestionApiModel(
      {this.questionId,
      required this.question,
      this.questionDescription,
      this.questionCategory,
      this.questionImageUrl});

  // To Json and fromJson without freezed
  factory QuestionApiModel.fromJson(Map<String, dynamic> json) {
    return QuestionApiModel(
        questionId: json['_id'],
        question: json['question'],
        questionCategory: json['questionCategory'],
        questionDescription: json['questionDescription'],
        questionImageUrl: json['questionImageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': questionId,
      'question': question,
      'questionCategory': questionCategory,
      'questionDescription': questionDescription,
      'questionImageUrl': questionImageUrl,
    };
  }

  // From entity to model
  factory QuestionApiModel.fromEntity(QuestionEntity entity) {
    return QuestionApiModel(
      questionId: entity.questionId,
      question: entity.question,
      questionCategory: entity.questionCategory,
      questionDescription: entity.questionDescription,
      questionImageUrl: entity.questionImageUrl,
    );
  }

  // From model to entity
  static QuestionEntity toEntity(QuestionApiModel model) {
    return QuestionEntity(
        questionId: model.questionId,
        question: model.question,
        questionCategory: model.questionCategory,
        questionDescription: model.questionDescription,
        questionImageUrl: model.questionImageUrl);
  }
}
