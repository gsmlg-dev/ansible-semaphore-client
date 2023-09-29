import 'dart:io';

import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dropdown.dart';
import 'package:semaphore/state/projects/user.dart';

class ProjectUserRoleForm extends ConsumerWidget {
  final int userId;
  const ProjectUserRoleForm({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final user = ref.watch(userFamily(userId));
    final formData = ref.watch(ProjectUserRoleFormRequestProvider(user.value));

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
                      child: Text('Update User Role', style: textTitleStyle),
                    ),
                    AdaptiveDropdownMenu<
                        ProjectProjectIdUsersUserIdPutRequestRoleEnum>(
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        contentPadding: EdgeInsets.all(8),
                      ),
                      value: formData.role,
                      onChanged: (ProjectProjectIdUsersUserIdPutRequestRoleEnum?
                          value) {
                        ref
                            .read(projectUserRoleFormRequestProvider(user)
                                .notifier)
                            .updateWith(role: value);
                      },
                      items: ProjectProjectIdUsersUserIdPutRequestRoleEnum
                          .values
                          .map<
                                  AdaptiveDropdownMenuItem<
                                      ProjectProjectIdUsersUserIdPutRequestRoleEnum>>(
                              (ProjectProjectIdUsersUserIdPutRequestRoleEnum
                                  value) {
                        return AdaptiveDropdownMenuItem<
                            ProjectProjectIdUsersUserIdPutRequestRoleEnum>(
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
                                      .read(projectUserRoleFormRequestProvider(
                                              user)
                                          .notifier)
                                      .postUser(userId);
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                  ref
                                      .read(userListProvider.notifier)
                                      .loadRows();
                                },
                                child: const Text('Change')),
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
