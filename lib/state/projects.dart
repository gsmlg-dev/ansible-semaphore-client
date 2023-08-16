import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/state/api_config.dart';

part 'projects.g.dart';

@riverpod
class Projects extends _$Projects {
  @override
  Future<List<Project>> build() async {
    ref.keepAlive();
    try {
      final api = ref.read(semaphoreApiProvider).getProjectsApi();
      final resp = await api.projectsGet();
      return resp.data ?? <Project>[];
    } catch (e) {
      return <Project>[];
    }
  }

  void getProjects() async {
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
}

@riverpod
class CurrentProject extends _$CurrentProject {
  @override
  Future<Project?> build() async {
    ref.keepAlive();
    try {
      final projects = await ref.read(projectsProvider.future);
      return projects.first;
    } catch (e) {
      return null;
    }
  }

  void setCurrent(Project? p) {
    state = AsyncValue.data(p);
  }
}

@riverpod
class ProjectFamily extends _$ProjectFamily {
  @override
  Future<Project?> build(int projectId) async {
    final api = ref.read(semaphoreApiProvider).getProjectApi();
    final resp = await api.projectProjectIdGet(projectId: projectId);
    return resp.data;
  }
}
