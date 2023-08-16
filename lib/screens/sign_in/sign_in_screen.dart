import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/splash/splash_screen.dart';
import 'package:semaphore/screens/url_config/url_config_screen.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/auth.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});
  static const name = 'signIn';
  static const path = '/sign_in';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;

    final api = ref.watch(semaphoreApiProvider);
    final formData = ref.watch(signInFormProvider);

    final formError = ref.watch(signInFormErrorProvider);

    return Scaffold(
      body: NeumorphicBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Neumorphic(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
                  style: neumorphicTheme.styleWith(
                      boxShape: NeumorphicBoxShape.roundRect(
                          const BorderRadius.all(Radius.circular(24)))),
                  child: AutofillGroup(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 64,
                          child: Row(
                            children: [
                              Text('Sign In or',
                                  style: theme.textTheme.titleLarge),
                              const SizedBox(width: 12),
                              NeumorphicButton(
                                  style: neumorphicTheme
                                      .getNeumorphicStyle()
                                      .copyWith(
                                          depth: -4,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  const BorderRadius.all(
                                                      Radius.circular(24))),
                                          color: theme.colorScheme.secondary),
                                  onPressed: () {
                                    ref
                                        .read(routerProvider)
                                        .go(UrlConfigScreen.path);
                                  },
                                  child: Text(
                                    'Config API URL',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color:
                                                theme.colorScheme.onSecondary),
                                  ))
                            ],
                          ),
                        ),
                        Neumorphic(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          style: neumorphicTheme.styleWith(
                              depth: -4,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  const BorderRadius.all(Radius.circular(12)))),
                          child: TextFormField(
                            initialValue: formData.auth,
                            decoration: const InputDecoration(
                              labelText: 'Auth',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            enableSuggestions: false,
                            autocorrect: false,
                            autofillHints: const <String>[
                              AutofillHints.username,
                            ],
                            onChanged: (value) {
                              ref
                                  .read(signInFormProvider.notifier)
                                  .updateWith(auth: value);
                            },
                          ),
                        ),
                        Neumorphic(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          style: neumorphicTheme.styleWith(
                              depth: -4,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  const BorderRadius.all(Radius.circular(12)))),
                          child: TextFormField(
                            initialValue: formData.password,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            autofillHints: const <String>[
                              AutofillHints.password,
                            ],
                            onChanged: (value) {
                              ref
                                  .read(signInFormProvider.notifier)
                                  .updateWith(password: value);
                            },
                          ),
                        ),
                        Center(
                          child: NeumorphicButton(
                              style: neumorphicTheme.styleWith(
                                color: theme.colorScheme.primary,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    const BorderRadius.all(
                                        Radius.circular(24))),
                              ),
                              onPressed: () async {
                                try {
                                  ref
                                      .read(signInFormErrorProvider.notifier)
                                      .updateWith(null);

                                  final result = await api
                                      .getAuthenticationApi()
                                      .authLoginPost(loginBody: formData);
                                  final headers = result.headers;
                                  final cookie = headers.value('set-cookie');

                                  final resp = await api
                                      .getAuthenticationApi()
                                      .userTokensPost(
                                          headers: {'cookie': cookie});

                                  final data = resp.data;
                                  if (data != null && data.id != null) {
                                    ref
                                        .read(userTokenProvider.notifier)
                                        .setToken(data.id!);

                                    ref
                                        .read(routerProvider)
                                        .go(SplashScreen.path);
                                  }
                                } catch (e) {
                                  ref
                                      .read(signInFormErrorProvider.notifier)
                                      .updateWith(e);
                                }
                              },
                              child: Text(
                                'Login',
                                style: theme.textTheme.titleLarge!.copyWith(
                                    color: theme.colorScheme.onPrimary),
                              )),
                        ),
                        formError == null
                            ? Container()
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  formError.toString(),
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(color: theme.colorScheme.error),
                                ),
                              ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
