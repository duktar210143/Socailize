import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

class ReplyEntity extends Equatable {
  final String? replyId;
  final String reply;
  final AuthEntity? user;

  @override
  // TODO: implement props
  List<Object?> get props => [replyId, reply];

  const ReplyEntity({this.user, this.replyId, required this.reply});

  factory ReplyEntity.fromJson(Map<String, dynamic> json) => ReplyEntity(
      replyId: json['replyId'],
      reply: json['reply'],
      user: AuthEntity.fromjson(json['user']));

  Map<String, dynamic> toJson() => 
  {"replyId": replyId,
   "reply": reply,
   "user":user?.toJson()};
}
