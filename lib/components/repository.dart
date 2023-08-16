import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/state/projects/repository.dart';

class RepositoryName extends ConsumerWidget {
  final int? id;

  const RepositoryName({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(repositoryFamily(id));

    return repository.when(
      data: (repository) => Text(
        repository.name ?? '--',
        overflow: TextOverflow.ellipsis,
      ),
      loading: () => const LinearProgressIndicator(),
      error: (error, stackTrace) => const Text('N/A'),
    );
  }
}
