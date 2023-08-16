import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/state/projects/environment.dart';

class EnvironmentName extends ConsumerWidget {
  final int? id;

  const EnvironmentName({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environment = ref.watch(environmentFamily(id));

    return environment.when(
      data: (environment) => Text(
        environment.name ?? '--',
      ),
      loading: () => const LinearProgressIndicator(),
      error: (error, stackTrace) => const Text('N/A'),
    );
  }
}
