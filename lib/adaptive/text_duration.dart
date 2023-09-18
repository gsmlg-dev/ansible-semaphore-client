import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class AdaptiveTextDuration extends StatelessWidget {
  final DateTime? start;
  final DateTime? end;

  const AdaptiveTextDuration(this.start, this.end, {super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime endTime = end ?? DateTime.now();
    if (Platform.isMacOS) {
      final theme = MacosTheme.of(context);
      if (start == null) {
        return Text('--', style: theme.typography.body);
      }
      final DateTime startTime = start!;
      final d = endTime.difference(startTime);
      return Text('${d.inSeconds} ${d.inSeconds > 1 ? "seconds" : "second"}',
          style: theme.typography.body);
    }
    if (start == null) {
      return const Text('--');
    }
    final DateTime startTime = start!;
    final d = endTime.difference(startTime);
    return Text('${d.inSeconds} ${d.inSeconds > 1 ? "seconds" : "second"}');
  }
}
