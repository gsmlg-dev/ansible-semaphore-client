import 'dart:async';

import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/components/run_task_form.dart';
import 'package:semaphore/components/status_chip.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/state/projects/task.dart';
import 'package:semaphore/utils/base_griddata.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'template_task.g.dart';
part 'template_task.freezed.dart';

class TemplateTaskDataTable extends BaseGridData<Task> {
  @override
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Task ID',
      field: 'task',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        return Consumer(builder: (context, ref, _) {
          return TextButton(
            child: Text('#${renderContext.cell.value.id}'),
            onPressed: () {
              ref
                  .read(taskListProvider.notifier)
                  .showOutput(context, renderContext.cell.value.id!);
            },
          );
        });
      },
    ),
    PlutoColumn(
      title: 'Version',
      field: 'version',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final String? value = renderContext.cell.value;
        if (value == 'null') return const Text('--');
        return Text(value ?? '--');
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
        if (value == null) {
          return const Text('--');
        }
        return Text(timeago.format(value));
      },
    ),
    PlutoColumn(
      title: 'Duration',
      field: 'duration',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final [start, end] = renderContext.cell.value;
        final DateTime endTime = end ?? DateTime.now();
        if (start == null) {
          return const Text('--');
        }
        final DateTime startTime = start;
        final d = endTime.difference(startTime);
        return Text('${d.inSeconds}s');
      },
    ),
    PlutoColumn(
      title: 'Actions',
      field: 'actions',
      type: PlutoColumnType.text(),
      minWidth: 140,
      renderer: (PlutoColumnRendererContext renderContext) {
        final Task value = renderContext.cell.value;
        return Consumer(builder: (context, ref, _) {
          return TextButton.icon(
              onPressed: () {
                ref
                    .read(
                        templateTaskListProvider(templateId: value.templateId!)
                            .notifier)
                    .prepareRunTask(context);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('RERUN'));
        });
      },
    ),
  ];

  TemplateTaskDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(
        columnSize: PlutoGridColumnSizeConfig(
      autoSizeMode: PlutoAutoSizeMode.scale,
    )),
  });

  TemplateTaskDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return TemplateTaskDataTable(
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
                'actions': PlutoCell(value: rowData),
              },
            ))
        .toList();
  }
}

@riverpod
class TemplateTaskList extends _$TemplateTaskList {
  Timer? timer;

  @override
  TemplateTaskDataTable build({required int templateId}) {
    return TemplateTaskDataTable(rows: <PlutoRow>[]);
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
    final api = ref.read(semaphoreApiProvider).getTaskApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdTemplatesTemplateIdTasksLastGet(
        projectId: current?.id ?? 1, templateId: templateId);
    return resp.data ?? <Task>[];
  }

  void prepareRunTask(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog.fullscreen(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            child: RunTaskFrom(
              templateId: templateId,
            ),
          );
        });
  }

  Future<void> runTask({
    int? templateId,
    bool? debug,
    bool? dryRun,
    bool? diff,
    String? playbook,
    String? environment,
    String? limit,
  }) async {
    try {
      final api = ref.read(semaphoreApiProvider).getProjectApi();
      final current = await ref.read(currentProjectProvider.future);
      await api.projectProjectIdTasksPost(
          projectId: current!.id!,
          task: ProjectProjectIdTasksPostRequest(
            templateId: templateId,
            debug: debug,
            dryRun: dryRun,
            diff: diff,
            playbook: playbook,
            environment: environment,
            limit: limit,
          ));
      loadRows(noRefresh: true);
    } catch (e) {
      print(e);
    }
  }
}

@freezed
class RunTaskFormState with _$RunTaskFormState {
  const factory RunTaskFormState({
    @Default('') String message,
    @Default({}) Map<String, String> environment,
    @Default(false) bool debug,
    @Default(false) bool dryRun,
    @Default(false) bool diff,
    String? playbook,
    String? limit,
    @Default(false) bool isSubmitting,
    String? errorString,
  }) = _RunTaskFormState;
}

@riverpod
class RunTaskFormData extends _$RunTaskFormData {
  @override
  RunTaskFormState build() {
    return const RunTaskFormState();
  }

  updateWith({
    String? message,
    Map<String, String>? environment,
    bool? debug,
    bool? dryRun,
    bool? diff,
    String? playbook,
    String? limit,
    bool? isSubmitting,
    String? errorString,
  }) {
    state = state.copyWith(
      message: message ?? state.message,
      debug: debug ?? state.debug,
      dryRun: dryRun ?? state.dryRun,
      diff: diff ?? state.diff,
      playbook: playbook,
      environment: environment ?? state.environment,
      limit: limit,
      isSubmitting: isSubmitting ?? state.isSubmitting,
      errorString: errorString,
    );
  }

  updateSurveyVal(String name, String value) {
    state = state.copyWith(
      environment: {...state.environment, name: value},
    );
  }
}
