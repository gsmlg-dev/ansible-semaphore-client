import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/components/environment/form.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/utils/base_griddata.dart';
import 'package:semaphore/adaptive/alert_dialog.dart';

part 'environment.g.dart';

class EnvironmentDataTable extends BaseGridData<Environment> {
  @override
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Action',
      field: 'actions',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext context) {
        final Environment environment = context.cell.value;
        return Consumer(builder: (context, ref, _) {
          return Wrap(
            children: [
              AdaptiveIconButton(
                onPressed: () {
                  adaptiveDialog(
                    context: context,
                    child: EnvironmentForm(environmentId: environment.id),
                  );
                },
                iconData: Icons.edit,
              ),
              AdaptiveIconButton(
                  onPressed: () {
                    adaptiveAlertDialog(
                      context: context,
                      title: const Text('Delete Environment'),
                      content: const Text(
                          'Are you sure you want to delete this environment?'),
                      secondaryButton: AdaptiveButton(
                          controlSize: ControlSize.large,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      primaryButton: AdaptiveButton(
                          controlSize: ControlSize.large,
                          onPressed: () async {
                            final api =
                                ref.read(semaphoreApiProvider).getProjectApi();
                            final current =
                                await ref.read(currentProjectProvider.future);
                            await api
                                .projectProjectIdEnvironmentEnvironmentIdDelete(
                                    projectId: current!.id!,
                                    environmentId: environment.id!);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                            ref
                                .read(environmentListProvider.notifier)
                                .loadRows();
                          },
                          child: const Text('Delete',
                              style: TextStyle(color: Colors.red))),
                    );
                  },
                  iconData: Icons.delete),
            ],
          );
        });
      },
    ),
  ];

  EnvironmentDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(),
  });

  EnvironmentDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return EnvironmentDataTable(
      rows: rows ?? this.rows,
      stateManager: stateManager ?? this.stateManager,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  List<PlutoRow> mapData(List<Environment> data) {
    return data
        .map<PlutoRow>((rowData) => PlutoRow(
              cells: {
                'name': PlutoCell(value: '${rowData.name}'),
                'actions': PlutoCell(value: rowData),
              },
            ))
        .toList();
  }
}

@riverpod
class EnvironmentList extends _$EnvironmentList {
  @override
  EnvironmentDataTable build() {
    return EnvironmentDataTable(rows: <PlutoRow>[]);
  }

  void setStateManager(PlutoGridStateManager stateManager) {
    state = state.copyWith(stateManager: stateManager);
    loadRows();
  }

  Future<void> loadRows() async {
    state.stateManager!.setShowLoading(true);
    final data = await loadData();

    final rows = state.mapData(data);
    final newRows = PlutoGridStateManager.initializeRows(state.columns, rows);

    state = state.copyWith(rows: newRows);
    state.stateManager!.refRows.clear();
    state.stateManager!.refRows.addAll(newRows);
    state.stateManager!.setShowLoading(false);
  }

  Future<List<Environment>> loadData() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdEnvironmentGet(
        projectId: current?.id ?? 1, sort: 'name', order: 'asc');
    return resp.data ?? <Environment>[];
  }
}

@riverpod
Future<List<Environment>> environment(EnvironmentRef ref) async {
  final api = ref.read(semaphoreApiProvider).getProjectApi();
  final current = await ref.read(currentProjectProvider.future);
  final resp = await api.projectProjectIdEnvironmentGet(
      projectId: current?.id ?? 1, sort: 'name', order: 'asc');
  return resp.data ?? <Environment>[];
}

final environmentFamily =
    FutureProvider.family<Environment, int?>((ref, id) async {
  final current = await ref.read(currentProjectProvider.future);
  if (id == null) {
    return Environment(
      projectId: current?.id ?? 1,
    );
  }
  final environments = await ref.read(environmentProvider.future);
  return environments.firstWhere((element) => element.id == id,
      orElse: () => Environment());
});

@riverpod
class EnvironmentFormRequest extends _$EnvironmentFormRequest {
  @override
  EnvironmentRequest build(Environment? item) {
    item ??= Environment();

    return EnvironmentRequest(
      name: item.name,
      projectId: item.projectId,
      password: item.password,
      json: item.json ?? '{}',
      env: item.env ?? '{}',
    );
  }

  void updateWith({
    String? name,
    int? projectId,
    String? password,
    String? json,
    String? env,
  }) {
    state = EnvironmentRequest(
      name: name ?? state.name,
      projectId: projectId ?? state.projectId,
      password: password ?? state.password,
      json: json ?? state.json,
      env: env ?? state.env,
    );
  }

  void unsetWith({
    bool? name,
    bool? projectId,
    bool? password,
    bool? json,
    bool? env,
  }) {
    state = EnvironmentRequest(
      name: name == true ? null : state.name,
      projectId: projectId == true ? null : state.projectId,
      password: password == true ? null : state.password,
      json: json == true ? null : state.json,
      env: env == true ? null : state.env,
    );
  }

  Future<Environment?> postEnvironment() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    if (item?.id == null) {
      final resp = await api.projectProjectIdEnvironmentPost(
          projectId: current?.id ?? 1, environment: state);

      if (resp.statusCode == 201) {
        return null;
      }
      return null;
    } else {
      final resp = await api.projectProjectIdEnvironmentEnvironmentIdPut(
          projectId: current?.id ?? 1,
          environmentId: item!.id!,
          environment: state);
      if (resp.statusCode == 201) {
        return null;
      }
      return null;
    }
  }
}
