import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';
import 'package:semaphore/state/projects/environment.dart';

class EnvironmentForm extends ConsumerWidget {
  final int? environmentId;
  const EnvironmentForm({super.key, this.environmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;
    final environment = ref.watch(environmentFamily(environmentId));
    final formData =
        ref.watch(environmentFormRequestProvider(environment.value));

    return environment.when(
      data: (environment) {
        return SingleChildScrollView(
          child: Form(
            child: Column(children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(24),
                child: Text(
                    environment.id == null
                        ? 'New Environment'
                        : 'Edit Environment',
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
                      .read(
                          environmentFormRequestProvider(environment).notifier)
                      .updateWith(name: value);
                },
                decoration: const InputDecoration(
                    labelText: 'Name', contentPadding: EdgeInsets.all(8)),
              ),
              NeumorphicTextFormField(
                margin: const EdgeInsets.all(24),
                depth: -4,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                autocorrect: false,
                initialValue: formData.json,
                onChanged: (value) {
                  ref
                      .read(
                          environmentFormRequestProvider(environment).notifier)
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
              NeumorphicTextFormField(
                margin: const EdgeInsets.all(24),
                depth: -4,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                autocorrect: false,
                initialValue: formData.env,
                onChanged: (value) {
                  ref
                      .read(
                          environmentFormRequestProvider(environment).notifier)
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
              Neumorphic(
                style: neumorphicTheme.styleWith(depth: -4),
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                child: SelectableText.rich(TextSpan(children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(Icons.info_rounded,
                          color: theme.colorScheme.primary),
                    ),
                  ),
                  const TextSpan(
                      text:
                          'Environment and extra variables must be valid JSON. Example:\n'),
                  TextSpan(text: '''{
	"ANSIBLE_HOST_KEY_CHECKING": "false",
  "ANSIBLE_GATHER_SUBSET": "!all"
}''', style: theme.textTheme.bodyMedium)
                ])),
              ),
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
                            .read(environmentFormRequestProvider(environment)
                                .notifier)
                            .postEnvironment();
                        if (context.mounted) Navigator.of(context).pop();
                        ref.read(environmentListProvider.notifier).loadRows();
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
