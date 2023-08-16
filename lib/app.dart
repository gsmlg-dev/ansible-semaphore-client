import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/constants.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/state/theme.dart';

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final appThemeData = ref.watch(localAppThemeDataProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: Constants.appName,
      themeMode: themeMode,
      theme: appThemeData.lightThemeData,
      darkTheme: appThemeData.darkThemeData,
    );
  }
}
