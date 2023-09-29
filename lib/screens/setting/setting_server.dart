import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/alert_dialog.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/adaptive/text_timeago.dart';
import 'package:semaphore/components/server/form.dart';
import 'package:semaphore/state/auth.dart';
import 'package:semaphore/state/server.dart';

class ServerSetting extends ConsumerWidget {
  const ServerSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servers = ref.watch(serversProvider);
    Color? primaryColor = Theme.of(context).colorScheme.primary;
    if (Platform.isMacOS) {
      primaryColor = MacosTheme.of(context).primaryColor;
    }

    return SizedBox.expand(
      child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: [
                    const AdaptiveTextTitle('Manage Semaphore Servers'),
                    AdaptiveButton(
                      color: primaryColor,
                      child:
                          const Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.add, color: Colors.white),
                        Text('Add', style: TextStyle(color: Colors.white)),
                      ]),
                      onPressed: () {
                        adaptiveDialog(
                            context: context,
                            child: const ServerForm(serverId: null));
                      },
                    ),
                  ],
                ),
                DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'Active',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'ID',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'Name',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'API URL',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'Username',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'Created At',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: AdaptiveTextTitle(
                          'Actions',
                        ),
                      ),
                    ),
                  ],
                  rows: servers.map<DataRow>((s) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          s.isActive == true
                              ? const AdaptiveIcon(Icons.check_box_outlined)
                              : AdaptiveIconButton(
                                  onPressed: () {
                                    ref
                                        .read(serversProvider.notifier)
                                        .activeServer(s);
                                  },
                                  icon: const AdaptiveIcon(
                                      Icons.check_box_outline_blank)),
                        ),
                        DataCell(AdaptiveTextBody(s.id.toString())),
                        DataCell(AdaptiveTextBody(s.name!)),
                        DataCell(AdaptiveTextBody(s.apiUrl!)),
                        DataCell(AdaptiveTextBody(s.username!)),
                        DataCell(AdaptiveTextTimeago(s.createdAt)),
                        DataCell(Wrap(
                          children: [
                            AdaptiveIconButton(
                              onPressed: () {
                                adaptiveDialog(
                                    context: context,
                                    child: ServerForm(serverId: s.id));
                              },
                              icon: const AdaptiveIcon(Icons.edit),
                            ),
                            AdaptiveIconButton(
                              onPressed: () {
                                adaptiveAlertDialog(
                                  context: context,
                                  title:
                                      const AdaptiveTextTitle('Delete Server'),
                                  content: const AdaptiveTextBody(
                                      'Are you sure you want to delete this server?'),
                                  primaryButton: AdaptiveButton(
                                      color: Colors.redAccent,
                                      onPressed: () async {
                                        ref
                                            .read(serversProvider.notifier)
                                            .removeServer(s);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Delete')),
                                  secondaryButton: AdaptiveButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel')),
                                );
                              },
                              icon: const AdaptiveIcon(Icons.delete),
                            ),
                          ],
                        )),
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
          )),
    );
  }
}
