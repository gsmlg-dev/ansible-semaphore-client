import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:material_neumorphic/material_neumorphic.dart'
    show NeumorphicFloatingActionButton;

class AdaptiveFloatingAction {
  final Function()? onPressed;
  final Widget icon;
  final String label;

  const AdaptiveFloatingAction({
    this.onPressed,
    this.icon = const SizedBox(),
    this.label = '',
  });

  ToolbarItem toolBarIconButton() {
    return ToolBarIconButton(
      icon: icon,
      onPressed: onPressed,
      showLabel: false,
      label: label,
    );
  }

  Widget floatingActionButton() {
    return NeumorphicFloatingActionButton(
      onPressed: onPressed,
      child: icon,
    );
  }
}
