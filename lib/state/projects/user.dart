import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/utils/base_griddata.dart';

part 'user.g.dart';

class UserDataTable extends BaseGridData<User> {
  @override
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Username',
      field: 'username',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Email',
      field: 'email',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Role',
      field: 'role',
      type: PlutoColumnType.text(),
    ),
  ];

  UserDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(),
  });

  UserDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return UserDataTable(
      rows: rows ?? this.rows,
      stateManager: stateManager ?? this.stateManager,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  List<PlutoRow> mapData(List<User> data) {
    return data
        .map<PlutoRow>((rowData) => PlutoRow(
              cells: {
                'name': PlutoCell(value: '${rowData.name}'),
                'username': PlutoCell(value: '${rowData.username}'),
                'email': PlutoCell(value: '${rowData.email}'),
                'role': PlutoCell(value: rowData.role),
              },
            ))
        .toList();
  }
}

@riverpod
class UserList extends _$UserList {
  @override
  UserDataTable build() {
    return UserDataTable(rows: <PlutoRow>[]);
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

  Future<List<User>> loadData() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdUsersGet(
        projectId: current?.id ?? 1, sort: 'name', order: 'asc');
    return resp.data ?? <User>[];
  }
}

@riverpod
Future<List<User>> user(UserRef ref) async {
  final api = ref.read(semaphoreApiProvider).getProjectApi();
  final current = await ref.read(currentProjectProvider.future);
  final resp = await api.projectProjectIdUsersGet(
      projectId: current?.id ?? 1, sort: 'name', order: 'asc');
  return resp.data ?? <User>[];
}

final userFamily = FutureProvider.family<User, int?>((ref, id) async {
  if (id == null) return User();
  final users = await ref.read(userProvider.future);
  return users.firstWhere((element) => element.id == id, orElse: () => User());
});
