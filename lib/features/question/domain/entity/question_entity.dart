import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String? questionId;
  final String question;
  final String? questionCategory;
  final String? questionDescription;
  final String? questionImage;

  @override
  List<Object?> get props => [questionId, question,questionDescription,questionCategory,questionImage];

  const QuestionEntity({
    this.questionId,
    required this.question,
    this.questionCategory,
    this.questionDescription,
    this.questionImage,
  });

  factory QuestionEntity.fromJson(Map<String, dynamic> json) => QuestionEntity(
        questionId: json["questionId"],
        question: json["question"],
        questionCategory:json['questionCategory'],
        questionDescription:json['questionDescription'],
        questionImage: json['questionImageurl'],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "question": question,
        "questionCategory":questionCategory,
        "questionDescription":questionDescription,
        "questionImageUrl":questionImage
      };

  @override
  String toString() {
    return '''QuestionEntity(
      questionId: $questionId,
       question: $question,
      questionCategory: $questionCategory),
      questionDescription: $questionDescription,
      questionImageUrl:$questionImage,
        ''';
  }
}
