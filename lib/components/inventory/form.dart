import 'dart:io';

import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dropdown.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/adaptive/text_field.dart';
import 'package:semaphore/state/projects/access_key.dart';
import 'package:semaphore/state/projects/inventory.dart';

class InventoryForm extends ConsumerWidget {
  final int? inventoryId;
  const InventoryForm({super.key, this.inventoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final inventory = ref.watch(inventoryFamily(inventoryId));
    final formData = ref.watch(inventoryFormRequestProvider(inventory.value));
    final accessKey = ref.watch(accessKeyProvider);

    final textTitleStyle = Platform.isMacOS
        ? macosTheme.typography.largeTitle
        : theme.textTheme.titleLarge;
    final textBodyStyle = Platform.isMacOS
        ? macosTheme.typography.body
        : theme.textTheme.bodyMedium;

    return inventory.when(
      data: (inventory) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(24),
                      child: Text(
                          inventory.id == null
                              ? 'New Inventory'
                              : 'Edit Inventory',
                          style: textTitleStyle),
                    ),
                    AdaptiveTextField(
                      initialValue: formData.name,
                      onChanged: (value) {
                        ref
                            .read(inventoryFormRequestProvider(inventory)
                                .notifier)
                            .updateWith(name: value);
                      },
                      decoration: const InputDecoration(
                          labelText: 'Name', contentPadding: EdgeInsets.all(8)),
                    ),
                    accessKey.when(
                        data: (data) {
                          return AdaptiveDropdownMenu<int?>(
                            decoration: const InputDecoration(
                                labelText: 'User Credentials',
                                contentPadding: EdgeInsets.all(8)),
                            value: formData.sshKeyId,
                            onChanged: (int? value) {
                              ref
                                  .read(inventoryFormRequestProvider(inventory)
                                      .notifier)
                                  .updateWith(sshKeyId: value);
                            },
                            items: data.map<AdaptiveDropdownMenuItem<int>>(
                                (AccessKey value) {
                              return AdaptiveDropdownMenuItem<int>(
                                value: value.id,
                                child: Text(value.name ?? '--',
                                    style: textBodyStyle),
                              );
                            }).toList(),
                          );
                        },
                        loading: () =>
                            const Center(child: LinearProgressIndicator()),
                        error: (error, stack) => const Text('Error')),
                    accessKey.when(
                        data: (data) {
                          return AdaptiveDropdownMenu<int?>(
                            decoration: InputDecoration(
                              labelText: 'Sudo Credentials (Optional)',
                              contentPadding: const EdgeInsets.all(8),
                              suffixIcon: formData.becomeKeyId == null
                                  ? null
                                  : AdaptiveIconButton(
                                      iconData: (Icons.clear),
                                      onPressed: () {
                                        ref
                                            .read(inventoryFormRequestProvider(
                                                    inventory)
                                                .notifier)
                                            .unsetWith(becomeKeyId: true);
                                      }),
                            ),
                            value: formData.becomeKeyId,
                            onChanged: (int? value) {
                              ref
                                  .read(inventoryFormRequestProvider(inventory)
                                      .notifier)
                                  .updateWith(becomeKeyId: value);
                            },
                            items: data
                                .where((element) =>
                                    element.type ==
                                    AccessKeyTypeEnum.loginPassword)
                                .map<AdaptiveDropdownMenuItem<int>>(
                                    (AccessKey value) {
                              return AdaptiveDropdownMenuItem<int>(
                                  value: value.id,
                                  child: Text(
                                    value.name ?? '--',
                                    style: textBodyStyle,
                                  ));
                            }).toList(),
                          );
                        },
                        loading: () =>
                            const Center(child: LinearProgressIndicator()),
                        error: (error, stack) => const Text('Error')),
                    AdaptiveDropdownMenu<InventoryRequestTypeEnum?>(
                      decoration: const InputDecoration(
                          labelText: 'Type', contentPadding: EdgeInsets.all(8)),
                      value: formData.type,
                      onChanged: (InventoryRequestTypeEnum? value) {
                        ref
                            .read(inventoryFormRequestProvider(inventory)
                                .notifier)
                            .updateWith(type: value);
                      },
                      items: InventoryRequestTypeEnum.values.map<
                              AdaptiveDropdownMenuItem<
                                  InventoryRequestTypeEnum>>(
                          (InventoryRequestTypeEnum value) {
                        return AdaptiveDropdownMenuItem<
                            InventoryRequestTypeEnum>(
                          value: value,
                          child: Text(value.name, style: textBodyStyle),
                        );
                      }).toList(),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      alignment: Alignment.bottomRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AdaptiveTextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel')),
                            const SizedBox(
                              width: 24,
                            ),
                            AdaptiveButton(
                                onPressed: () async {
                                  await ref
                                      .read(inventoryFormRequestProvider(
                                              inventory)
                                          .notifier)
                                      .postInventory();
                                  if (context.mounted)
                                    Navigator.of(context).pop();
                                  ref
                                      .read(inventoryListProvider.notifier)
                                      .loadRows();
                                },
                                child: const Text('Create')),
                          ]),
                    ),
                  ]),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: Text('Error')),
    );
  }
}
