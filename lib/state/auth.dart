import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:semaphore/state/api_config.dart';

part 'auth.g.dart';

@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  Future<User?> build() async {
    final api = ref.watch(semaphoreApiProvider).getUserApi();
    final resp = await api.userGet();
    return resp.data;
  }
}
