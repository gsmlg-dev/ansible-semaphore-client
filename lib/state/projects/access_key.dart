import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/adaptive/alert_dialog.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/components/access_key/form.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/utils/base_griddata.dart';

part 'access_key.g.dart';

class AccessKeyDataTable extends BaseGridData<AccessKey> {
  @override
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Type',
      field: 'type',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Action',
      field: 'actions',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext context) {
        final AccessKey accessKey = context.cell.value;
        return Consumer(builder: (context, ref, _) {
          return Wrap(
            children: [
              AdaptiveIconButton(
                  onPressed: () {
                    adaptiveDialog(
                        context: context,
                        child: AccessKeyForm(accessKeyId: accessKey.id));
                  },
                  iconData: (Icons.edit)),
              AdaptiveIconButton(
                  onPressed: () {
                    adaptiveAlertDialog(
                      context: context,
                      title: const Text('Delete AccessKey'),
                      content: const Text(
                          'Are you sure you want to delete this accessKey?'),
                      primaryButton: AdaptiveButton(
                          controlSize: ControlSize.large,
                          onPressed: () async {
                            final api =
                                ref.read(semaphoreApiProvider).getProjectApi();
                            final current =
                                await ref.read(currentProjectProvider.future);
                            await api.projectProjectIdKeysKeyIdDelete(
                                projectId: current!.id!, keyId: accessKey.id!);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                            ref.read(accessKeyListProvider.notifier).loadRows();
                          },
                          child: const Text('Delete',
                              style: TextStyle(color: Colors.red))),
                      secondaryButton: AdaptiveButton(
                        controlSize: ControlSize.large,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    );
                  },
                  iconData: (Icons.delete)),
            ],
          );
        });
      },
    ),
  ];

  AccessKeyDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(),
  });

  AccessKeyDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return AccessKeyDataTable(
      rows: rows ?? this.rows,
      stateManager: stateManager ?? this.stateManager,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  List<PlutoRow> mapData(List<AccessKey> data) {
    return data
        .map<PlutoRow>((rowData) => PlutoRow(
              cells: {
                'name': PlutoCell(value: '${rowData.name}'),
                'type': PlutoCell(value: '${rowData.type?.name}'),
                'actions': PlutoCell(value: rowData),
              },
            ))
        .toList();
  }
}

@riverpod
class AccessKeyList extends _$AccessKeyList {
  @override
  AccessKeyDataTable build() {
    return AccessKeyDataTable(rows: <PlutoRow>[]);
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

  Future<List<AccessKey>> loadData() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdKeysGet(
        projectId: current?.id ?? 1, sort: 'name', order: 'asc');
    return resp.data ?? <AccessKey>[];
  }
}

@riverpod
Future<List<AccessKey>> accessKey(AccessKeyRef ref) async {
  final api = ref.read(semaphoreApiProvider).getProjectApi();
  final current = await ref.read(currentProjectProvider.future);
  final resp = await api.projectProjectIdKeysGet(
      projectId: current?.id ?? 1, sort: 'name', order: 'asc');
  return resp.data ?? <AccessKey>[];
}

final accessKeyFamily = FutureProvider.family<AccessKey, int?>((ref, id) async {
  final current = await ref.read(currentProjectProvider.future);
  if (id == null) {
    return AccessKey(
      projectId: current?.id ?? 1,
    );
  }
  final accessKeys = await ref.read(accessKeyProvider.future);
  return accessKeys.firstWhere((element) => element.id == id,
      orElse: () => AccessKey(
            projectId: current?.id ?? 1,
          ));
});

@riverpod
class AccessKeyFormRequest extends _$AccessKeyFormRequest {
  @override
  AccessKeyRequest build(AccessKey? item) {
    item ??= AccessKey();
    final AccessKeyRequestTypeEnum? type = item.type != null
        ? AccessKeyRequestTypeEnum.values.firstWhere(
            (AccessKeyRequestTypeEnum t) => t.name == item?.type?.name)
        : null;

    return AccessKeyRequest(
      name: item.name,
      projectId: item.projectId,
      type: type,
      loginPassword: item.loginPassword,
      ssh: item.ssh,
    );
  }

  void updateWith({
    String? name,
    int? projectId,
    AccessKeyRequestTypeEnum? type,
    AccessKeyRequestLoginPassword? loginPassword,
    AccessKeyRequestSsh? ssh,
  }) {
    state = AccessKeyRequest(
      name: name ?? state.name,
      projectId: projectId ?? state.projectId,
      type: type ?? state.type,
      loginPassword: loginPassword ?? state.loginPassword,
      ssh: ssh ?? state.ssh,
    );
  }

  void unsetWith({
    bool? name,
    bool? projectId,
    bool? type,
    bool? loginPassword,
    bool? ssh,
  }) {
    state = AccessKeyRequest(
      name: name == true ? null : state.name,
      projectId: projectId == true ? null : state.projectId,
      type: type == true ? null : state.type,
      loginPassword: loginPassword == true ? null : state.loginPassword,
      ssh: ssh == true ? null : state.ssh,
    );
  }

  Future<AccessKey?> postAccessKey() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    try {
      if (item?.id == null) {
        final resp = await api.projectProjectIdKeysPost(
            projectId: current?.id ?? 1, accessKey: state);

        if (resp.statusCode == 201) {
          return null;
        }
        return null;
      } else {
        final resp = await api.projectProjectIdKeysKeyIdPut(
            projectId: current?.id ?? 1, keyId: item!.id!, accessKey: state);
        if (resp.statusCode == 201) {
          return null;
        }
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
