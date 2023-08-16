import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/screens/splash/splash_screen.dart';
import 'package:semaphore/screens/error/error_screen.dart';

import 'router_notifier.dart';

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

/// This simple provider caches our GoRouter.
final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: _key,
    refreshListenable: notifier,
    debugLogDiagnostics: true,
    initialLocation: SplashScreen.path,
    routes: notifier.routes,
    redirect: notifier.redirect,
    errorBuilder: (context, state) {
      return ErrorScreen(routerState: state);
    },
  );
});
