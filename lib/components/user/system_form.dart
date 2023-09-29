import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/switch.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/adaptive/text_field.dart';
import 'package:semaphore/state/user.dart';

class SystemUserForm extends ConsumerWidget {
  final int? userId;
  const SystemUserForm({super.key, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final systemUser = ref.watch(systemUserFamilyProvider(userId));
    final formData = ref.watch(systemUserFormRequestProvider(systemUser.value));

    final textTitleStyle = Platform.isMacOS
        ? macosTheme.typography.largeTitle
        : theme.textTheme.titleLarge;
    final textBodyStyle = Platform.isMacOS
        ? macosTheme.typography.body
        : theme.textTheme.bodyMedium;

    return systemUser.when(
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
                      child: Text(user.id == null ? 'New User' : 'Edit User',
                          style: textTitleStyle),
                    ),
                    const SizedBox(height: 24),
                    AdaptiveTextField(
                      autocorrect: false,
                      initialValue: user.name,
                      onChanged: (value) {
                        ref
                            .read(systemUserFormRequestProvider(user).notifier)
                            .updateWith(name: value);
                      },
                      decoration: const InputDecoration(
                          labelText: 'Name', contentPadding: EdgeInsets.all(8)),
                    ),
                    const SizedBox(height: 24),
                    AdaptiveTextField(
                      autocorrect: false,
                      initialValue: user.username,
                      onChanged: (value) {
                        ref
                            .read(systemUserFormRequestProvider(user).notifier)
                            .updateWith(username: value);
                      },
                      decoration: const InputDecoration(
                          labelText: 'Username',
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    const SizedBox(height: 24),
                    AdaptiveTextField(
                      autocorrect: false,
                      initialValue: user.email,
                      onChanged: (value) {
                        ref
                            .read(systemUserFormRequestProvider(user).notifier)
                            .updateWith(email: value);
                      },
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    const SizedBox(height: 24),
                    AdaptiveTextField(
                      autocorrect: false,
                      obscureText: true,
                      initialValue: formData.password,
                      onChanged: (value) {
                        if (value == '') {
                          ref
                              .read(
                                  systemUserFormRequestProvider(user).notifier)
                              .unsetWith(password: true);
                        } else {
                          ref
                              .read(
                                  systemUserFormRequestProvider(user).notifier)
                              .updateWith(password: value);
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        AdaptiveSwitch(
                          value: formData.alert ?? false,
                          onChanged: (value) {
                            ref
                                .read(systemUserFormRequestProvider(user)
                                    .notifier)
                                .updateWith(alert: value);
                          },
                        ),
                        const SizedBox(width: 12),
                        const AdaptiveTextBody('Send alert'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        AdaptiveSwitch(
                          value: formData.admin ?? false,
                          onChanged: (value) {
                            ref
                                .read(systemUserFormRequestProvider(user)
                                    .notifier)
                                .updateWith(admin: value);
                          },
                        ),
                        const SizedBox(width: 12),
                        const AdaptiveTextBody('Admin user'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        AdaptiveButton(
                          onPressed: () async {
                            if (user.id == null) {
                              await ref
                                  .read(systemUserFormRequestProvider(user)
                                      .notifier)
                                  .postUser();
                            } else {
                              await ref
                                  .read(systemUserFormRequestProvider(user)
                                      .notifier)
                                  .putUser(user.id!);
                            }
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                            await ref
                                .read(systemUserListProvider.notifier)
                                .loadRows();
                          },
                          child: const Text('Save'),
                        ),
                        AdaptiveTextButton(
                          onPressed: () async {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
