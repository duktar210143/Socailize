import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String? questionId;
  final String question;
  final String? questionImageUrl;
  final AuthEntity? user;
  final List<ReplyEntity>? replies;

  @override
  List<Object?> get props => [
        questionId,
        question,
        questionImageUrl,
        user,
        replies
      ];

  const QuestionEntity({
    this.questionId,
    required this.question,
    this.questionImageUrl,
    this.user,
    this.replies,
  });

factory QuestionEntity.fromJson(Map<String, dynamic> json) {
  print('fromJson json: $json');
  return QuestionEntity(
    questionId: json["questionId"] ?? '',
    question: json["question"] ?? '',
    questionImageUrl: json['questionImageUrl'] ?? '',
    user: AuthEntity.fromjson(json['user'] ?? {}),
    replies: (json['replies'] as List<dynamic>?)
      ?.map((reply) => ReplyEntity.fromJson(reply))
      .toList(),
  );
}

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "question": question,
        "questionImageUrl": questionImageUrl,
        "user":user?.toJson(),
        'replies': replies?.map((reply) => reply.toJson()).toList(),
      };

  @override
  String toString() {
    return '''QuestionEntity(
      questionId: $questionId,
       question: $question,
      questionImageUrl:$questionImageUrl,
        ''';
  }
}
