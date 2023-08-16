import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/router/router.dart';
import 'package:semaphore/screens/project/template_task_screen.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/state/projects/template.dart';

class TemplateLink extends ConsumerWidget {
  final int? templateId;

  const TemplateLink({super.key, this.templateId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pid = ref.watch(currentProjectProvider).value?.id;
    final template = ref.watch(templateFamilyProvider(templateId));

    return template.when(
      data: (template) => TextButton(
        style: ButtonStyle(
          alignment: Alignment.centerLeft, // <-- had to set alignment
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.zero, // <-- had to set padding to zero
          ),
        ),
        child: Text(
          template.name ?? '--',
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: () {
          ref.read(routerProvider).goNamed(TemplateTaskScreen.name,
              pathParameters: {'pid': '$pid', 'tid': '${template.id}'});
        },
      ),
      loading: () => const LinearProgressIndicator(),
      error: (error, stackTrace) =>
          const TextButton(onPressed: null, child: Text('N/A')),
    );
  }
}
