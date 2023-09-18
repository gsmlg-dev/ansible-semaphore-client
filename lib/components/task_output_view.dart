import 'dart:io' show Platform;

import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/components/status_chip.dart';
import 'package:semaphore/state/projects/task.dart';

class TaskOutputView extends ConsumerWidget {
  final int id;

  const TaskOutputView({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final macosTheme = MacosTheme.of(context);
    final task = ref.watch(taskFamilyProvider(id));
    final taskOutput = ref.watch(taskOutputStreamProvider(id));

    Color bgColor = theme.colorScheme.surface;
    Color textColor = theme.colorScheme.onSurface;

    bool isDark = theme.brightness.isDark;

    if (Platform.isMacOS) {
      bgColor = macosTheme.canvasColor;
      textColor = macosTheme.typography.body.color ?? macosTheme.primaryColor;

      isDark = macosTheme.brightness.isDark;
    }

    return task.when(
      data: (task) {
        return Container(
          color: bgColor,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Task #${task.id}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: textColor),
                  ),
                  const SizedBox(width: 16),
                  Material(
                    color: bgColor,
                    child: StatusChip(status: task.status),
                  ),
                  const Spacer(),
                  AdaptiveIconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconData: (Icons.close))
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: taskOutput.when(
                    data: (List<TaskOutput> taskOutput) =>
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: taskOutput
                                .map((line) => SelectableText.rich(TextSpan(
                                        text: line.time?.toLocal().toString() ??
                                            '',
                                        style: GoogleFonts.robotoMono(
                                          textStyle: TextStyle(
                                              color: isDark
                                                  ? Colors.lightGreenAccent
                                                  : Colors.lightGreen),
                                        ),
                                        children: <InlineSpan>[
                                          const TextSpan(text: '\t'),
                                          TextSpan(
                                            text: line.output?.replaceAll(
                                                    RegExp(
                                                        r'\u001b\[([0-9;]+)m'),
                                                    '') ??
                                                '',
                                            style: GoogleFonts.robotoMono(
                                              textStyle:
                                                  TextStyle(color: textColor),
                                            ),
                                          ),
                                        ])))
                                .toList(),
                          ),
                        ),
                    loading: () => Center(
                        child: Platform.isMacOS
                            ? const ProgressCircle()
                            : const CircularProgressIndicator()),
                    error: (error, stackTrace) => const Text('N/A')),
              ),
            ],
          ),
        );
      },
      loading: () => Center(
          child: Platform.isMacOS
              ? const ProgressCircle()
              : const CircularProgressIndicator()),
      error: (error, stackTrace) => const Text('N/A'),
    );
  }
}
