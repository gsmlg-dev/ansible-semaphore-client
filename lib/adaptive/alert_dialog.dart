import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

import 'button.dart';

adaptiveAlertDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required AdaptiveButton primaryButton,
  AdaptiveButton? secondaryButton,
}) {
  if (Platform.isMacOS) {
    showMacosAlertDialog(
      context: context,
      builder: (context) => MacosAlertDialog(
        appIcon: const SizedBox(),
        title: title,
        message: content,
        //horizontalActions: false,
        primaryButton: PushButton(
          controlSize: ControlSize.large,
          onPressed: primaryButton.onPressed,
          child: primaryButton.child,
        ),
        secondaryButton: secondaryButton != null
            ? PushButton(
                secondary: true,
                controlSize: ControlSize.large,
                onPressed: secondaryButton.onPressed,
                child: secondaryButton.child,
              )
            : null,
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: title,
          content: content,
          actions: secondaryButton == null
              ? <Widget>[
                  TextButton(
                    onPressed: primaryButton.onPressed,
                    child: primaryButton.child,
                  ),
                ]
              : <Widget>[
                  TextButton(
                    onPressed: secondaryButton.onPressed,
                    child: secondaryButton.child,
                  ),
                  TextButton(
                    onPressed: primaryButton.onPressed,
                    child: primaryButton.child,
                  ),
                ],
        );
      },
    );
  }
}
