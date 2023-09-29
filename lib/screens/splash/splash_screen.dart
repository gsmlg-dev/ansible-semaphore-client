import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/adaptive/scaffold.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/home/home_screen.dart';
import 'package:semaphore/screens/setting/setting_screen.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/state/server.dart';

import 'paint_logo.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  static const name = 'splash';
  static const path = '/splash';

  void checkStatus(BuildContext context, WidgetRef ref) async {
    try {
      final currentServer = ref.read(serversProvider.notifier).currentServer();
      if (currentServer == null) {
        ref.read(routerProvider).goNamed(SettingsScreen.name, pathParameters: {
          'module': SettingsScreenModule.server.name,
        });
        return;
      }

      final currentProject = await ref.read(currentProjectProvider.future);
      if (currentProject == null) {
        ref.read(routerProvider).goNamed(SettingsScreen.name, pathParameters: {
          'module': SettingsScreenModule.project.name,
        });
        return;
      }

      ref.read(routerProvider).goNamed(HomeScreen.name);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final width = size.width > size.height ? size.height : size.width;

    checkStatus(context, ref);

    return AdaptiveScaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
              width: width * 0.8,
              height: width * 0.8,
              child: Center(
                child: CustomPaint(
                  size: Size(width * 0.7, width * 0.7 * 0.2),
                  painter: LogoPainter(),
                ),
              )),
        ),
      ),
    );
  }
}
