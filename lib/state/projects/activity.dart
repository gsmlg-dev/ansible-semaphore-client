import 'dart:async';

import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/adaptive/text_timeago.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/utils/base_griddata.dart';

part 'activity.g.dart';

class ActivityDataTable extends BaseGridData<Event> {
  @override
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Time',
      field: 'time',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final DateTime? value = renderContext.cell.value;
        return AdaptiveTextTimeago(value);
      },
    ),
    PlutoColumn(
      title: 'User',
      field: 'user',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Description',
      field: 'description',
      type: PlutoColumnType.text(),
    ),
  ];

  ActivityDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(),
  });

  ActivityDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return ActivityDataTable(
      rows: rows ?? this.rows,
      stateManager: stateManager ?? this.stateManager,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  List<PlutoRow> mapData(List<Event> data) {
    return data
        .map<PlutoRow>((rowData) => PlutoRow(
              cells: {
                'time': PlutoCell(value: rowData.created),
                'user': PlutoCell(value: rowData.username),
                'description': PlutoCell(value: rowData.description),
              },
            ))
        .toList();
  }
}

@riverpod
class ActivityList extends _$ActivityList {
  Timer? timer;

  @override
  ActivityDataTable build() {
    return ActivityDataTable(rows: <PlutoRow>[]);
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

  Future<List<Event>> loadData() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp =
        await api.projectProjectIdEventsLastGet(projectId: current!.id!);
    return resp.data ?? <Event>[];
  }
}
