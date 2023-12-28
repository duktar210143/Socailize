import 'package:discussion_forum/config/constants/hive_table_constants.dart';
import 'package:discussion_forum/features/authentication/data/models/user_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final hiveSerivceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // register adapters
    Hive.registerAdapter(UserHiveModelAdapter());
  }

  // +++++++++++++++++++ UserQueries +++++++++++++++++
  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstants.userBox);
    await box.put(user.userId, user);
  }

// +++++++++++++++++++++ Hive specific codes +++++++++
// check if the user is being correctly registered inside the hive box
Future<void> printUserBoxContents() async {
  var box = await Hive.openBox<UserHiveModel>(HiveTableConstants.userBox);

  print('Hive box usernames:');
  box.toMap().forEach((key, value) {
    if (value is UserHiveModel) {
      print('Username: ${value.userName}');
    }
  });
  await box.close();
}

  Future<String> getHiveDatabasePath() async {
  var directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
}
