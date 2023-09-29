import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:semaphore/adaptive/alert_dialog.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/icon.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/components/user/system_form.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/utils/base_griddata.dart';

part 'user.g.dart';

class SystemUserDataTable extends BaseGridData<User> {
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
      title: 'Alert',
      field: 'alert',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final bool? value = renderContext.cell.value;
        return Row(
          children: [
            value == true
                ? const AdaptiveIcon(Icons.check_box_outlined)
                : const AdaptiveIcon(Icons.check_box_outline_blank),
          ],
        );
      },
    ),
    PlutoColumn(
      title: 'Admin',
      field: 'admin',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext renderContext) {
        final bool? value = renderContext.cell.value;
        return Row(
          children: [
            value == true
                ? const AdaptiveIcon(Icons.check_box_outlined)
                : const AdaptiveIcon(Icons.check_box_outline_blank),
          ],
        );
      },
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
                      child: SystemUserForm(userId: value.id!));
                },
                icon: const AdaptiveIcon(Icons.edit),
              ),
              AdaptiveIconButton(
                  onPressed: () {
                    adaptiveAlertDialog(
                      context: context,
                      title: const Text('Remove User'),
                      content: Text(
                          'Are you sure you want to remove this user (${value.name!})?'),
                      secondaryButton: AdaptiveButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      primaryButton: AdaptiveButton(
                          color: Colors.redAccent,
                          onPressed: () async {
                            final api =
                                ref.read(semaphoreApiProvider).getUserApi();

                            await api.usersUserIdDelete(userId: value.id!);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                            ref
                                .read(systemUserListProvider.notifier)
                                .loadRows();
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

  SystemUserDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(),
  });

  SystemUserDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return SystemUserDataTable(
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
                'alert': PlutoCell(value: rowData.alert),
                'admin': PlutoCell(value: rowData.admin),
                'actions': PlutoCell(value: rowData),
              },
            ))
        .toList();
  }
}

@riverpod
class SystemUserList extends _$SystemUserList {
  @override
  SystemUserDataTable build() {
    return SystemUserDataTable(rows: <PlutoRow>[]);
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
    final users = await ref.read(systemUserProvider.future);
    return users;
  }
}

@riverpod
Future<List<User>> systemUser(SystemUserRef ref) async {
  final api = ref.read(semaphoreApiProvider).getUserApi();
  final resp = await api.usersGet();
  return resp.data ?? <User>[];
}

@riverpod
Future<User> systemUserFamily(SystemUserFamilyRef ref, int? id) async {
  if (id == null) return User();
  try {
    final api = ref.read(semaphoreApiProvider).getUserApi();
    final resp = await api.usersUserIdGet(userId: id);
    return resp.data ?? User();
  } catch (e) {
    return User();
  }
}

@riverpod
class SystemUserFormRequest extends _$SystemUserFormRequest {
  @override
  UserPutRequest build(User? item) {
    item ??= User();
    return UserPutRequest(
      name: item.name,
      username: item.username,
      email: item.email,
      alert: item.alert,
      admin: item.admin,
    );
  }

  void updateWith({
    String? name,
    String? username,
    String? email,
    String? password,
    bool? alert,
    bool? admin,
  }) {
    state = UserPutRequest(
      name: name ?? state.name,
      username: username ?? state.username,
      email: email ?? state.email,
      password: password ?? state.password,
      alert: alert ?? state.alert,
      admin: admin ?? state.admin,
    );
  }

  void unsetWith({
    bool? name,
    bool? username,
    bool? email,
    bool? password,
    bool? alert,
    bool? admin,
  }) {
    state = UserPutRequest(
      name: name == true ? null : state.name,
      username: username == true ? null : state.username,
      email: email == true ? null : state.email,
      password: password == true ? null : state.password,
      alert: alert == true ? null : state.alert,
      admin: admin == true ? null : state.admin,
    );
  }

  Future putUser(int userId) async {
    final api = ref.read(semaphoreApiProvider).getUserApi();

    try {
      final resp = await api.usersUserIdPut(userId: userId, user: state);
      if (resp.statusCode == 201) {
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future postUser() async {
    final api = ref.read(semaphoreApiProvider).getUserApi();

    try {
      final resp = await api.usersPost(
          user: UserRequest(
        name: state.name,
        username: state.username,
        email: state.email,
        password: state.password,
        alert: state.alert,
        admin: state.admin,
      ));
      if (resp.statusCode == 201) {
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
