import 'package:discussion_forum/features/question/data/model/question_api_model.dart';
import 'package:json_annotation/json_annotation.dart';
 
part 'get_all_questions_dto.g.dart';
 
//dart run build_runner build --delete-conflicting-outputs
 
@JsonSerializable()
class GetAllQuestionsDto {
  final bool success;
  final List<QuestionApiModel> questions;
 
  GetAllQuestionsDto({
    required this.success,
    required this.questions,
  });
 
  factory GetAllQuestionsDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllQuestionsDtoFromJson(json);
 
  Map<String, dynamic> toJson() => _$GetAllQuestionsDtoToJson(this);
}