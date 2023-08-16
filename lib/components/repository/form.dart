import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/state/projects/access_key.dart';
import 'package:semaphore/state/projects/repository.dart';

class RepositoryForm extends ConsumerWidget {
  final int? repositoryId;
  const RepositoryForm({super.key, this.repositoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;
    final repository = ref.watch(repositoryFamily(repositoryId));
    final formData = ref.watch(repositoryFormRequestProvider(repository.value));
    final accessKey = ref.watch(accessKeyProvider);

    return repository.when(
      data: (repository) {
        return SingleChildScrollView(
          child: Form(
            child: Column(children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(24),
                child: Text(
                    repository.id == null
                        ? 'New Repository'
                        : 'Edit Repository',
                    style: theme.textTheme.titleLarge),
              ),
              NeumorphicTextFormField(
                margin: const EdgeInsets.all(24),
                depth: -4,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                autocorrect: false,
                initialValue: formData.name,
                onChanged: (value) {
                  ref
                      .read(repositoryFormRequestProvider(repository).notifier)
                      .updateWith(name: value);
                },
                decoration: const InputDecoration(
                    labelText: 'Name', contentPadding: EdgeInsets.all(8)),
              ),
              NeumorphicTextFormField(
                margin: const EdgeInsets.all(24),
                depth: -4,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                autocorrect: false,
                initialValue: formData.gitUrl,
                onChanged: (value) {
                  ref
                      .read(repositoryFormRequestProvider(repository).notifier)
                      .updateWith(gitUrl: value);
                },
                decoration: const InputDecoration(
                    labelText: 'URL or Path',
                    contentPadding: EdgeInsets.all(8)),
              ),
              NeumorphicTextFormField(
                margin: const EdgeInsets.all(24),
                depth: -4,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                autocorrect: false,
                initialValue: formData.gitBranch,
                onChanged: (value) {
                  ref
                      .read(repositoryFormRequestProvider(repository).notifier)
                      .updateWith(gitBranch: value);
                },
                decoration: const InputDecoration(
                    labelText: 'Branch', contentPadding: EdgeInsets.all(8)),
              ),
              accessKey.when(
                  data: (data) {
                    return NeumorphicDropdownButtonFormField<int?>(
                      margin: const EdgeInsets.all(24),
                      depth: -4,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      isExpanded: true,
                      dropdownColor: theme.colorScheme.secondaryContainer,
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),
                      decoration: InputDecoration(
                        labelText: 'Access Key',
                        contentPadding: const EdgeInsets.all(8),
                        suffixIcon: formData.sshKeyId == null
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  ref
                                      .read(repositoryFormRequestProvider(
                                              repository)
                                          .notifier)
                                      .unsetWith(sshKeyId: true);
                                }),
                      ),
                      value: formData.sshKeyId,
                      icon: Icon(Icons.expand_more,
                          color: theme.colorScheme.onSecondaryContainer),
                      onChanged: (int? value) {
                        ref
                            .read(repositoryFormRequestProvider(repository)
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
                    );
                  },
                  loading: () => const Center(child: LinearProgressIndicator()),
                  error: (error, stack) => const Text('Error')),
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
                            .read(repositoryFormRequestProvider(repository)
                                .notifier)
                            .postRepository();
                        if (context.mounted) Navigator.of(context).pop();
                        ref.read(repositoryListProvider.notifier).loadRows();
                      },
                      child: const Text('Create')),
                ]),
              ),
            ]),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: Text('Error')),
    );
  }
}
