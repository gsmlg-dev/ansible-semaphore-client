
import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/components/status_chip.dart';
import 'package:semaphore/state/projects/task.dart';

class TaskOutputView extends ConsumerWidget {
  final int id;

  const TaskOutputView({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final task = ref.watch(taskFamilyProvider(id));
    final taskOutput = ref.watch(taskOutputStreamProvider(id));

    return task.when(
      data: (task) {
        return Container(
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Task #${task.id}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 16),
                  StatusChip(status: task.status),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: taskOutput.when(
                    data: (List<TaskOutput> taskOutput) => ListView(
                        children: taskOutput
                            .map((line) => Row(
                                  children: [
                                    Text(line.time?.toLocal().toString() ?? '',
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: theme.colorScheme
                                                    .onSurfaceVariant
                                                    .withOpacity(0.7))),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                            line.output?.replaceAll(
                                                    RegExp(
                                                        r'\u001b\[([0-9;]+)m'),
                                                    '') ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: theme.colorScheme
                                                        .onSurface)),
                                      ),
                                    ),
                                  ],
                                ))
                            .toList()),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => const Text('N/A')),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Text('N/A'),
    );
  }
}
