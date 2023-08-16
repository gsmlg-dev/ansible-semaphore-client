import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_neumorphic/material_neumorphic.dart';

class LocalAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  @override
  final Size preferredSize;

  const LocalAppBar({Key? key, String? title, this.actions = const []})
      : title = title ?? 'Ansible Semaphore',
        preferredSize = const Size.fromHeight(NeumorphicAppBar.toolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final neumorphicTheme = theme.extension<NeumorphicTheme>()!;
    final style = neumorphicTheme.getNeumorphicStyle();

    return NeumorphicAppBar(
      depth: -4,
      centerTitle: false,
      title: Text(
        title,
        style: theme.textTheme.headlineMedium!
            .copyWith(color: theme.colorScheme.onPrimary),
      ),
      leading: Builder(
        builder: (context) => NeumorphicButton(
            style: style.copyWith(color: theme.colorScheme.primary),
            child: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer()),
      ),
      actionSpacing: 16,
      actions: actions,
    );
  }
}
