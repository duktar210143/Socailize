import 'package:discussion_forum/features/authentication/data/models/auth_api_model.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/replies/data/model/reply_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class QuestionApiModel {
  @JsonKey(name: '_id')
  final String? questionId;
  final String question;
  final String? questionDescription;
  final String? questionCategory;
  final String? questionImageUrl;
  final AuthApiModel? user;  // Add user property
  final List<ReplyApiModel>? replies;  // Add replies property

  QuestionApiModel({
    this.questionId,
    required this.question,
    this.questionDescription,
    this.questionCategory,
    this.questionImageUrl,
    this.user,
    this.replies,
  });

  factory QuestionApiModel.fromJson(Map<String, dynamic> json) {
    return QuestionApiModel(
      questionId: json['_id'],
      question: json['question'],
      questionCategory: json['questionCategory'],
      questionDescription: json['questionDescription'],
      questionImageUrl: json['questionImageUrl'],
      user: AuthApiModel.fromJson(json['user']),  // Parse user information
      replies: (json['replies'] as List<dynamic>?)
          ?.map((reply) => ReplyApiModel.fromJson(reply))
          .toList(),  // Parse list of replies
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': questionId,
      'question': question,
      'questionCategory': questionCategory,
      'questionDescription': questionDescription,
      'questionImageUrl': questionImageUrl,
      'user': user?.toJson(),  // Convert user to JSON
      'replies': replies?.map((reply) => reply.toJson()).toList(),  // Convert replies to JSON
    };
  }

  factory QuestionApiModel.fromEntity(QuestionEntity entity) {
    return QuestionApiModel(
      questionId: entity.questionId,
      question: entity.question,
      questionCategory: entity.questionCategory,
      questionDescription: entity.questionDescription,
      questionImageUrl: entity.questionImageUrl,
      // whilst setting the question we do not need to provide user so it remains null
      user: entity.user !=null ?
       AuthApiModel.fromEntity(entity.user!):null,  // Convert user entity to model
      replies: entity.replies?.map((reply) => ReplyApiModel.fromEntity(reply)).toList(),  // Convert replies entities to models
    );
  }

  static QuestionEntity toEntity(QuestionApiModel model) {
    return QuestionEntity(
      questionId: model.questionId,
      question: model.question,
      questionCategory: model.questionCategory,
      questionDescription: model.questionDescription,
      questionImageUrl: model.questionImageUrl,
      user: model.user != null
          ? AuthApiModel.toEntity(model.user!)
          : null, // Convert user model to entity if not null
      replies: model.replies?.map((reply) => ReplyApiModel.toEntity(reply)).toList(),  // Convert replies models to entities
    );
  }
}
