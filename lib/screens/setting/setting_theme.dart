import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/state/theme.dart';

class ThemeSetting extends ConsumerWidget {
  const ThemeSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return SizedBox.expand(
        child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Wrap(
        spacing: 24.0,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const AdaptiveTextTitle('Theme Mode'),
          ToggleButtons(
              isSelected:
                  ThemeMode.values.map<bool>((tm) => tm == themeMode).toList(),
              onPressed: (idx) {
                final tm = ThemeMode.values[idx];
                ref.read(themeModeProvider.notifier).changeThemeMode(tm);
              },
              children: ThemeMode.values
                  .map<Widget>((tm) => Wrap(
                        spacing: 12,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const SizedBox(
                            width: 12.0,
                            height: 12.0,
                          ),
                          AdaptiveIcon(tm.iconData),
                          AdaptiveTextBody(tm.title),
                          const SizedBox(
                            width: 12.0,
                            height: 12.0,
                          ),
                        ],
                      ))
                  .toList()),
        ],
      ),
    ));
  }
}
