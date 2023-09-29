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
          color: primaryButton.color,
          controlSize: ControlSize.large,
          onPressed: primaryButton.onPressed,
          child: primaryButton.child,
        ),
        secondaryButton: secondaryButton != null
            ? PushButton(
                color: secondaryButton.color,
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
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: primaryButton.color))),
                    onPressed: primaryButton.onPressed,
                    child: primaryButton.child,
                  ),
                ]
              : <Widget>[
                  TextButton(
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: secondaryButton.color))),
                    onPressed: secondaryButton.onPressed,
                    child: secondaryButton.child,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: primaryButton.color))),
                    onPressed: primaryButton.onPressed,
                    child: primaryButton.child,
                  ),
                ],
        );
      },
    );
  }
}
