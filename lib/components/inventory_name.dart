import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/state/projects/inventory.dart';

class InventoryName extends ConsumerWidget {
  final int? id;

  const InventoryName({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory = ref.watch(inventoryFamily(id));

    return inventory.when(
      data: (inventory) => Text(
        inventory.name ?? '--',
      ),
      loading: () => const LinearProgressIndicator(),
      error: (error, stackTrace) => const Text('N/A'),
    );
  }
}
