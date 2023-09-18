import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:semaphore/adaptive/floatingAction.dart';
import 'package:semaphore/components/app_bar.dart';
import 'package:semaphore/components/macos/sidebar.dart';

class AdaptiveScaffold extends ConsumerWidget {
  final Widget? drawer;
  final LocalAppBar? appBar;
  final Widget? body;
  final AdaptiveFloatingAction? floatingAction;
  final Widget? floatingActionButton;
  final Widget Function(BuildContext, ScrollController)? bodyBuilder;

  const AdaptiveScaffold({
    super.key,
    this.drawer,
    this.appBar,
    this.body,
    this.floatingAction,
    this.floatingActionButton,
    this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (Platform.isMacOS) {
      final toolbarAction = floatingAction?.toolBarIconButton();
      return MacosWindow(
          titleBar: appBar?.title != null
              ? TitleBar(title: Text(appBar!.title))
              : null,
          sidebar: buildSidebar(context),
          child: MacosScaffold(
            backgroundColor: const Color.fromRGBO(0xff, 0xff, 0xff, 0),
            toolBar: toolbarAction != null
                ? ToolBar(actions: [
                    toolbarAction,
                  ])
                : null,
            children: [
              ContentArea(builder: (context, scrollController) {
                if (bodyBuilder != null) {
                  return bodyBuilder!(context, scrollController);
                }
                return Material(
                    color: MacosTheme.of(context).canvasColor,
                    child: body ?? Container());
              }),
            ],
          ));
    }
    return Scaffold(
      drawer: drawer,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingAction != null
          ? floatingAction!.floatingActionButton()
          : floatingActionButton,
    );
  }
}
