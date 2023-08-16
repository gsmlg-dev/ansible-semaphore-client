import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_neumorphic/material_neumorphic.dart';

import 'shared_prefs.dart';

part 'theme.g.dart';

extension ThemeModeExtension on ThemeMode {
  String get title {
    switch (this) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return '';
    }
  }

  Widget get icon {
    switch (this) {
      case ThemeMode.system:
        return const Icon(Icons.brightness_auto_sharp);
      case ThemeMode.light:
        return const Icon(Icons.light_mode_sharp);
      case ThemeMode.dark:
        return const Icon(Icons.dark_mode_sharp);
      default:
        return const SizedBox();
    }
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final pref = ref.read(sharedPrefsProvider).maybeWhen(
        data: (value) => value,
        orElse: () => null,
      );
  return ThemeModeNotifier(pref);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  SharedPreferences? pref;

  ThemeModeNotifier(this.pref)
      : super(ThemeMode.values.firstWhere(
            (e) => e.toString() == pref?.getString('themeMode'),
            orElse: () => ThemeMode.system));

  void changeThemeMode(ThemeMode themeMode) {
    state = themeMode;
    pref?.setString('themeMode', themeMode.toString());
  }

  void toggle() {
    if (state == ThemeMode.system) {
      state = ThemeMode.light;
    } else if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
    pref?.setString('themeMode', state.toString());
  }
}

@immutable
class AppThemeData {
  final ThemeData lightThemeData;
  final ThemeData darkThemeData;
  final Color seedColor;

  const AppThemeData({
    required this.seedColor,
    required this.lightThemeData,
    required this.darkThemeData,
  });

  AppThemeData.fromSeed(Color color)
      : this(
          seedColor: color,
          lightThemeData: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: color, brightness: Brightness.light),
            useMaterial3: true,
            extensions: <ThemeExtension<dynamic>>[
              const NeumorphicTheme().fitWithColorSchema(ColorScheme.fromSeed(
                  seedColor: color, brightness: Brightness.light)),
            ],
          ),
          darkThemeData: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: color, brightness: Brightness.dark),
            useMaterial3: true,
            extensions: <ThemeExtension<dynamic>>[
              const NeumorphicTheme().fitWithColorSchema(ColorScheme.fromSeed(
                  seedColor: color, brightness: Brightness.dark)),
            ],
          ),
        );

  AppThemeData copyWithNeumorphicTheme({
    Color? seedColor,
    double? depth,
    LightSource? lightSource,
    NeumorphicShape? shape,
    double? intensity,
    double? surfaceIntensity,
  }) {
    NeumorphicTheme light = lightThemeData.extension<NeumorphicTheme>()!;
    NeumorphicTheme dark = darkThemeData.extension<NeumorphicTheme>()!;
    if (seedColor != null) {
      light = light.fitWithColorSchema(ColorScheme.fromSeed(
          seedColor: seedColor, brightness: Brightness.light));
      dark = dark.fitWithColorSchema(ColorScheme.fromSeed(
          seedColor: seedColor, brightness: Brightness.dark));
    }
    return AppThemeData(
      seedColor: seedColor ?? this.seedColor,
      lightThemeData: lightThemeData.copyWith(
        colorScheme: seedColor != null
            ? ColorScheme.fromSeed(
                seedColor: seedColor, brightness: Brightness.light)
            : lightThemeData.colorScheme,
        extensions: <ThemeExtension<dynamic>>[
          light.copyWith(
            depth: depth,
            lightSource: lightSource,
            shape: shape,
            intensity: intensity,
            surfaceIntensity: surfaceIntensity,
          ),
        ],
      ),
      darkThemeData: darkThemeData.copyWith(
        colorScheme: seedColor != null
            ? ColorScheme.fromSeed(
                seedColor: seedColor, brightness: Brightness.dark)
            : darkThemeData.colorScheme,
        extensions: <ThemeExtension<dynamic>>[
          dark.copyWith(
            depth: depth,
            lightSource: lightSource,
            shape: shape,
            intensity: intensity,
            surfaceIntensity: surfaceIntensity,
          ),
        ],
      ),
    );
  }
}

@riverpod
Color appSeedColor(AppSeedColorRef ref) {
  final Color seedColor = ref.read(sharedPrefsProvider).maybeWhen<Color>(
        data: (SharedPreferences pref) {
          final int? colorValue = pref.getInt('seedColor');
          if (colorValue != null) {
            return Color(colorValue);
          }
          return NeumorphicTheme.defaultSeedColor;
        },
        orElse: () => NeumorphicTheme.defaultSeedColor,
      );
  return seedColor;
}

@riverpod
class LocalAppThemeData extends _$LocalAppThemeData {
  @override
  AppThemeData build() {
    final seedColor = ref.read(appSeedColorProvider);
    return AppThemeData.fromSeed(seedColor);
  }

  updateWith(
      {Color? seedColor,
      double? depth,
      double? intensity,
      double? surfaceIntensity,
      LightSource? lightSource,
      NeumorphicShape? shape}) {
    state = state.copyWithNeumorphicTheme(
      seedColor: seedColor,
      depth: depth,
      lightSource: lightSource,
      shape: shape,
      intensity: intensity,
      surfaceIntensity: surfaceIntensity,
    );
    if (seedColor != null) {
      ref.read(localAppThemeDataProvider.notifier).saveSeedColor(seedColor);
    }
  }

  saveSeedColor(Color color) async {
    final SharedPreferences pref = await ref.read(sharedPrefsProvider.future);
    final int? colorValue = pref.getInt('seedColor');
    Color seedColor;
    if (colorValue != null) {
      seedColor = Color(colorValue);
    } else {
      seedColor = NeumorphicTheme.defaultSeedColor;
    }
    if (seedColor != color) {
      pref.setInt('seedColor', color.value);
    }
  }
}
