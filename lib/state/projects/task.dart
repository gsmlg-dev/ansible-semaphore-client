import 'dart:async';

import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/text_duration.dart';
import 'package:semaphore/adaptive/text_null.dart';
import 'package:semaphore/adaptive/text_timeago.dart';
import 'package:semaphore/components/status_chip.dart';
import 'package:semaphore/components/task_output_view.dart';
import 'package:semaphore/components/template_link.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/utils/base_griddata.dart';
import 'package:semaphore/adaptive/dialog.dart';

part 'task.g.dart';

class TaskDataTable extends BaseGridData<Task> {
  @override
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Task',
      field: 'task',
      type: PlutoColumnType.text(),
      minWidth: 320,
      renderer: (PlutoColumnRendererContext renderContext) {
        return Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Consumer(builder: (context, ref, _) {
                return TextButton(
                  child: Text('#${renderContext.cell.value.id}'),
                  onPressed: () {
                    ref
                        .read(taskListProvider.notifier)
                        .showOutput(context, renderContext.cell.value.id!);
                  },
                );
              }),
              const AdaptiveIcon(Icons.keyboard_arrow_left),
              TemplateLink(templateId: renderContext.cell.value.templateId),
            ]);
      },
    ),
    PlutoColumn(
      title: 'Version',
      field: 'version',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final String? value = renderContext.cell.value;
        return AdaptiveTextNull(value);
      },
    ),
    PlutoColumn(
      title: 'Status',
      field: 'status',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final value = renderContext.cell.value;
        return StatusChip(status: value);
      },
    ),
    PlutoColumn(
      title: 'Username',
      field: 'userName',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Start',
      field: 'start',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final DateTime? value = renderContext.cell.value;
        return AdaptiveTextTimeago(value);
      },
    ),
    PlutoColumn(
      title: 'Duration',
      field: 'duration',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final [start, end] = renderContext.cell.value;
        return AdaptiveTextDuration(start, end);
      },
    ),
  ];

  TaskDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(),
  });

  TaskDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return TaskDataTable(
      rows: rows ?? this.rows,
      stateManager: stateManager ?? this.stateManager,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  List<PlutoRow> mapData(List<Task> data) {
    return data
        .map<PlutoRow>((rowData) => PlutoRow(
              cells: {
                'task': PlutoCell(value: rowData),
                'version': PlutoCell(value: rowData.version),
                'status': PlutoCell(value: rowData.status),
                'userName': PlutoCell(value: rowData.userName),
                'start': PlutoCell(value: rowData.start),
                'duration': PlutoCell(value: [rowData.start, rowData.end]),
              },
            ))
        .toList();
  }
}

@riverpod
class TaskList extends _$TaskList {
  Timer? timer;

  @override
  TaskDataTable build() {
    return TaskDataTable(rows: <PlutoRow>[]);
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

  Future<List<Task>> loadData() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp =
        await api.projectProjectIdTasksLastGet(projectId: current?.id ?? 1);
    return resp.data ?? <Task>[];
  }

  showOutput(BuildContext context, int id) {
    adaptiveDialog(
      context: context,
      child: TaskOutputView(
        id: id,
      ),
    );
  }
}

@riverpod
Future<Task> taskFamily(TaskFamilyRef ref, int id) async {
  try {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdTasksTaskIdGet(
        projectId: current?.id ?? 1, taskId: id);
    return resp.data ?? Task();
  } catch (e) {
    return Task();
  }
}

@riverpod
Future<List<TaskOutput>> taskOutput(TaskOutputRef ref, int id) async {
  try {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdTasksTaskIdOutputGet(
        projectId: current?.id ?? 1, taskId: id);
    return resp.data ?? <TaskOutput>[];
  } catch (e) {
    return <TaskOutput>[];
  }
}

@riverpod
Stream<(Task, List<TaskOutput>)> taskOutputStream(
    TaskOutputStreamRef ref, int taskId) async* {
  Task task;
  do {
    task = await ref.read(taskFamilyProvider(taskId).future);
    final output = await ref.read(taskOutputProvider(taskId).future);
    yield (task, output);
    await Future.delayed(const Duration(seconds: 1));
  } while (task.status == 'waiting' || task.status == 'running');
}
