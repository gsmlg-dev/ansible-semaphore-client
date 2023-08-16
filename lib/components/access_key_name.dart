import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/state/projects/access_key.dart';

class AccessKeyName extends ConsumerWidget {
  final int? id;

  const AccessKeyName({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accessKey = ref.watch(accessKeyFamily(id));

    return accessKey.when(
      data: (accessKey) => Text(
        accessKey.name ?? '--',
      ),
      loading: () => const LinearProgressIndicator(),
      error: (error, stackTrace) => const Text('N/A'),
    );
  }
}
