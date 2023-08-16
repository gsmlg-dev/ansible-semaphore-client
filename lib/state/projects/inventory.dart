import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/components/inventory/form.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/utils/base_griddata.dart';

part 'inventory.g.dart';

class InventoryDataTable extends BaseGridData<Inventory> {
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
        title: 'Path',
        field: 'path',
        type: PlutoColumnType.text(),
        renderer: (context) {
          final Inventory inventory = context.cell.value;
          return Text(inventory.type == InventoryTypeEnum.file
              ? inventory.inventory ?? ''
              : '--');
        }),
    PlutoColumn(
        title: 'Actions',
        field: 'actions',
        type: PlutoColumnType.text(),
        renderer: (PlutoColumnRendererContext context) {
          final Inventory inventory = context.cell.value;
          return Consumer(builder: (context, ref, _) {
            return Wrap(
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog.fullscreen(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              child: InventoryForm(inventoryId: inventory.id),
                            );
                          });
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Inventory'),
                              content: const Text(
                                  'Are you sure you want to delete this inventory?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () async {
                                      final api = ref
                                          .read(semaphoreApiProvider)
                                          .getProjectApi();
                                      final current = await ref
                                          .read(currentProjectProvider.future);
                                      await api
                                          .projectProjectIdInventoryInventoryIdDelete(
                                              projectId: current!.id!,
                                              inventoryId: inventory.id!);
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                      ref
                                          .read(inventoryListProvider.notifier)
                                          .loadRows();
                                    },
                                    child: const Text('Delete')),
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.delete)),
              ],
            );
          });
        }),
  ];

  InventoryDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(),
  });

  InventoryDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return InventoryDataTable(
      rows: rows ?? this.rows,
      stateManager: stateManager ?? this.stateManager,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  List<PlutoRow> mapData(List<Inventory> data) {
    return data
        .map<PlutoRow>((rowData) => PlutoRow(
              cells: {
                'name': PlutoCell(value: '${rowData.name}'),
                'type': PlutoCell(value: '${rowData.type?.name}'),
                'path': PlutoCell(value: rowData),
                'actions': PlutoCell(value: rowData),
              },
            ))
        .toList();
  }
}

@riverpod
class InventoryList extends _$InventoryList {
  @override
  InventoryDataTable build() {
    return InventoryDataTable(rows: <PlutoRow>[]);
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

  Future<List<Inventory>> loadData() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdInventoryGet(
        projectId: current?.id ?? 1, sort: 'name', order: 'asc');
    return resp.data ?? <Inventory>[];
  }
}

@riverpod
Future<List<Inventory>> inventory(InventoryRef ref) async {
  final api = ref.read(semaphoreApiProvider).getProjectApi();
  final current = await ref.read(currentProjectProvider.future);
  final resp = await api.projectProjectIdInventoryGet(
      projectId: current?.id ?? 1, sort: 'name', order: 'asc');
  return resp.data ?? <Inventory>[];
}

final inventoryFamily = FutureProvider.family<Inventory, int?>((ref, id) async {
  final current = await ref.read(currentProjectProvider.future);
  if (id == null) {
    return Inventory(
      projectId: current?.id ?? 1,
    );
  }
  final inventories = await ref.read(inventoryProvider.future);
  return inventories.firstWhere((element) => element.id == id,
      orElse: () => Inventory(projectId: current?.id));
});

@riverpod
class InventoryFormRequest extends _$InventoryFormRequest {
  @override
  InventoryRequest build(Inventory? item) {
    item ??= Inventory();
    final InventoryRequestTypeEnum? type = item.type != null
        ? InventoryRequestTypeEnum.values.firstWhere(
            (InventoryRequestTypeEnum t) => t.name == item?.type?.name)
        : null;

    return InventoryRequest(
      name: item.name,
      projectId: item.projectId,
      inventory: item.inventory,
      sshKeyId: item.sshKeyId,
      becomeKeyId: item.becomeKeyId,
      type: type,
    );
  }

  void updateWith({
    String? name,
    int? projectId,
    String? inventory,
    int? sshKeyId,
    int? becomeKeyId,
    InventoryRequestTypeEnum? type,
  }) {
    state = InventoryRequest(
      name: name ?? state.name,
      projectId: projectId ?? state.projectId,
      inventory: inventory ?? state.inventory,
      sshKeyId: sshKeyId ?? state.sshKeyId,
      becomeKeyId: becomeKeyId ?? state.becomeKeyId,
      type: type ?? state.type,
    );
  }

  void unsetWith({
    bool? name,
    bool? projectId,
    bool? inventory,
    bool? sshKeyId,
    bool? becomeKeyId,
    bool? type,
  }) {
    state = InventoryRequest(
      name: name == true ? null : state.name,
      projectId: projectId == true ? null : state.projectId,
      inventory: inventory == true ? null : state.inventory,
      sshKeyId: sshKeyId == true ? null : state.sshKeyId,
      becomeKeyId: becomeKeyId == true ? null : state.becomeKeyId,
      type: type == true ? null : state.type,
    );
  }

  Future<Inventory?> postInventory() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    if (item?.id == null) {
      final resp = await api.projectProjectIdInventoryPost(
          projectId: current?.id ?? 1, inventory: state);

      return resp.data;
    } else {
      final resp = await api.projectProjectIdInventoryInventoryIdPut(
          projectId: current?.id ?? 1,
          inventoryId: item!.id!,
          inventory: state);
      if (resp.statusCode == 201) {
        return null;
      }
      return null;
    }
  }
}
