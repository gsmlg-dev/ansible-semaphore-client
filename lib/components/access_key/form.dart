import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/state/projects/access_key.dart';

class AccessKeyForm extends ConsumerWidget {
  final int? accessKeyId;
  const AccessKeyForm({super.key, this.accessKeyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;
    final accessKey = ref.watch(accessKeyFamily(accessKeyId));
    final formData = ref.watch(accessKeyFormRequestProvider(accessKey.value));

    return accessKey.when(
      data: (accessKey) {
        return SingleChildScrollView(
          child: Form(
            child: Column(children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(24),
                child: Text(
                    accessKey.id == null ? 'New AccessKey' : 'Edit AccessKey',
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
                      .read(accessKeyFormRequestProvider(accessKey).notifier)
                      .updateWith(name: value);
                },
                decoration: const InputDecoration(
                    labelText: 'Key Name', contentPadding: EdgeInsets.all(8)),
              ),
              NeumorphicDropdownButtonFormField<AccessKeyRequestTypeEnum?>(
                margin: const EdgeInsets.all(24),
                depth: -4,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                isExpanded: true,
                dropdownColor: theme.colorScheme.secondaryContainer,
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.onSecondaryContainer),
                decoration: const InputDecoration(
                    labelText: 'Type', contentPadding: EdgeInsets.all(8)),
                value: formData.type,
                icon: Icon(Icons.expand_more,
                    color: theme.colorScheme.onSecondaryContainer),
                onChanged: (AccessKeyRequestTypeEnum? value) {
                  ref
                      .read(accessKeyFormRequestProvider(accessKey).notifier)
                      .updateWith(type: value);
                },
                items: AccessKeyRequestTypeEnum.values
                    .map<DropdownMenuItem<AccessKeyRequestTypeEnum>>(
                        (AccessKeyRequestTypeEnum value) {
                  return DropdownMenuItem<AccessKeyRequestTypeEnum>(
                    value: value,
                    child: Text(value.name,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer)),
                  );
                }).toList(),
              ),
              formData.type == AccessKeyRequestTypeEnum.ssh
                  ? Column(
                      children: [
                        NeumorphicTextFormField(
                          margin: const EdgeInsets.all(24),
                          depth: -4,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          autocorrect: false,
                          initialValue: formData.ssh?.login,
                          onChanged: (value) {
                            final AccessKeyRequestSsh ssh =
                                formData.ssh ?? AccessKeyRequestSsh();
                            ref
                                .read(accessKeyFormRequestProvider(accessKey)
                                    .notifier)
                                .updateWith(
                                    ssh: AccessKeyRequestSsh(
                                        login: value,
                                        privateKey: ssh.privateKey));
                          },
                          decoration: const InputDecoration(
                              labelText: 'Username (Optional)',
                              contentPadding: EdgeInsets.all(8)),
                        ),
                        NeumorphicTextFormField(
                          margin: const EdgeInsets.all(24),
                          depth: -4,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          autocorrect: false,
                          initialValue: formData.ssh?.privateKey,
                          onChanged: (value) {
                            final AccessKeyRequestSsh ssh =
                                formData.ssh ?? AccessKeyRequestSsh();
                            ref
                                .read(accessKeyFormRequestProvider(accessKey)
                                    .notifier)
                                .updateWith(
                                    ssh: AccessKeyRequestSsh(
                                        login: ssh.login, privateKey: value));
                          },
                          minLines: 5,
                          maxLines: null,
                          decoration: const InputDecoration(
                              labelText: 'Private Key',
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.all(8)),
                        ),
                      ],
                    )
                  : Container(),
              formData.type == AccessKeyRequestTypeEnum.loginPassword
                  ? Column(
                      children: [
                        NeumorphicTextFormField(
                          margin: const EdgeInsets.all(24),
                          depth: -4,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          autocorrect: false,
                          initialValue: formData.loginPassword?.login,
                          onChanged: (value) {
                            final AccessKeyRequestLoginPassword loginPassword =
                                formData.loginPassword ??
                                    AccessKeyRequestLoginPassword();
                            ref
                                .read(accessKeyFormRequestProvider(accessKey)
                                    .notifier)
                                .updateWith(
                                    loginPassword:
                                        AccessKeyRequestLoginPassword(
                                            login: value,
                                            password: loginPassword.password));
                          },
                          decoration: const InputDecoration(
                              labelText: 'Login (Optional)',
                              contentPadding: EdgeInsets.all(8)),
                        ),
                        NeumorphicTextFormField(
                          margin: const EdgeInsets.all(24),
                          depth: -4,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          autocorrect: false,
                          initialValue: formData.ssh?.login,
                          onChanged: (value) {
                            final AccessKeyRequestLoginPassword loginPassword =
                                formData.loginPassword ??
                                    AccessKeyRequestLoginPassword();
                            ref
                                .read(accessKeyFormRequestProvider(accessKey)
                                    .notifier)
                                .updateWith(
                                    loginPassword:
                                        AccessKeyRequestLoginPassword(
                                            login: loginPassword.login,
                                            password: value));
                          },
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              contentPadding: EdgeInsets.all(8)),
                        ),
                      ],
                    )
                  : Container(),
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
                            .read(accessKeyFormRequestProvider(accessKey)
                                .notifier)
                            .postAccessKey();
                        if (context.mounted) Navigator.of(context).pop();
                        ref.read(accessKeyListProvider.notifier).loadRows();
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
