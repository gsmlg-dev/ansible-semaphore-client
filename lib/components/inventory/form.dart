import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/state/projects/access_key.dart';
import 'package:semaphore/state/projects/inventory.dart';

class InventoryForm extends ConsumerWidget {
  final int? inventoryId;
  const InventoryForm({super.key, this.inventoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;
    final inventory = ref.watch(inventoryFamily(inventoryId));
    final formData = ref.watch(inventoryFormRequestProvider(inventory.value));
    final accessKey = ref.watch(accessKeyProvider);

    return inventory.when(
      data: (inventory) {
        return Form(
          child: Column(children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(24),
              child: Text(
                  inventory.id == null ? 'New Inventory' : 'Edit Inventory',
                  style: theme.textTheme.titleLarge),
            ),
            Neumorphic(
              margin: const EdgeInsets.all(24),
              style: neumorphicTheme.styleWith(
                  depth: -4,
                  boxShape: NeumorphicBoxShape.roundRect(
                      const BorderRadius.all(Radius.circular(12)))),
              child: TextFormField(
                initialValue: formData.name,
                onChanged: (value) {
                  ref
                      .read(inventoryFormRequestProvider(inventory).notifier)
                      .updateWith(name: value);
                },
                decoration: const InputDecoration(
                    labelText: 'Name', contentPadding: EdgeInsets.all(8)),
              ),
            ),
            accessKey.when(
                data: (data) {
                  return Neumorphic(
                    margin: const EdgeInsets.all(24),
                    style: neumorphicTheme.styleWith(
                        depth: -4,
                        boxShape: NeumorphicBoxShape.roundRect(
                            const BorderRadius.all(Radius.circular(12)))),
                    // padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: DropdownButtonFormField<int?>(
                      isExpanded: true,
                      dropdownColor: theme.colorScheme.secondaryContainer,
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),
                      decoration: const InputDecoration(
                          labelText: 'User Credentials',
                          contentPadding: EdgeInsets.all(8)),
                      value: formData.sshKeyId,
                      icon: Icon(Icons.expand_more,
                          color: theme.colorScheme.onSecondaryContainer),
                      onChanged: (int? value) {
                        ref
                            .read(inventoryFormRequestProvider(inventory)
                                .notifier)
                            .updateWith(sshKeyId: value);
                      },
                      items: data.map<DropdownMenuItem<int>>((AccessKey value) {
                        return DropdownMenuItem<int>(
                          value: value.id,
                          child: Text(value.name ?? '--',
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color:
                                      theme.colorScheme.onSecondaryContainer)),
                        );
                      }).toList(),
                    ),
                  );
                },
                loading: () => const Center(child: LinearProgressIndicator()),
                error: (error, stack) => const Text('Error')),
            accessKey.when(
                data: (data) {
                  return Neumorphic(
                    margin: const EdgeInsets.all(24),
                    style: neumorphicTheme.styleWith(
                        depth: -4,
                        boxShape: NeumorphicBoxShape.roundRect(
                            const BorderRadius.all(Radius.circular(12)))),
                    // padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: DropdownButtonFormField<int?>(
                      isExpanded: true,
                      dropdownColor: theme.colorScheme.secondaryContainer,
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),
                      decoration: InputDecoration(
                        labelText: 'Sudo Credentials (Optional)',
                        contentPadding: const EdgeInsets.all(8),
                        suffixIcon: formData.becomeKeyId == null
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  ref
                                      .read(inventoryFormRequestProvider(
                                              inventory)
                                          .notifier)
                                      .unsetWith(becomeKeyId: true);
                                }),
                      ),
                      value: formData.becomeKeyId,
                      icon: Icon(Icons.expand_more,
                          color: theme.colorScheme.onSecondaryContainer),
                      onChanged: (int? value) {
                        ref
                            .read(inventoryFormRequestProvider(inventory)
                                .notifier)
                            .updateWith(becomeKeyId: value);
                      },
                      items: data
                          .where((element) =>
                              element.type == AccessKeyTypeEnum.loginPassword)
                          .map<DropdownMenuItem<int>>((AccessKey value) {
                        return DropdownMenuItem<int>(
                          value: value.id,
                          child: Text(value.name ?? '--',
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color:
                                      theme.colorScheme.onSecondaryContainer)),
                        );
                      }).toList(),
                    ),
                  );
                },
                loading: () => const Center(child: LinearProgressIndicator()),
                error: (error, stack) => const Text('Error')),
            Neumorphic(
              margin: const EdgeInsets.all(24),
              style: neumorphicTheme.styleWith(
                  depth: -4,
                  boxShape: NeumorphicBoxShape.roundRect(
                      const BorderRadius.all(Radius.circular(12)))),
              child: DropdownButtonFormField<InventoryRequestTypeEnum?>(
                isExpanded: true,
                dropdownColor: theme.colorScheme.secondaryContainer,
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.onSecondaryContainer),
                decoration: const InputDecoration(
                    labelText: 'Type', contentPadding: EdgeInsets.all(8)),
                value: formData.type,
                icon: Icon(Icons.expand_more,
                    color: theme.colorScheme.onSecondaryContainer),
                onChanged: (InventoryRequestTypeEnum? value) {
                  ref
                      .read(inventoryFormRequestProvider(inventory).notifier)
                      .updateWith(type: value);
                },
                items: InventoryRequestTypeEnum.values
                    .map<DropdownMenuItem<InventoryRequestTypeEnum>>(
                        (InventoryRequestTypeEnum value) {
                  return DropdownMenuItem<InventoryRequestTypeEnum>(
                    value: value,
                    child: Text(value.name,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer)),
                  );
                }).toList(),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                const SizedBox(
                  width: 24,
                ),
                NeumorphicButton(
                    onPressed: () async {
                      await ref
                          .read(
                              inventoryFormRequestProvider(inventory).notifier)
                          .postInventory();
                      if (context.mounted) Navigator.of(context).pop();
                      ref.read(inventoryListProvider.notifier).loadRows();
                    },
                    child: const Text('Create')),
              ]),
            ),
          ]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: Text('Error')),
    );
  }
}
