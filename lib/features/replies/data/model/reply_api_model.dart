// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ReplyApiModel {
  @JsonKey(name: '_id')
  final String? replyId;

  final String reply;

  ReplyApiModel({
    this.replyId,
    required this.reply,
  });

  ReplyApiModel copyWith({
    String? replyId,
    String? reply,
  }) {
    return ReplyApiModel(
      replyId: replyId ?? this.replyId,
      reply: reply ?? this.reply,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': replyId,
      'reply': reply,
    };
  }

  factory ReplyApiModel.fromJson(Map<String, dynamic> json) {
    return ReplyApiModel(
      replyId: json['_id'],
      reply: json['reply'],
    );
  }

  factory ReplyApiModel.fromEntity(ReplyEntity entity) {
    return ReplyApiModel(
      reply: entity.reply,
    );
  }

  static ReplyEntity toEntity(ReplyApiModel model) {
    return ReplyEntity(
      replyId: model.replyId,
      reply: model.reply,
    );
  }

  @override
  String toString() => 'ReplyApiModel(replyId: $replyId, reply: $reply)';
}
