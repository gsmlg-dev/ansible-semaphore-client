import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/constants.dart';
import 'package:semaphore/database/database.dart';
import 'package:semaphore/database/schema/app_activities.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/state/theme.dart';
import 'package:semaphore/adaptive/app.dart';
import 'package:system_theme/system_theme.dart';
import 'package:system_tray/system_tray.dart';

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    ref
        .read(localAppThemeDataProvider.notifier)
        .saveSeedColor(SystemTheme.accentColor.accent);
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      initSystemTray();
    }
    WidgetsBinding.instance.addObserver(this);
    if (WidgetsBinding.instance.lifecycleState != null) {
      print(WidgetsBinding.instance.lifecycleState!);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final appActivity = AppActivities()
      ..state = state
      ..createdAt = DateTime.now();

    await Database().instance.writeTxn(() async {
      await Database().instance.appActivities.put(appActivity);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> initSystemTray() async {
    String path =
        Platform.isWindows ? 'assets/icon/icon.png' : 'assets/icon/icon.png';

    final AppWindow appWindow = AppWindow();
    final SystemTray systemTray = SystemTray();

    // We first init the systray menu
    await systemTray.initSystemTray(
      toolTip: 'Ansible Semaphore Client',
      iconPath: path,
    );

    // create context menu
    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(label: 'Show', onClicked: (menuItem) => appWindow.show()),
      MenuItemLabel(label: 'Hide', onClicked: (menuItem) => appWindow.hide()),
      MenuItemLabel(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
    ]);

    // set context menu
    await systemTray.setContextMenu(menu);

    // handle system tray event
    systemTray.registerSystemTrayEventHandler((eventName) {
      debugPrint('eventName: $eventName');
      if (eventName == kSystemTrayEventClick) {
        Platform.isWindows ? appWindow.show() : systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        Platform.isWindows ? systemTray.popUpContextMenu() : appWindow.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final accentColor = SystemTheme.accentColor.accent;

    return AdaptiveApp.router(
      accentColor: accentColor,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: Constants.appName,
      themeMode: themeMode,
    );
  }
}
