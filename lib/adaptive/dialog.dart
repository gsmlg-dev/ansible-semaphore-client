import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

adaptiveDialog({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isMacOS) {
    showMacosSheet(
      context: context,
      barrierDismissible: true,
      builder: (_) => MacosSheet(
        child: child,
      ),
    );
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog.fullscreen(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            child: child,
          );
        });
  }
}
