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

  // signUp
  Future<bool> addUser(UserHiveModel user) async {
    print('Signing up user: ${user.userName}');
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstants.userBox);

    // Check if the userName already exists
    bool userExists = box.values
        .any((existingUser) => existingUser.userName == user.userName);

    if (userExists) {
      // The userName already exists, handle this case (throw an exception, show an error, etc.)
      // throw Exception('User with this userName already exists');
      print('User with this userName already exists');
      return false;
    }

    // The userName is unique, add the user
    await box.put(user.userId, user);
    return true;
  }

// SignIn
  Future<UserHiveModel?> signInUser(String userName, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstants.userBox);
    var user = box.values.firstWhere((element) =>
        element.userName == userName && element.password == password);
    box.close();
    return user;
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
