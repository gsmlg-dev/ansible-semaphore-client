import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:material_neumorphic/material_neumorphic.dart'
    show NeumorphicButton;

class AdaptiveButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final ControlSize controlSize;

  const AdaptiveButton({
    super.key,
    this.onPressed,
    this.child = const SizedBox(),
    this.controlSize = ControlSize.regular,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return PushButton(
          controlSize: controlSize, onPressed: onPressed, child: child);
    }
    return NeumorphicButton(
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
