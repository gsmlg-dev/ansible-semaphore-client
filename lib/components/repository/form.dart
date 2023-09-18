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
import 'package:semaphore/state/projects/repository.dart';

class RepositoryForm extends ConsumerWidget {
  final int? repositoryId;
  const RepositoryForm({super.key, this.repositoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final repository = ref.watch(repositoryFamily(repositoryId));
    final formData = ref.watch(repositoryFormRequestProvider(repository.value));
    final accessKey = ref.watch(accessKeyProvider);

    final textTitleStyle = Platform.isMacOS
        ? macosTheme.typography.largeTitle
        : theme.textTheme.titleLarge;
    final textBodyStyle = Platform.isMacOS
        ? macosTheme.typography.body
        : theme.textTheme.bodyMedium;

    return repository.when(
      data: (repository) {
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
                          repository.id == null
                              ? 'New Repository'
                              : 'Edit Repository',
                          style: textTitleStyle),
                    ),
                    AdaptiveTextField(
                      autocorrect: false,
                      initialValue: formData.name,
                      onChanged: (value) {
                        ref
                            .read(repositoryFormRequestProvider(repository)
                                .notifier)
                            .updateWith(name: value);
                      },
                      decoration: const InputDecoration(
                          labelText: 'Name', contentPadding: EdgeInsets.all(8)),
                    ),
                    AdaptiveTextField(
                      autocorrect: false,
                      initialValue: formData.gitUrl,
                      onChanged: (value) {
                        ref
                            .read(repositoryFormRequestProvider(repository)
                                .notifier)
                            .updateWith(gitUrl: value);
                      },
                      decoration: const InputDecoration(
                          labelText: 'URL or Path',
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    AdaptiveTextField(
                      autocorrect: false,
                      initialValue: formData.gitBranch,
                      onChanged: (value) {
                        ref
                            .read(repositoryFormRequestProvider(repository)
                                .notifier)
                            .updateWith(gitBranch: value);
                      },
                      decoration: const InputDecoration(
                          labelText: 'Branch',
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    accessKey.when(
                        data: (data) {
                          return AdaptiveDropdownMenu<int?>(
                            decoration: InputDecoration(
                              labelText: 'Access Key',
                              contentPadding: const EdgeInsets.all(8),
                              suffixIcon: formData.sshKeyId == null
                                  ? null
                                  : AdaptiveIconButton(
                                      iconData: (Icons.clear),
                                      onPressed: () {
                                        ref
                                            .read(repositoryFormRequestProvider(
                                                    repository)
                                                .notifier)
                                            .unsetWith(sshKeyId: true);
                                      }),
                            ),
                            value: formData.sshKeyId,
                            onChanged: (int? value) {
                              ref
                                  .read(
                                      repositoryFormRequestProvider(repository)
                                          .notifier)
                                  .updateWith(sshKeyId: value);
                            },
                            items: data.map<AdaptiveDropdownMenuItem<int>>(
                                (AccessKey value) {
                              return AdaptiveDropdownMenuItem<int>(
                                value: value.id,
                                child: Text(value.name ?? '--'),
                              );
                            }).toList(),
                          );
                        },
                        loading: () =>
                            const Center(child: LinearProgressIndicator()),
                        error: (error, stack) => const Text('Error')),
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
                                      .read(repositoryFormRequestProvider(
                                              repository)
                                          .notifier)
                                      .postRepository();
                                  if (context.mounted)
                                    Navigator.of(context).pop();
                                  ref
                                      .read(repositoryListProvider.notifier)
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
