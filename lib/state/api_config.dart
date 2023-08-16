import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'shared_prefs.dart';
import 'auth.dart';

part 'api_config.g.dart';

@riverpod
class ApiUrl extends _$ApiUrl {
  static const apiUrlSaveKey = 'semaphore.url';
  @override
  String build() {
    ref.keepAlive();
    return '';
  }

  void changeApiUrl(String url) {
    state = url;
    persistentUrlConfig(url);
  }

  void persistentUrlConfig(String url) async {
    final prefs = await ref.read(sharedPrefsProvider.future);
    prefs.setString(apiUrlSaveKey, url);
  }

  Future<String> loadApiUrl() async {
    final prefs = await ref.read(sharedPrefsProvider.future);
    final url = prefs.getString(apiUrlSaveKey) ?? '';
    state = url;
    return url;
  }
}

@riverpod
class SemaphoreApi extends _$SemaphoreApi {
  @override
  AnsibleSemaphore build() {
    final apiUrl = ref.read(apiUrlProvider);
    final token = ref.read(userTokenProvider);
    ref.keepAlive();
    if (token != null && token.isNotEmpty) {
      return AnsibleSemaphore(
        dio: Dio(BaseOptions(
            baseUrl: apiUrl, headers: {'Authorization': 'Bearer $token'})),
      );
    } else {
      return AnsibleSemaphore(
        basePathOverride: apiUrl,
      );
    }
  }

  void rebuild() {
    state = build();
  }
}
