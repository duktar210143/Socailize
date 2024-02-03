import 'package:discussion_forum/core/app.dart';
import 'package:discussion_forum/core/network/local/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();


  print(await HiveService().getHiveDatabasePath());

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
