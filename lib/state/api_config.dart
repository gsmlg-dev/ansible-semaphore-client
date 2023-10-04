import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/database/schema/semaphore_server.dart'
    show SemaphoreServer;
import 'package:semaphore/state/server.dart';

part 'api_config.g.dart';

@riverpod
class SemaphoreApi extends _$SemaphoreApi {
  @override
  AnsibleSemaphore build() {
    final servers = ref.watch(serversProvider);
    final currentServer = servers.firstWhere((s) => s.isActive == true,
        orElse: () => SemaphoreServer());
    if (currentServer.isActive == null) {
      return AnsibleSemaphore();
    }
    final apiUrl = currentServer.apiUrl;
    final token = currentServer.token;
    if (token != null &&
        token.isNotEmpty &&
        apiUrl != null &&
        Uri.parse(apiUrl).host.isNotEmpty) {
      return AnsibleSemaphore(
        dio: Dio(BaseOptions(
            baseUrl: apiUrl, headers: {'Authorization': 'Bearer $token'})),
      );
    } else if (apiUrl != null && Uri.parse(apiUrl).host.isNotEmpty) {
      return AnsibleSemaphore(
        basePathOverride: apiUrl,
      );
    } else {
      return AnsibleSemaphore();
    }
  }
}
