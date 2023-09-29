import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class AdaptiveDropdownMenu<T> extends StatelessWidget {
  final T? value;
  final void Function(T?)? onChanged;
  final InputDecoration? decoration;
  final List<AdaptiveDropdownMenuItem<T?>>? items;

  const AdaptiveDropdownMenu({
    super.key,
    this.value,
    this.onChanged,
    this.decoration,
    this.items,
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
              : const SizedBox(),
          decoration?.labelText != null
              ? const SizedBox(height: 12.0)
              : const SizedBox(),
          MacosPopupButton<T?>(
            key: key,
            value: value,
            onChanged: onChanged,
            items: items
                ?.map<MacosPopupMenuItem<T?>>((item) => MacosPopupMenuItem(
                      key: item.key,
                      onTap: item.onTap,
                      enabled: item.enabled,
                      alignment: item.alignment,
                      value: item.value,
                      child: item.child,
                    ))
                .toList(),
          ),
        ],
      );
    }
    return DropdownButtonFormField<T?>(
      key: key,
      decoration: decoration,
      onChanged: onChanged,
      value: value,
      items: items
          ?.map<DropdownMenuItem<T?>>((item) => DropdownMenuItem(
                key: item.key,
                onTap: item.onTap,
                enabled: item.enabled,
                alignment: item.alignment,
                value: item.value,
                child: item.child,
              ))
          .toList(),
    );
  }
}

class AdaptiveDropdownMenuItem<T> extends StatelessWidget {
  final T? value;
  final Widget child;
  final void Function()? onTap;
  final bool enabled;
  final AlignmentGeometry alignment;

  const AdaptiveDropdownMenuItem({
    super.key,
    this.enabled = true,
    this.onTap,
    this.alignment = AlignmentDirectional.centerStart,
    this.value,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return MacosPopupMenuItem<T?>(
        key: key,
        onTap: onTap,
        enabled: enabled,
        alignment: alignment,
        value: value,
        child: child,
      );
    }
    return DropdownMenuItem<T?>(
      key: key,
      onTap: onTap,
      enabled: enabled,
      alignment: alignment,
      value: value,
      child: child,
    );
  }
}
