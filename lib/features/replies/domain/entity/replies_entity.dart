import 'package:equatable/equatable.dart';

class ReplyEntity extends Equatable {
  final String? replyId;
  final String reply;

  @override
  // TODO: implement props
  List<Object?> get props => [replyId, reply];

  const ReplyEntity({this.replyId, required this.reply});

  factory ReplyEntity.fromJson(Map<String, dynamic> json) => ReplyEntity(
        replyId: json['replyId'],
        reply: json['reply'],
      );

  Map<String, dynamic> toJson() => {
    "replyId": replyId, "reply": reply};
}
