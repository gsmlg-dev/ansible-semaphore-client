import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class AdaptiveIconButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget icon;
  final String? label;

  const AdaptiveIconButton({
    super.key,
    this.onPressed,
    this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return MacosIconButton(
        semanticLabel: label,
        onPressed: onPressed,
        icon: icon,
      );
    }
    return IconButton(
      tooltip: label,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
