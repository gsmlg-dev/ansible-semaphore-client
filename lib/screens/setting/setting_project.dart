import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/components/project/form.dart';
import 'package:semaphore/state/projects.dart';

class ProjectSetting extends ConsumerWidget {
  const ProjectSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? primaryColor = Theme.of(context).colorScheme.primary;
    if (Platform.isMacOS) {
      primaryColor = MacosTheme.of(context).primaryColor;
    }

    final projects = ref.watch(projectsProvider);
    final currentProject = ref.watch(currentProjectProvider);

    return SizedBox.expand(
        child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        children: [
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              const AdaptiveTextTitle('Switch Projects'),
              AdaptiveButton(
                color: primaryColor,
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.add, color: Colors.white),
                  Text('Add', style: TextStyle(color: Colors.white)),
                ]),
                onPressed: () {
                  adaptiveDialog(context: context, child: const ProjectForm());
                },
              ),
            ],
          ),
          ...projects.when(
            data: (projects) => projects
                .map((project) => ListTile(
                      leading: AdaptiveTextBody(project.id.toString()),
                      title: AdaptiveTextBody(project.name ?? '--'),
                      subtitle: AdaptiveTextBody(project.created ?? '--'),
                      trailing: currentProject.when(
                          data: (p) => p?.id == project.id
                              ? const IconButton(
                                  onPressed: null,
                                  icon:
                                      AdaptiveIcon(Icons.radio_button_checked))
                              : IconButton(
                                  onPressed: () {
                                    ref
                                        .read(currentProjectProvider.notifier)
                                        .setCurrent(project);
                                  },
                                  icon: const AdaptiveIcon(
                                      Icons.radio_button_unchecked)),
                          error: (error, stack) =>
                              AdaptiveTextBody('Error: ${error.toString()}'),
                          loading: () => const CircularProgressIndicator()),
                    ))
                .toList(),
            loading: () => [const Center(child: CircularProgressIndicator())],
            error: (error, stackTrace) => [
              const Text('Error'),
              Text(error.toString()),
            ],
          ),
        ],
      ),
    ));
  }
}
