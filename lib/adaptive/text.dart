import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class AdaptiveTextBody extends StatelessWidget {
  final String data;

  const AdaptiveTextBody(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      final theme = MacosTheme.of(context);
      return Text(data,
          style:
              theme.typography.body.copyWith(overflow: TextOverflow.ellipsis));
    }
    final theme = Theme.of(context);
    return Text(
      data,
      style:
          theme.textTheme.bodyMedium?.copyWith(overflow: TextOverflow.ellipsis),
    );
  }
}

class AdaptiveTextTitle extends StatelessWidget {
  final String data;

  const AdaptiveTextTitle(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      final theme = MacosTheme.of(context);
      return Text(data, style: theme.typography.title2);
    }
    final theme = Theme.of(context);
    return Text(data, style: theme.textTheme.titleMedium);
  }
}

class AdaptiveTextError extends StatelessWidget {
  final String data;

  const AdaptiveTextError(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      final theme = MacosTheme.of(context);
      return Text(data,
          style: theme.typography.body.copyWith(color: Colors.redAccent));
    }
    final theme = Theme.of(context);
    return Text(data,
        softWrap: true,
        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.redAccent));
  }
}
