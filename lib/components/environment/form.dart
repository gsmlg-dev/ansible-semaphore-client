import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/text_field.dart';
import 'package:semaphore/state/projects/environment.dart';

class EnvironmentForm extends ConsumerWidget {
  final int? environmentId;
  const EnvironmentForm({super.key, this.environmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final environment = ref.watch(environmentFamily(environmentId));
    final formData =
        ref.watch(environmentFormRequestProvider(environment.value));

    final textTitleStyle = Platform.isMacOS
        ? macosTheme.typography.largeTitle
        : theme.textTheme.titleLarge;
    final textBodyStyle = Platform.isMacOS
        ? macosTheme.typography.body
        : theme.textTheme.bodyMedium;

    return environment.when(
      data: (environment) {
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
                      child: Text(
                          environment.id == null
                              ? 'New Environment'
                              : 'Edit Environment',
                          style: textTitleStyle),
                    ),
                    AdaptiveTextField(
                      autocorrect: false,
                      initialValue: formData.name,
                      onChanged: (value) {
                        ref
                            .read(environmentFormRequestProvider(environment)
                                .notifier)
                            .updateWith(name: value);
                      },
                      decoration: const InputDecoration(
                          labelText: 'Name', contentPadding: EdgeInsets.all(8)),
                    ),
                    AdaptiveTextField(
                      autocorrect: false,
                      initialValue: formData.json,
                      onChanged: (value) {
                        ref
                            .read(environmentFormRequestProvider(environment)
                                .notifier)
                            .updateWith(json: value);
                      },
                      minLines: 5,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: 'Extra variables',
                          alignLabelWithHint: true,
                          hintText: 'Enter extra variables JSON...',
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    AdaptiveTextField(
                      autocorrect: false,
                      initialValue: formData.env,
                      onChanged: (value) {
                        ref
                            .read(environmentFormRequestProvider(environment)
                                .notifier)
                            .updateWith(env: value);
                      },
                      minLines: 5,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: 'Environment variables',
                          alignLabelWithHint: true,
                          hintText: 'Enter env JSON...',
                          contentPadding: EdgeInsets.all(8)),
                    ),
                    SelectableText.rich(TextSpan(children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(Icons.info_rounded,
                              color: theme.colorScheme.primary),
                        ),
                      ),
                      TextSpan(
                          text:
                              'Environment and extra variables must be valid JSON. Example:\n',
                          style: textBodyStyle),
                      TextSpan(text: '''{
    "ANSIBLE_HOST_KEY_CHECKING": "false",
    "ANSIBLE_GATHER_SUBSET": "!all"
}''', style: textBodyStyle)
                    ])),
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
                                      .read(environmentFormRequestProvider(
                                              environment)
                                          .notifier)
                                      .postEnvironment();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                  ref
                                      .read(environmentListProvider.notifier)
                                      .loadRows();
                                },
                                child: const Text('Create')),
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
