import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:semaphore/router/router.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key, required this.routerState});
  static const path = '/error';

  final GoRouterState routerState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.topLeft,
              child: Text('Error:',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.error)),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(routerState.error.toString(),
                    style: Theme.of(context).textTheme.bodyLarge)),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: ElevatedButton(
                onPressed: () {
                  router.go('/splash');
                },
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
