import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/components/macos/text_field.dart';

class AdaptiveTextField extends StatelessWidget {
  final String? initialValue;
  final void Function(String)? onChanged;
  final InputDecoration? decoration;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final Iterable<String>? autofillHints;
  final int? minLines;
  final int? maxLines;

  const AdaptiveTextField({
    super.key,
    this.initialValue,
    this.onChanged,
    this.decoration,
    this.obscureText = false,
    this.enableSuggestions = false,
    this.autocorrect = false,
    this.autofillHints,
    this.minLines,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      final theme = MacosTheme.of(context);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          decoration?.labelText != null
              ? Text(decoration!.labelText!, style: theme.typography.headline)
              : Container(),
          MacosTextFormField(
            initialValue: initialValue,
            obscureText: obscureText,
            enableSuggestions: enableSuggestions,
            autocorrect: autocorrect,
            autofillHints: autofillHints,
            onChanged: onChanged,
            minLines: minLines,
            maxLines: maxLines,
          ),
        ],
      );
    }
    return TextFormField(
      initialValue: initialValue,
      decoration: decoration,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      autofillHints: autofillHints,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
