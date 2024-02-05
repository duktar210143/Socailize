// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_question_specific_replies_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetQuestionSpecificRepliesDto _$GetQuestionSpecificRepliesDtoFromJson(
        Map<String, dynamic> json) =>
    GetQuestionSpecificRepliesDto(
      success: json['success'] as bool,
      replies: (json['replies'] as List<dynamic>)
          .map((e) => ReplyApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetQuestionSpecificRepliesDtoToJson(
        GetQuestionSpecificRepliesDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'replies': instance.replies,
    };
