import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:material_neumorphic/material_neumorphic.dart';

class AdaptiveCheckbox extends StatelessWidget {
  final void Function(bool)? onChanged;
  final bool? value;

  const AdaptiveCheckbox({
    super.key,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return MacosCheckbox(onChanged: onChanged, value: value);
    }
    return NeumorphicCheckbox(
      value: value ?? false,
      onChanged: onChanged ?? (value) {},
    );
  }
}
