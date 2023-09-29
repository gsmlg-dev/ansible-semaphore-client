import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/checkbox.dart';
import 'package:semaphore/adaptive/text.dart';
import 'package:semaphore/adaptive/text_field.dart';
import 'package:semaphore/state/projects.dart';

class ProjectForm extends ConsumerWidget {
  final int? projectId;
  const ProjectForm({super.key, this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final project = ref.watch(projectFamilyProvider(projectId)).value;
    final formData = ref.watch(projectFormStateProvider(project));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(24),
              child: const AdaptiveTextTitle('New Project'),
            ),
            const SizedBox(height: 24),
            AdaptiveTextField(
              autocorrect: false,
              initialValue: formData.name,
              onChanged: (value) {
                ref
                    .read(projectFormStateProvider(project).notifier)
                    .updateWith(name: value);
              },
              decoration: const InputDecoration(
                  labelText: 'Project Name', contentPadding: EdgeInsets.all(8)),
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
                        .read(projectFormStateProvider(project).notifier)
                        .updateWith(alert: value);
                  },
                ),
                const SizedBox(
                  width: 12.0,
                ),
                const AdaptiveTextBody('Allow alerts for this project'),
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
                    .read(projectFormStateProvider(project).notifier)
                    .updateWith(alertChat: value);
              },
              decoration: const InputDecoration(
                  labelText: 'Telegram Chat ID (Optional)',
                  contentPadding: EdgeInsets.all(8)),
            ),
            const SizedBox(
              height: 24.0,
            ),
            AdaptiveTextField(
              autocorrect: false,
              // ignore: prefer_null_aware_operators
              initialValue: formData.maxParallelTasks == null
                  ? null
                  : formData.maxParallelTasks.toString(),
              onChanged: (value) {
                ref
                    .read(projectFormStateProvider(project).notifier)
                    .updateWith(maxParallelTasks: int.tryParse(value) ?? 0);
              },
              decoration: const InputDecoration(
                  labelText: 'Max number of parallel tasks (Optional)',
                  contentPadding: EdgeInsets.all(8)),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                AdaptiveButton(
                  onPressed: () async {
                    await ref
                        .read(projectsProvider.notifier)
                        .createProject(formData);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
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
  }
}
