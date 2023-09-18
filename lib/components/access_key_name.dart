import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/state/projects/access_key.dart';

class AccessKeyName extends ConsumerWidget {
  final int? id;

  const AccessKeyName({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accessKey = ref.watch(accessKeyFamily(id));

    return accessKey.when(
      data: (accessKey) {
        if (Platform.isMacOS) {
          final theme = MacosTheme.of(context);
          return Text(accessKey.name ?? '--', style: theme.typography.body);
        }
        return Text(
          accessKey.name ?? '--',
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (error, stackTrace) => Platform.isMacOS
          ? Text('N/A', style: MacosTheme.of(context).typography.body)
          : const Text('N/A'),
    );
  }
}
