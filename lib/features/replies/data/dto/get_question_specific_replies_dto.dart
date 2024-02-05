import 'package:discussion_forum/features/replies/data/model/reply_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_question_specific_replies_dto.g.dart';
@JsonSerializable()
class GetQuestionSpecificRepliesDto {
  final bool success;
  final List<ReplyApiModel> replies;

  GetQuestionSpecificRepliesDto({
    required this.success,
    required this.replies,
  });

  factory GetQuestionSpecificRepliesDto.fromJson(Map<String, dynamic> json) =>
      _$GetQuestionSpecificRepliesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetQuestionSpecificRepliesDtoToJson(this);
}
