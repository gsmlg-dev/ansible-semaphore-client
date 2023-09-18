import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/state/projects/repository.dart';

class RepositoryName extends ConsumerWidget {
  final int? id;

  const RepositoryName({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(repositoryFamily(id));

    return repository.when(
      data: (repository) => Platform.isMacOS
          ? Text(repository.name ?? '--',
              overflow: TextOverflow.ellipsis,
              style: MacosTheme.of(context).typography.body)
          : Text(
              repository.name ?? '--',
              overflow: TextOverflow.ellipsis,
            ),
      loading: () => const LinearProgressIndicator(),
      error: (error, stackTrace) => Platform.isMacOS
          ? Text('N/A', style: MacosTheme.of(context).typography.body)
          : const Text('N/A'),
    );
  }
}
