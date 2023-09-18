import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/adaptive/alert_dialog.dart';
import 'package:semaphore/adaptive/button.dart';
import 'package:semaphore/adaptive/dialog.dart';
import 'package:semaphore/adaptive/icon_button.dart';
import 'package:semaphore/components/access_key_name.dart';
import 'package:semaphore/components/repository/form.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/projects.dart';
import 'package:semaphore/utils/base_griddata.dart';

part 'repository.g.dart';

class RepositoryDataTable extends BaseGridData<Repository> {
  @override
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Git URL',
      field: 'git_url',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'SSH Key',
      field: 'ssh_key',
      type: PlutoColumnType.text(),
      renderer: (context) {
        final int id = context.cell.value;
        return AccessKeyName(id: id);
      },
    ),
    PlutoColumn(
      title: 'Action',
      field: 'actions',
      type: PlutoColumnType.text(),
      renderer: (PlutoColumnRendererContext context) {
        final Repository repository = context.cell.value;
        return Consumer(builder: (context, ref, _) {
          return Wrap(
            children: [
              AdaptiveIconButton(
                  onPressed: () {
                    adaptiveDialog(
                      context: context,
                      child: RepositoryForm(repositoryId: repository.id),
                    );
                  },
                  iconData: (Icons.edit)),
              AdaptiveIconButton(
                  onPressed: () {
                    adaptiveAlertDialog(
                      context: context,
                      title: const Text('Delete Repository'),
                      content: const Text(
                          'Are you sure you want to delete this repository?'),
                      secondaryButton: AdaptiveButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      primaryButton: AdaptiveButton(
                          onPressed: () async {
                            final api =
                                ref.read(semaphoreApiProvider).getProjectApi();
                            final current =
                                await ref.read(currentProjectProvider.future);
                            await api
                                .projectProjectIdRepositoriesRepositoryIdDelete(
                                    projectId: current!.id!,
                                    repositoryId: repository.id!);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                            ref
                                .read(repositoryListProvider.notifier)
                                .loadRows();
                          },
                          child: const Text('Delete',
                              style: TextStyle(color: Colors.red))),
                    );
                  },
                  iconData: (Icons.delete)),
            ],
          );
        });
      },
    ),
  ];

  RepositoryDataTable({
    required super.rows,
    super.stateManager,
    super.configuration = const PlutoGridConfiguration(),
  });

  RepositoryDataTable copyWith({
    List<PlutoRow>? rows,
    PlutoGridStateManager? stateManager,
    PlutoGridConfiguration? configuration,
  }) {
    return RepositoryDataTable(
      rows: rows ?? this.rows,
      stateManager: stateManager ?? this.stateManager,
      configuration: configuration ?? this.configuration,
    );
  }

  @override
  List<PlutoRow> mapData(List<Repository> data) {
    return data
        .map<PlutoRow>((rowData) => PlutoRow(
              cells: {
                'name': PlutoCell(value: '${rowData.name}'),
                'git_url': PlutoCell(value: '${rowData.gitUrl}'),
                'ssh_key': PlutoCell(value: rowData.sshKeyId),
                'actions': PlutoCell(value: rowData),
              },
            ))
        .toList();
  }
}

@riverpod
class RepositoryList extends _$RepositoryList {
  @override
  RepositoryDataTable build() {
    return RepositoryDataTable(rows: <PlutoRow>[]);
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

  Future<List<Repository>> loadData() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    final resp = await api.projectProjectIdRepositoriesGet(
        projectId: current?.id ?? 1, sort: 'name', order: 'asc');
    return resp.data ?? <Repository>[];
  }
}

@riverpod
Future<List<Repository>> repository(RepositoryRef ref) async {
  final api = ref.read(semaphoreApiProvider).getProjectApi();
  final current = await ref.read(currentProjectProvider.future);
  final resp = await api.projectProjectIdRepositoriesGet(
      projectId: current?.id ?? 1, sort: 'name', order: 'asc');
  return resp.data ?? <Repository>[];
}

final repositoryFamily =
    FutureProvider.family<Repository, int?>((ref, id) async {
  final current = await ref.read(currentProjectProvider.future);
  if (id == null) {
    return Repository(
      projectId: current?.id ?? 1,
    );
  }
  final repositories = await ref.read(repositoryProvider.future);
  return repositories.firstWhere((element) => element.id == id,
      orElse: () => Repository(
            projectId: current?.id ?? 1,
          ));
});

@riverpod
class RepositoryFormRequest extends _$RepositoryFormRequest {
  @override
  RepositoryRequest build(Repository? item) {
    item ??= Repository();

    return RepositoryRequest(
      name: item.name,
      projectId: item.projectId,
      gitUrl: item.gitUrl,
      gitBranch: item.gitBranch,
      sshKeyId: item.sshKeyId,
    );
  }

  void updateWith({
    String? name,
    int? projectId,
    String? gitUrl,
    String? gitBranch,
    int? sshKeyId,
  }) {
    state = RepositoryRequest(
      name: name ?? state.name,
      projectId: projectId ?? state.projectId,
      gitUrl: gitUrl ?? state.gitUrl,
      gitBranch: gitBranch ?? state.gitBranch,
      sshKeyId: sshKeyId ?? state.sshKeyId,
    );
  }

  void unsetWith({
    bool? name,
    bool? projectId,
    bool? gitUrl,
    bool? gitBranch,
    bool? sshKeyId,
  }) {
    state = RepositoryRequest(
      name: name == true ? null : state.name,
      projectId: projectId == true ? null : state.projectId,
      gitUrl: gitUrl == true ? null : state.gitUrl,
      gitBranch: gitBranch == true ? null : state.gitBranch,
      sshKeyId: sshKeyId == true ? null : state.sshKeyId,
    );
  }

  Future<Repository?> postRepository() async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final current = await ref.read(currentProjectProvider.future);
    try {
      if (item?.id == null) {
        final resp = await api.projectProjectIdRepositoriesPost(
            projectId: current?.id ?? 1, repository: state);
        if (resp.statusCode == 201) {
          return null;
        }
        return null;
      } else {
        final resp = await api.projectProjectIdRepositoriesRepositoryIdPut(
            projectId: current?.id ?? 1,
            repositoryId: item!.id!,
            repository: state);
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
