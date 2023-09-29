import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:material_neumorphic/material_neumorphic.dart';

class AdaptiveSwitch extends StatelessWidget {
  final void Function(bool)? onChanged;
  final bool value;

  const AdaptiveSwitch({
    super.key,
    this.onChanged,
    this.value = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return MacosSwitch(onChanged: onChanged, value: value);
    }
    return NeumorphicSwitch(
      value: value,
      onChanged: onChanged ?? (value) {},
    );
  }
}
