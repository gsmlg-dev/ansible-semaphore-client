import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/checkbox.dart';
import 'package:semaphore/adaptive/text_field.dart';
import 'package:semaphore/state/projects/template.dart';
import 'package:semaphore/state/projects/template_task.dart';

class RunTaskFrom extends ConsumerWidget {
  final int templateId;
  const RunTaskFrom({super.key, required this.templateId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);

    final template = ref.watch(templateFamilyProvider(templateId));
    final formData = ref.watch(runTaskFormDataProvider);

    final textTitleStyle = Platform.isMacOS
        ? macosTheme.typography.largeTitle
        : theme.textTheme.titleLarge;
    final textBodyStyle = Platform.isMacOS
        ? macosTheme.typography.body
        : theme.textTheme.bodyMedium;

    return template.when(
      data: (template) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Text(template.name!, style: textTitleStyle),
                    ),
                    AdaptiveTextField(
                      initialValue: formData.message,
                      onChanged: (value) => ref
                          .read(runTaskFormDataProvider.notifier)
                          .updateWith(message: value),
                      decoration: const InputDecoration(
                          labelText: 'Message(Optional)',
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    ...(template.surveyVars?.map((surveyVar) {
                          return AdaptiveTextField(
                            initialValue: formData.environment[surveyVar.name!],
                            onChanged: (value) {
                              ref
                                  .read(runTaskFormDataProvider.notifier)
                                  .updateSurveyVal(surveyVar.name!, value);
                            },
                            decoration: InputDecoration(
                                labelText: surveyVar.title,
                                contentPadding: const EdgeInsets.all(8)),
                          );
                        }).toList() ??
                        []),
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          AdaptiveCheckbox(
                              value: formData.debug,
                              onChanged: (value) {
                                ref
                                    .read(runTaskFormDataProvider.notifier)
                                    .updateWith(debug: value);
                              }),
                          const SizedBox(
                            width: 24,
                          ),
                          Text('Debug', style: textBodyStyle),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          AdaptiveCheckbox(
                              value: formData.dryRun,
                              onChanged: (value) {
                                ref
                                    .read(runTaskFormDataProvider.notifier)
                                    .updateWith(dryRun: value);
                              }),
                          const SizedBox(
                            width: 24,
                          ),
                          Text('Dry Run', style: textBodyStyle),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          AdaptiveCheckbox(
                              value: formData.diff,
                              onChanged: (value) {
                                ref
                                    .read(runTaskFormDataProvider.notifier)
                                    .updateWith(diff: value);
                              }),
                          const SizedBox(
                            width: 24,
                          ),
                          Text('Diff', style: textBodyStyle),
                        ],
                      ),
                    ),
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
                                onPressed: formData.isSubmitting
                                    ? null
                                    : () async {
                                        try {
                                          ref
                                              .read(runTaskFormDataProvider
                                                  .notifier)
                                              .updateWith(isSubmitting: true);
                                          await ref
                                              .read(templateTaskListProvider(
                                                      templateId: templateId)
                                                  .notifier)
                                              .runTask(
                                                templateId: templateId,
                                                debug: formData.debug,
                                                dryRun: formData.dryRun,
                                                diff: formData.diff,
                                                playbook: formData.playbook,
                                                environment: json.encode(
                                                  formData.environment,
                                                ),
                                                limit: formData.limit,
                                              );
                                          if (context.mounted)
                                            Navigator.of(context).pop();
                                        } catch (e) {
                                          ref
                                              .read(runTaskFormDataProvider
                                                  .notifier)
                                              .updateWith(
                                                  errorString: e.toString());
                                        } finally {
                                          ref
                                              .read(runTaskFormDataProvider
                                                  .notifier)
                                              .updateWith(isSubmitting: false);
                                        }
                                      },
                                child: const Text('Run')),
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
