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
  final String userName;

  @HiveField(2)
  final String? uImage;

  @HiveField(3)
  final String firstName;

  @HiveField(4)
  final String lastName;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String password;

  UserHiveModel({
    String? userId,
    required this.userName,
    this.uImage,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  UserHiveModel.empty()
      : this(
            userName: '',
            uImage: '',
            firstName: '',
            lastName: '',
            email: '',
            password: '');

  // convert Entity to Hive Object
  factory UserHiveModel.toHiveModel(AuthEntity userEnity) => UserHiveModel(
      userName: userEnity.userName,
      firstName: userEnity.firstName,
      lastName: userEnity.lastName,
      email: userEnity.email,
      password: userEnity.password);

  // convert Hive Object to entity
  static AuthEntity toEntity(UserHiveModel hiveModel) => AuthEntity(
      userId: hiveModel.userId,
      userName: hiveModel.userName,
      firstName: hiveModel.firstName,
      lastName: hiveModel.lastName,
      email: hiveModel.email,
      password: hiveModel.password);
}
