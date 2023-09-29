import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class AdaptiveTabView extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> children;
  final int initialIndex;

  const AdaptiveTabView({
    super.key,
    required this.tabs,
    required this.children,
    this.initialIndex = 0,
  });

  @override
  State<StatefulWidget> createState() => _AdaptiveTabViewState();
}

class _AdaptiveTabViewState extends State<AdaptiveTabView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late MacosTabController _macosTabController;

  @override
  initState() {
    super.initState();
    final length = widget.tabs.length;
    _tabController = TabController(
        length: length, vsync: this, initialIndex: widget.initialIndex);
    _macosTabController =
        MacosTabController(length: length, initialIndex: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return MacosTabView(
        controller: _macosTabController,
        tabs: widget.tabs.map<MacosTab>((tab) => MacosTab(label: tab)).toList(),
        children: widget.children,
      );
    }
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          color: theme.colorScheme.primary,
          child: TabBar(
            controller: _tabController,
            tabs: widget.tabs
                .map<Tab>((tab) => Tab(
                    child: Text(tab,
                        style: const TextStyle()
                            .copyWith(color: theme.colorScheme.onPrimary))))
                .toList(),
          ),
        ),
        Flexible(
          child: TabBarView(
            clipBehavior: Clip.none,
            controller: _tabController,
            children: widget.children,
          ),
        )
      ],
    );
  }
}
