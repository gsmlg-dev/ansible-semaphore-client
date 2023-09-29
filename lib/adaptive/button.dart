import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:material_neumorphic/material_neumorphic.dart'
    show NeumorphicButton, NeumorphicTheme;

class AdaptiveButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final ControlSize controlSize;
  final Color? color;

  const AdaptiveButton({
    super.key,
    this.onPressed,
    this.color,
    this.child = const SizedBox(),
    this.controlSize = ControlSize.regular,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      // final macosTheme = MacosTheme.of(context);
      return PushButton(
          color: color,
          controlSize: controlSize,
          onPressed: onPressed,
          child: child);
    }
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;
    return NeumorphicButton(
      style: neumorphicTheme.styleWith(color: color),
      onPressed: onPressed,
      child: child,
    );
  }
}

class AdaptiveTextButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final ControlSize controlSize;

  const AdaptiveTextButton({
    super.key,
    this.onPressed,
    this.child = const SizedBox(),
    this.controlSize = ControlSize.regular,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return PushButton(
          secondary: true,
          controlSize: controlSize,
          onPressed: onPressed,
          child: child);
    }
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
