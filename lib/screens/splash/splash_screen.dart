import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/adaptive/scaffold.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/home/home_screen.dart';
import 'package:semaphore/screens/sign_in/sign_in_screen.dart';
import 'package:semaphore/screens/url_config/url_config_screen.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/auth.dart';

import 'paint_logo.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  static const name = 'splash';
  static const path = '/splash';

  void checkStatus(BuildContext context, WidgetRef ref) async {
    try {
      final apiUrl = await ref.read(apiUrlProvider.notifier).loadApiUrl();
      if (apiUrl == '') {
        ref.read(routerProvider).go(UrlConfigScreen.path);
        return;
      }
      await ref.read(userTokenProvider.notifier).readToken();
      await ref.read(userTokenProvider.notifier).checkToken();

      final isAuth = ref.read(signInStateProvider);

      ref.read(semaphoreApiProvider.notifier).rebuild();
      final url = isAuth ? HomeScreen.name : SignInScreen.name;

      ref.read(routerProvider).goNamed(url);
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
