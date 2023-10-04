import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/shared_prefs.dart';

part 'projects.g.dart';

@riverpod
class Projects extends _$Projects {
  @override
  Future<List<Project>> build() async {
    try {
      final api = ref.read(semaphoreApiProvider).getProjectsApi();
      final resp = await api.projectsGet();
      return resp.data ?? <Project>[];
    } catch (e) {
      return <Project>[];
    }
  }

  Future<void> reloadProjects() async {
    final api = ref.read(semaphoreApiProvider).getProjectsApi();
    state = await AsyncValue.guard(() async {
      try {
        final resp = await api.projectsGet();
        return resp.data ?? <Project>[];
      } catch (e) {
        return <Project>[];
      }
    });
  }

  Future<void> createProject(Project project) async {
    final api = ref.read(semaphoreApiProvider).getProjectsApi();
    await api.projectsPost(
        project: ProjectRequest(
      name: project.name,
      alert: project.alert,
      alertChat: project.alertChat,
      maxParallelTasks: project.maxParallelTasks,
    ));
    reloadProjects();
  }

  Future<void> updateProject(Project project) async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    await api.projectProjectIdPut(
        projectId: project.id!,
        project: ProjectRequest(
          name: project.name,
          alert: project.alert,
          alertChat: project.alertChat,
          maxParallelTasks: project.maxParallelTasks,
        ));
    reloadProjects();
  }

  Future<void> deleteProject(Project project) async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    await api.projectProjectIdDelete(projectId: project.id!);
    reloadProjects();
  }
}

@riverpod
class CurrentProject extends _$CurrentProject {
  static const saveKey = 'currentProject';

  @override
  Future<Project?> build() async {
    try {
      final projects = ref.watch(projectsProvider);
      final pref = await ref.read(sharedPrefsProvider.future);
      final projId = pref.getInt(saveKey);
      if (projId == null) {
        return null;
      }
      print(('project id', projId));
      return projects.asData?.value
          .firstWhere((element) => element.id == projId);
    } catch (e) {
      return null;
    }
  }

  Future<void> setCurrent(Project? p) async {
    state = AsyncValue.data(p);
    if (p != null) {
      final pref = await ref.read(sharedPrefsProvider.future);
      final ok = await pref.setInt(saveKey, p.id!);
      print('set current project: $ok ${p.id}');
    }
  }
}

@riverpod
class ProjectFamily extends _$ProjectFamily {
  @override
  Future<Project?> build(int? projectId) async {
    if (projectId == null) {
      return null;
    }
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final resp = await api.projectProjectIdGet(projectId: projectId);
    return resp.data;
  }
}

@riverpod
class ProjectFormState extends _$ProjectFormState {
  @override
  Project build(Project? project) {
    if (project == null) {
      return Project();
    }
    return project;
  }

  void updateWith({
    String? name,
    bool? alert,
    String? alertChat,
    int? maxParallelTasks,
  }) {
    state = Project(
      id: state.id,
      name: name ?? state.name,
      alert: alert ?? state.alert,
      alertChat: alertChat ?? state.alertChat,
      maxParallelTasks: maxParallelTasks ?? state.maxParallelTasks,
    );
  }
}
