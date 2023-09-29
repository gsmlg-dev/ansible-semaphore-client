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
  final Color accentColor;

  const AdaptiveApp({
    super.key,
    this.title = Constants.appName,
    this.debugShowCheckedModeBanner = false,
    this.routerConfig,
    this.themeMode = ThemeMode.system,
    required this.accentColor,
  });

  const AdaptiveApp.router({
    super.key,
    this.title = Constants.appName,
    this.debugShowCheckedModeBanner = false,
    this.routerConfig,
    this.themeMode = ThemeMode.system,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      final lightTheme = MacosThemeData.light().copyWith(
        primaryColor: accentColor,
      );
      final darkTheme =
          MacosThemeData.dark().copyWith(primaryColor: accentColor);
      return MacosApp.router(
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        routerConfig: routerConfig,
        title: title,
        themeMode: themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
      );
    }

    final appThemeData = AppThemeData.fromSeed(accentColor);
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
