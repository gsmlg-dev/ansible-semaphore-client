import 'dart:io';

import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dropdown.dart';
import 'package:semaphore/state/projects/user.dart';
import 'package:semaphore/state/user.dart';

class ProjectUserForm extends ConsumerWidget {
  final int? userId;
  const ProjectUserForm({super.key, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final user = ref.watch(userFamily(userId));
    final formData = ref.watch(ProjectUserFormRequestProvider(user.value));
    final systemUser = ref.watch(systemUserProvider);

    final textTitleStyle = Platform.isMacOS
        ? macosTheme.typography.largeTitle
        : theme.textTheme.titleLarge;
    final textBodyStyle = Platform.isMacOS
        ? macosTheme.typography.body
        : theme.textTheme.bodyMedium;

    return user.when(
      data: (user) {
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
                          user.id == null
                              ? 'New Project User'
                              : 'Edit Project User',
                          style: textTitleStyle),
                    ),
                    systemUser.when(
                        data: (data) {
                          return AdaptiveDropdownMenu<int?>(
                            decoration: const InputDecoration(
                              labelText: 'User',
                              contentPadding: EdgeInsets.all(8),
                            ),
                            value: formData.userId,
                            onChanged: (int? value) {
                              ref
                                  .read(projectUserFormRequestProvider(user)
                                      .notifier)
                                  .updateWith(userId: value);
                            },
                            items: data.map<AdaptiveDropdownMenuItem<int>>(
                                (User value) {
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
                    const SizedBox(height: 24.0),
                    AdaptiveDropdownMenu<
                        ProjectProjectIdUsersPostRequestRoleEnum>(
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        contentPadding: EdgeInsets.all(8),
                      ),
                      value: formData.role,
                      onChanged:
                          (ProjectProjectIdUsersPostRequestRoleEnum? value) {
                        ref
                            .read(projectUserFormRequestProvider(user).notifier)
                            .updateWith(role: value);
                      },
                      items: ProjectProjectIdUsersPostRequestRoleEnum.values.map<
                              AdaptiveDropdownMenuItem<
                                  ProjectProjectIdUsersPostRequestRoleEnum>>(
                          (ProjectProjectIdUsersPostRequestRoleEnum value) {
                        return AdaptiveDropdownMenuItem<
                            ProjectProjectIdUsersPostRequestRoleEnum>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24.0),
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
                                      .read(projectUserFormRequestProvider(user)
                                          .notifier)
                                      .postUser();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                  ref
                                      .read(userListProvider.notifier)
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
