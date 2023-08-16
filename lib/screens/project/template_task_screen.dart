import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/components/app_drawer.dart';
import 'package:semaphore/components/environment_name.dart';
import 'package:semaphore/components/inventory_name.dart';
import 'package:semaphore/components/repository.dart';
import 'package:semaphore/state/projects/template.dart';
import 'package:semaphore/state/projects/template_task.dart';

class TemplateTaskScreen extends ConsumerWidget {
  static const name = 'template_tasks';
  static const path = ':tid/tasks';

  final int templateId;
  const TemplateTaskScreen({super.key, required this.templateId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;

    // final currentProject = ref.watch(currentProjectProvider);
    final template = ref.watch(templateFamilyProvider(templateId));
    final taskList =
        ref.watch(templateTaskListProvider(templateId: templateId));

    return Scaffold(
      drawer: const LocalDrawer(),
      appBar: template.when(
        data: (template) =>
            LocalAppBar(title: 'Task Template -> ${template.name}'),
        loading: () => const LocalAppBar(title: 'Task Template Loading'),
        error: (error, stack) => const LocalAppBar(title: 'Task Error'),
      ),
      floatingActionButton: NeumorphicFloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          ref
              .read(templateTaskListProvider(templateId: templateId).notifier)
              .prepareRunTask(context);
        },
      ),
      body: NeumorphicBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              template.when(
                data: (template) => Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Playbook', style: theme.textTheme.titleMedium),
                        Text(template.playbook ?? '--',
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type', style: theme.textTheme.titleMedium),
                        Text('Task', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inventory', style: theme.textTheme.titleMedium),
                        InventoryName(id: template.inventoryId),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Environment', style: theme.textTheme.titleMedium),
                        EnvironmentName(id: template.environmentId),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Repository', style: theme.textTheme.titleMedium),
                        RepositoryName(id: template.repositoryId),
                      ],
                    ),
                  ],
                ),
                loading: () => const LinearProgressIndicator(),
                error: (error, stack) => Text('Error: $error'),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: PlutoGrid(
                  mode: PlutoGridMode.readOnly,
                  columns: taskList.columns,
                  rows: taskList.rows,
                  noRowsWidget: null,
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    ref
                        .read(templateTaskListProvider(templateId: templateId)
                            .notifier)
                        .setStateManager(event.stateManager);
                  },
                  configuration: taskList.configurationWithTheme(theme),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
