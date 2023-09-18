import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/state/projects/environment.dart';

class EnvironmentName extends ConsumerWidget {
  final int? id;

  const EnvironmentName({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environment = ref.watch(environmentFamily(id));

    return environment.when(
      data: (environment) => Platform.isMacOS
          ? Text(environment.name ?? '--',
              style: MacosTheme.of(context).typography.body)
          : Text(
              environment.name ?? '--',
            ),
      loading: () => const LinearProgressIndicator(),
      error: (error, stackTrace) => Platform.isMacOS
          ? Text('N/A', style: MacosTheme.of(context).typography.body)
          : const Text('N/A'),
    );
  }
}
