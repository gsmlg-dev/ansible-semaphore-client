import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/adaptive/alert_dialog.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/components/user/role_form.dart';
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
    PlutoColumn(
      title: 'Actions',
      field: 'actions',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final User value = renderContext.cell.value;
        return Consumer(builder: (context, ref, _) {
          return Wrap(
            children: [
              AdaptiveIconButton(
                onPressed: () {
                  adaptiveDialog(
                      context: context,
                      child: ProjectUserRoleForm(userId: value.id!));
                },
                icon: const AdaptiveIcon(Icons.swap_vert),
              ),
              AdaptiveIconButton(
                  onPressed: () {
                    adaptiveAlertDialog(
                      context: context,
                      title: const Text('Remove User'),
                      content: Text(
                          'Are you sure you want to remove this user (${value.name!}) from project?'),
                      secondaryButton: AdaptiveButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      primaryButton: AdaptiveButton(
                          color: Colors.redAccent,
                          onPressed: () async {
                            final api =
                                ref.read(semaphoreApiProvider).getProjectApi();
                            final current =
                                await ref.read(currentProjectProvider.future);
                            await api.projectProjectIdUsersUserIdDelete(
                                projectId: current!.id!, userId: value.id!);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                            ref.read(userListProvider.notifier).loadRows();
                          },
                          child: const Text('Delete')),
                    );
                  },
                  icon: const AdaptiveIcon(Icons.delete)),
            ],
          );
        });
      },
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
                'role': PlutoCell(value: rowData.role?.name ?? '--'),
                'actions': PlutoCell(value: rowData),
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

@riverpod
class ProjectUserFormRequest extends _$ProjectUserFormRequest {
  @override
  ProjectProjectIdUsersPostRequest build(User? item) {
    item ??= User();

    final role = ProjectProjectIdUsersPostRequestRoleEnum.values.firstWhere(
        (element) => element.name == item?.role?.name,
        orElse: () => ProjectProjectIdUsersPostRequestRoleEnum.guest);

    return ProjectProjectIdUsersPostRequest(
      userId: item.id,
      role: role,
    );
  }

  void updateWith({
    int? userId,
    ProjectProjectIdUsersPostRequestRoleEnum? role,
  }) {
    state = ProjectProjectIdUsersPostRequest(
      userId: userId ?? state.userId,
      role: role ?? state.role,
    );
  }

  void unsetWith({
    bool? userId,
    bool? role,
  }) {
    state = ProjectProjectIdUsersPostRequest(
      userId: userId == true ? null : state.userId,
      role: role == true ? null : state.role,
    );
  }

  Future postUser() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    try {
      final resp = await api.projectProjectIdUsersPost(
          projectId: current!.id!, user: state);
      if (resp.statusCode == 201) {
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

@riverpod
class ProjectUserRoleFormRequest extends _$ProjectUserRoleFormRequest {
  @override
  ProjectProjectIdUsersUserIdPutRequest build(User? item) {
    item ??= User();

    final role = ProjectProjectIdUsersUserIdPutRequestRoleEnum.values
        .firstWhere((element) => element.name == item?.role?.name,
            orElse: () => ProjectProjectIdUsersUserIdPutRequestRoleEnum.guest);
    return ProjectProjectIdUsersUserIdPutRequest(role: role);
  }

  void updateWith({
    ProjectProjectIdUsersUserIdPutRequestRoleEnum? role,
  }) {
    state = ProjectProjectIdUsersUserIdPutRequest(
      role: role,
    );
  }

  void unsetWith({
    bool? role,
  }) {
    state = ProjectProjectIdUsersUserIdPutRequest(
      role: role == true ? null : state.role,
    );
  }

  Future postUser(int userId) async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    try {
      final resp = await api.projectProjectIdUsersUserIdPut(
          projectId: current!.id!, userId: userId!, user: state);
      if (resp.statusCode == 201) {
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
