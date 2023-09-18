import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/constants.dart';
import 'package:semaphore/state/theme.dart';

class AdaptiveApp extends StatelessWidget {
  final bool debugShowCheckedModeBanner;
  final String title;
  final RouterConfig<Object>? routerConfig;
  final ThemeMode themeMode;
  final AppThemeData appThemeData;

  const AdaptiveApp({
    super.key,
    this.title = Constants.appName,
    this.debugShowCheckedModeBanner = false,
    this.routerConfig,
    this.themeMode = ThemeMode.system,
    required this.appThemeData,
  });

  const AdaptiveApp.router({
    super.key,
    this.title = Constants.appName,
    this.debugShowCheckedModeBanner = false,
    this.routerConfig,
    this.themeMode = ThemeMode.system,
    required this.appThemeData,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return MacosApp.router(
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        routerConfig: routerConfig,
        title: title,
        themeMode: themeMode,
        // theme: MacosThemeData.light(),
        darkTheme: MacosThemeData.dark(),
      );
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      routerConfig: routerConfig,
      title: title,
      themeMode: themeMode,
      theme: appThemeData.lightThemeData,
      darkTheme: appThemeData.darkThemeData,
    );
  }
}
