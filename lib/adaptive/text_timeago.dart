import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdaptiveTextTimeago extends StatelessWidget {
  final DateTime? data;

  const AdaptiveTextTimeago(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      final theme = MacosTheme.of(context);
      if (data == null) {
        return Text('--', style: theme.typography.body);
      }
      return Text(timeago.format(data!), style: theme.typography.body);
    }
    if (data == null) {
      return const Text('--');
    }
    return Text(timeago.format(data!));
  }
}
