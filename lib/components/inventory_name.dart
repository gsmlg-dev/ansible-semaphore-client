import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/state/projects/inventory.dart';

class InventoryName extends ConsumerWidget {
  final int? id;

  const InventoryName({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory = ref.watch(inventoryFamily(id));

    return inventory.when(
      data: (inventory) => Platform.isMacOS
          ? Text(inventory.name ?? '--',
              style: MacosTheme.of(context).typography.body)
          : Text(
              inventory.name ?? '--',
            ),
      loading: () => const LinearProgressIndicator(),
      error: (error, stackTrace) => Platform.isMacOS
          ? Text('N/A', style: MacosTheme.of(context).typography.body)
          : const Text('N/A'),
    );
  }
}
