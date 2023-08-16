import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/utils/state_logger.dart';
import 'package:semaphore/app.dart';
import 'package:semaphore/database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Database.initialize();
  await Database.performMigrationIfNeeded();

  runApp(
    const ProviderScope(observers: [StateLogger()], child: App()),
  );
}
