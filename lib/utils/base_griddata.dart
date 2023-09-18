import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:pluto_grid/pluto_grid.dart';

abstract class BaseGridData<T> {
  List<T> data = [];
  List<PlutoColumn> columns = <PlutoColumn>[];
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  PlutoGridConfiguration configuration = const PlutoGridConfiguration();

  BaseGridData({
    required this.rows,
    this.stateManager,
    this.configuration = const PlutoGridConfiguration(),
  });

  List<PlutoRow> mapData(List<T> data);

  // Future<List<PlutoRow>> asyncMapDataWithRef(
  //     List<T> data, AutoDisposeNotifierProviderRef<BaseGridData> ref);

  PlutoGridConfiguration configurationWithTheme(BuildContext context) {
    if (Platform.isMacOS) {
      final theme = MacosTheme.of(context);
      return configuration.copyWith(
          style: configuration.style.copyWith(
        gridBackgroundColor: theme.canvasColor,
        rowColor: theme.canvasColor,
        oddRowColor: PlutoOptional(_darken(theme.canvasColor)),
        evenRowColor: PlutoOptional(theme.canvasColor),
        activatedColor: _darken(theme.canvasColor, 0.125),
        borderColor: theme.dividerColor,
        cellTextStyle: theme.typography.body,
        columnTextStyle: theme.typography.headline,
      ));
    }
    final theme = Theme.of(context);
    return configuration.copyWith(
        style: configuration.style.copyWith(
      gridBackgroundColor: theme.colorScheme.secondaryContainer,
      rowColor: theme.colorScheme.secondaryContainer,
      oddRowColor: PlutoOptional(_darken(theme.colorScheme.secondaryContainer)),
      evenRowColor: PlutoOptional(theme.colorScheme.secondaryContainer),
      borderColor: theme.colorScheme.tertiary,
      cellTextStyle: theme.textTheme.bodyMedium,
      columnTextStyle: theme.textTheme.titleMedium,
    ));
  }

  Color _darken(Color color, [double amount = .05]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
