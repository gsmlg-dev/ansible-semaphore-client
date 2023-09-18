import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/scaffold.dart';
import 'package:semaphore/adaptive/text_field.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/splash/splash_screen.dart';
import 'package:semaphore/state/api_config.dart';

class UrlConfigScreen extends ConsumerWidget {
  const UrlConfigScreen({super.key});
  static const name = 'urlConfig';
  static const path = '/url_config';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final formData = ref.watch(apiUrlProvider);

    return AdaptiveScaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child:
                      Text('Semaphore URL', style: theme.textTheme.titleLarge),
                ),
                AdaptiveTextField(
                  initialValue: formData,
                  decoration: const InputDecoration(
                    labelText: 'API URL',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (value) {
                    ref.read(apiUrlProvider.notifier).changeApiUrl(value);
                  },
                ),
                Center(
                  child: AdaptiveButton(
                      onPressed: () {
                        ref.read(routerProvider).go(SplashScreen.path);
                      },
                      child: Text(
                        'Return to Splash Screen',
                        style: theme.textTheme.titleLarge
                            ?.copyWith(color: theme.colorScheme.onPrimary),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
