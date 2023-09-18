import 'dart:async';

import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/components/environment_name.dart';
import 'package:semaphore/components/inventory_name.dart';
import 'package:semaphore/components/repository.dart';
import 'package:semaphore/components/status_chip.dart';
import 'package:semaphore/components/template_link.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/state/projects/template_task.dart';
import 'package:semaphore/utils/base_griddata.dart';

part 'template.g.dart';

class TemplateDataTable extends BaseGridData<Template> {
  @override
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
      minWidth: 180,
      renderer: (PlutoColumnRendererContext renderContext) {
        final value = renderContext.cell.value;
        return TemplateLink(templateId: value.id);
      },
    ),
    PlutoColumn(
      title: 'Status',
      field: 'status',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final Task? value = renderContext.cell.value;
        return StatusChip(status: value?.status);
      },
    ),
    PlutoColumn(
      title: 'Playbook',
      field: 'playbook',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Inventory',
      field: 'inventory',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final value = renderContext.cell.value;
        return InventoryName(id: value);
      },
    ),
    PlutoColumn(
      title: 'Environment',
      field: 'environment',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final value = renderContext.cell.value;
        return EnvironmentName(id: value);
      },
    ),
    PlutoColumn(
      title: 'Repository',
      field: 'repository',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final value = renderContext.cell.value;
        return RepositoryName(id: value);
      },
    ),
    PlutoColumn(
      title: 'Actions',
      field: 'actions',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final value = renderContext.cell.value;
        return Consumer(builder: (context, ref, _) {
          return AdaptiveIconButton(
            onPressed: () {
              ref
                  .read(templateTaskListProvider(templateId: value.id).notifier)
                  .prepareRunTask(context);
            },
            iconData: (Icons.play_arrow),
          );
        });
      },
    ),
  ];

  TemplateDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(
        columnSize: PlutoGridColumnSizeConfig(
      autoSizeMode: PlutoAutoSizeMode.scale,
    )),
  });

  TemplateDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return TemplateDataTable(
      rows: rows ?? this.rows,
      stateManager: stateManager ?? this.stateManager,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  List<PlutoRow> mapData(List<Template> data) {
    return data
        .map<PlutoRow>((rowData) => PlutoRow(
              cells: {
                'name': PlutoCell(value: rowData),
                'status': PlutoCell(value: rowData.lastTask),
                'playbook': PlutoCell(value: rowData.playbook),
                'inventory': PlutoCell(value: rowData.inventoryId),
                'environment': PlutoCell(value: rowData.environmentId),
                'repository': PlutoCell(value: rowData.repositoryId),
                'actions': PlutoCell(value: rowData),
              },
            ))
        .toList();
  }
}

@riverpod
class TemplateList extends _$TemplateList {
  Timer? timer;

  @override
  TemplateDataTable build() {
    return TemplateDataTable(rows: <PlutoRow>[]);
  }

  void setStateManager(PlutoGridStateManager stateManager) {
    state = state.copyWith(stateManager: stateManager);
    loadRows();
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      loadRows(noRefresh: true);
    });
    ref.onDispose(() {
      timer?.cancel();
    });
  }

  Future<void> loadRows({bool? noRefresh}) async {
    if (noRefresh != true) state.stateManager!.setShowLoading(true);
    final data = await loadData();

    final rows = state.mapData(data);
    final newRows = PlutoGridStateManager.initializeRows(state.columns, rows);

    state = state.copyWith(rows: newRows);
    state.stateManager!.refRows.clear();
    state.stateManager!.refRows.addAll(newRows);
    if (noRefresh != true) state.stateManager!.setShowLoading(false);
  }

  Future<List<Template>> loadData() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdTemplatesGet(
        projectId: current?.id ?? 1, sort: 'name', order: 'asc');
    return resp.data ?? <Template>[];
  }
}

@riverpod
Future<List<Template>> template(TemplateRef ref) async {
  try {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdTemplatesGet(
        projectId: current?.id ?? 1, sort: 'name', order: 'asc');
    return resp.data ?? <Template>[];
  } catch (e) {
    return <Template>[];
  }
}

@riverpod
Future<Template> templateFamily(TemplateFamilyRef ref, int? id) async {
  if (id == null) return Template();
  try {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdTemplatesTemplateIdGet(
        projectId: current?.id ?? 1, templateId: id);
    return resp.data ?? Template();
  } catch (e) {
    return Template();
  }
}
