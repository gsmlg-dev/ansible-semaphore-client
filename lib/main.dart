import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart' show MacosWindowUtilsConfig;
import 'package:semaphore/utils/state_logger.dart';
import 'package:semaphore/app.dart';
import 'package:system_theme/system_theme.dart';
import 'package:semaphore/database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemTheme.fallbackColor = const Color(0xFF005057);
  await SystemTheme.accentColor.load();

  if (!kIsWeb) {
    if (Platform.isMacOS) {
      const config = MacosWindowUtilsConfig();
      await config.apply();
    }
  }

  await Database.initialize();
  await Database.performMigrationIfNeeded();

  runApp(
    const ProviderScope(observers: [StateLogger()], child: App()),
  );
}
