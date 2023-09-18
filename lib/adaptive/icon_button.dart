import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class AdaptiveIconButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData? iconData;

  const AdaptiveIconButton({
    super.key,
    this.onPressed,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return MacosIconButton(onPressed: onPressed, icon: MacosIcon(iconData));
    }
    return IconButton(
      onPressed: onPressed,
      icon: Icon(iconData),
    );
  }
}
