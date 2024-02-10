// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:discussion_forum/features/authentication/data/models/auth_api_model.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ReplyApiModel {
  @JsonKey(name: '_id')
  final String? replyId;

  final String reply;

  final AuthApiModel? user;

  ReplyApiModel({
    this.replyId,
    required this.reply,
    this.user,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': replyId,
      'reply': reply,
      'user': user?.toJson(), // Convert user to JSON if not null
    };
  }

  factory ReplyApiModel.fromJson(Map<String, dynamic> json) {
    return ReplyApiModel(
      replyId: json['_id'],
      reply: json['reply'],
      user: json['user'] != null
          ? AuthApiModel.fromJson(json['user'])
          : null, // Parse user information if not null
    );
  }

  factory ReplyApiModel.fromEntity(ReplyEntity entity) {
    return ReplyApiModel(
      reply: entity.reply,
      user: entity.user != null
          ? AuthApiModel.fromEntity(entity.user!)
          : null, // Convert user entity to model if not null
    );
  }

  static ReplyEntity toEntity(ReplyApiModel model) {
    return ReplyEntity(
      replyId: model.replyId,
      reply: model.reply,
      user: model.user != null
          ? AuthApiModel.toEntity(model.user!)
          : null, // Convert user model to entity if not null
    );
  }

  @override
  String toString() => 'ReplyApiModel(replyId: $replyId, reply: $reply)';
}
