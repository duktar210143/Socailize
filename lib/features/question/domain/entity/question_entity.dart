import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String? questionId;
  final String question;
  final String? questionCategory;
  final String? questionDescription;
  final String? questionImageUrl;

  @override
  List<Object?> get props => [questionId, question,questionDescription,questionCategory,questionImageUrl];

  const QuestionEntity({
    this.questionId,
    required this.question,
    this.questionCategory,
    this.questionDescription,
    this.questionImageUrl,
  });

  factory QuestionEntity.fromJson(Map<String, dynamic> json) => QuestionEntity(
        questionId: json["questionId"],
        question: json["question"],
        questionCategory:json['questionCategory'],
        questionDescription:json['questionDescription'],
        questionImageUrl: json['questionImageurl'],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "question": question,
        "questionCategory":questionCategory,
        "questionDescription":questionDescription,
        "questionImageUrl":questionImageUrl
      };

  @override
  String toString() {
    return '''QuestionEntity(
      questionId: $questionId,
       question: $question,
      questionCategory: $questionCategory),
      questionDescription: $questionDescription,
      questionImageUrl:$questionImageUrl,
        ''';
  }
}
