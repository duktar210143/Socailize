import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../../../config/constants/hive_table_constants.dart';

part 'user_hive_model.g.dart';


@HiveType(typeId: HiveTableConstants.userTableId)
class UserHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String? uImage;

  @HiveField(3)
  final String firstname;

  @HiveField(4)
  final String lastname;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String password;

  UserHiveModel({
    String? userId,
    required this.username,
    this.uImage,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  UserHiveModel.empty()
      : this(
            username: '',
            uImage: '',
            firstname: '',
            lastname: '',
            email: '',
            password: '');

  // convert Entity to Hive Object
  factory UserHiveModel.toHiveModel(AuthEntity userEnity) => UserHiveModel(
      username: userEnity.username,
      firstname: userEnity.firstname,
      lastname: userEnity.lastname,
      email: userEnity.email,
      password: userEnity.password);

  // convert Hive Object to entity
  static AuthEntity toEntity(UserHiveModel hiveModel) => AuthEntity(
      userId: hiveModel.userId,
      username: hiveModel.username,
      firstname: hiveModel.firstname,
      lastname: hiveModel.lastname,
      email: hiveModel.email,
      password: hiveModel.password);
}
