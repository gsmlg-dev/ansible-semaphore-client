import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:semaphore/adaptive/alert_dialog.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/checkbox.dart';
import 'package:semaphore/adaptive/scaffold.dart';
import 'package:semaphore/adaptive/tab_view.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/adaptive/text_field.dart';
import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/components/app_drawer.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/state/projects/task.dart';
import 'package:semaphore/state/projects/activity.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});
  static const name = 'projectDashboard';
  static const path = '/projects/:pid/dashboard';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveScaffold(
        drawer: const LocalDrawer(),
        appBar: const LocalAppBar(title: 'Dashboard'),
        body: SafeArea(
          child: AdaptiveTabView(
            tabs: const ['Hisotry', 'Activity', 'Settings'],
            children: [
              Consumer(builder: (context, ref, _) {
                final taskList = ref.watch(taskListProvider);

                return PlutoGrid(
                  mode: PlutoGridMode.readOnly,
                  columns: taskList.columns,
                  rows: taskList.rows,
                  noRowsWidget: null,
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    ref
                        .read(taskListProvider.notifier)
                        .setStateManager(event.stateManager);
                  },
                  onChanged: (PlutoGridOnChangedEvent event) {},
                  configuration: taskList.configurationWithTheme(context),
                );
              }),
              Consumer(builder: (context, ref, _) {
                final activityList = ref.watch(activityListProvider);

                return PlutoGrid(
                  mode: PlutoGridMode.readOnly,
                  columns: activityList.columns,
                  rows: activityList.rows,
                  noRowsWidget: null,
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    ref
                        .read(activityListProvider.notifier)
                        .setStateManager(event.stateManager);
                  },
                  onChanged: (PlutoGridOnChangedEvent event) {},
                  configuration: activityList.configurationWithTheme(context),
                );
              }),
              Consumer(builder: (context, ref, _) {
                final currentProject = ref.watch(currentProjectProvider);

                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          child: currentProject.when(
                            data: (project) {
                              final formData =
                                  ref.watch(projectFormStateProvider(project));

                              return Column(
                                children: [
                                  AdaptiveTextField(
                                    autocorrect: false,
                                    initialValue: formData.name,
                                    onChanged: (value) {
                                      ref
                                          .read(
                                              projectFormStateProvider(project)
                                                  .notifier)
                                          .updateWith(name: value);
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'Project Name',
                                        contentPadding: EdgeInsets.all(8)),
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  Row(
                                    children: [
                                      AdaptiveCheckbox(
                                        value: formData.alert,
                                        onChanged: (bool value) {
                                          ref
                                              .read(projectFormStateProvider(
                                                      project)
                                                  .notifier)
                                              .updateWith(alert: value);
                                        },
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      const AdaptiveTextBody(
                                          'Allow alerts for this project'),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  AdaptiveTextField(
                                    autocorrect: false,
                                    initialValue: formData.alertChat,
                                    onChanged: (value) {
                                      ref
                                          .read(
                                              projectFormStateProvider(project)
                                                  .notifier)
                                          .updateWith(alertChat: value);
                                    },
                                    decoration: const InputDecoration(
                                        labelText:
                                            'Telegram Chat ID (Optional)',
                                        contentPadding: EdgeInsets.all(8)),
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  AdaptiveTextField(
                                    autocorrect: false,
                                    initialValue:
                                        formData.maxParallelTasks.toString(),
                                    onChanged: (value) {
                                      ref
                                          .read(
                                              projectFormStateProvider(project)
                                                  .notifier)
                                          .updateWith(
                                              maxParallelTasks:
                                                  int.tryParse(value) ?? 0);
                                    },
                                    decoration: const InputDecoration(
                                        labelText:
                                            'Max number of parallel tasks (Optional)',
                                        contentPadding: EdgeInsets.all(8)),
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AdaptiveButton(
                                        onPressed: () {
                                          ref
                                              .read(projectsProvider.notifier)
                                              .updateProject(formData);
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 36.0,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 36.0,
                                  ),
                                  Wrap(
                                    spacing: 12.0,
                                    runSpacing: 12.0,
                                    children: [
                                      AdaptiveButton(
                                        color: Colors.redAccent,
                                        onPressed: () {
                                          adaptiveAlertDialog(
                                            context: context,
                                            title: const AdaptiveTextTitle(
                                              'DELETE PROJECT',
                                            ),
                                            content: const Column(
                                              children: [
                                                AdaptiveTextBody(
                                                  'Are you sure you want to delete this project?',
                                                ),
                                                SizedBox(
                                                  height: 16.0,
                                                ),
                                                AdaptiveTextError(
                                                  'Once you delete a project, there is no going back. Please be certain.',
                                                ),
                                                SizedBox(
                                                  height: 16.0,
                                                ),
                                              ],
                                            ),
                                            primaryButton: AdaptiveButton(
                                              color: Colors.redAccent,
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                await ref
                                                    .read(projectsProvider
                                                        .notifier)
                                                    .deleteProject(project!);
                                              },
                                              child: const Text('DELETE'),
                                            ),
                                            secondaryButton: AdaptiveButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('CANCEL'),
                                            ),
                                          );
                                        },
                                        child: const Text('DELETE PROJECT'),
                                      ),
                                      const AdaptiveTextError(
                                        'Once you delete a project, there is no going back. Please be certain.',
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                            loading: () => const LinearProgressIndicator(),
                            error: (error, stackTrace) => SizedBox(
                              child: Text(error.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ));
  }
}
