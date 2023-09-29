import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/switch.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/adaptive/text_field.dart';
import 'package:semaphore/state/server.dart';
import 'package:semaphore/state/user.dart';

class ServerForm extends ConsumerWidget {
  final int? serverId;
  const ServerForm({super.key, this.serverId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final server = ref.watch(serverFamilyProvider(serverId));
    final formData = ref.watch(serverFormStateProvider(server));

    final dataList = [
      formData.name,
      formData.apiUrl,
      formData.username,
      formData.password
    ];
    final canntGetToken = (dataList.contains('') || dataList.contains(null));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(24),
              child: AdaptiveTextTitle(
                server?.id == null ? 'New Server' : 'Edit Server',
              ),
            ),
            const SizedBox(height: 24),
            AdaptiveTextField(
              autocorrect: false,
              initialValue: formData.name,
              onChanged: (value) {
                ref
                    .read(serverFormStateProvider(server).notifier)
                    .updateWith(name: value);
              },
              decoration: const InputDecoration(
                  labelText: 'Name', contentPadding: EdgeInsets.all(8)),
            ),
            const SizedBox(height: 24),
            AdaptiveTextField(
              autocorrect: false,
              initialValue: formData.apiUrl,
              onChanged: (value) {
                ref
                    .read(serverFormStateProvider(server).notifier)
                    .updateWith(apiUrl: value);
              },
              decoration: const InputDecoration(
                  labelText: 'API URL', contentPadding: EdgeInsets.all(8)),
            ),
            const SizedBox(height: 24),
            AdaptiveTextField(
              autocorrect: false,
              initialValue: formData.username,
              onChanged: (value) {
                ref
                    .read(serverFormStateProvider(server).notifier)
                    .updateWith(username: value);
              },
              decoration: const InputDecoration(
                  labelText: 'Username', contentPadding: EdgeInsets.all(8)),
            ),
            const SizedBox(height: 24),
            AdaptiveTextField(
              autocorrect: false,
              obscureText: true,
              onChanged: (value) {
                ref
                    .read(serverFormStateProvider(server).notifier)
                    .updateWith(password: value);
              },
              decoration: const InputDecoration(
                  labelText: 'Password', contentPadding: EdgeInsets.all(8)),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                AdaptiveButton(
                  onPressed: canntGetToken
                      ? null
                      : () async {
                          // print(dataList);
                          // print(canntGetToken);
                          // return;
                          if (canntGetToken) {
                            return;
                          }
                          final token = await ref
                              .read(serverFormStateProvider(server).notifier)
                              .getTokenFromServer();
                          if (token != null) {
                            ref
                                .read(serverFormStateProvider(server).notifier)
                                .updateWith(token: token);
                          } else {
                            print('error get token');
                          }
                        },
                  child: const Text('Get Token from Server'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const AdaptiveTextBody('Token: '),
                const SizedBox(width: 24),
                Expanded(child: AdaptiveTextBody(formData.token ?? '--')),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                AdaptiveButton(
                  onPressed: formData.token == null || formData.token == ''
                      ? null
                      : () {
                          ref
                              .read(serversProvider.notifier)
                              .putServer(formData);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                  child: const Text('Save Server'),
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
  }
}
