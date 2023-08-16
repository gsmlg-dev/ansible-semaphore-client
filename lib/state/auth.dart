import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:semaphore/state/api_config.dart';
import 'package:semaphore/state/shared_prefs.dart';

part 'auth.g.dart';

@riverpod
class SignInState extends _$SignInState {
  @override
  bool build() {
    ref.keepAlive();
    return false;
  }

  void changeToSigned() {
    state = true;
  }

  void changeToNotSigned() {
    state = false;
  }
}

@riverpod
class SignInForm extends _$SignInForm {
  @override
  Login build() {
    return Login();
  }

  void updateWith({
    String? auth,
    String? password,
  }) {
    state = Login(
      auth: auth ?? state.auth,
      password: password ?? state.password,
    );
  }
}

@riverpod
class SignInFormError extends _$SignInFormError {
  @override
  DioException? build() {
    return null;
  }

  void updateWith(error) {
    state = error;
  }
}

@riverpod
class UserToken extends _$UserToken {
  static const String saveKey = 'org.gsmlg.semaphore.api_token';
  @override
  String? build() {
    ref.keepAlive();
    return '';
  }

  Future<void> setToken(String? token) async {
    state = token;
    final secureStorage = ref.read(secureStorageProvider);
    if (token != null) {
      ref.read(signInStateProvider.notifier).changeToSigned();
      await secureStorage.write(key: saveKey, value: token);
    } else {
      ref.read(signInStateProvider.notifier).changeToNotSigned();
      await secureStorage.delete(key: saveKey);
    }
  }

  Future<String?> readToken() async {
    final secureStorage = ref.read(secureStorageProvider);
    final token = await secureStorage.read(key: saveKey);
    if (token != null && token.isNotEmpty) {
      state = token;
      ref.read(signInStateProvider.notifier).changeToSigned();
    } else {
      state = '';
      ref.read(signInStateProvider.notifier).changeToNotSigned();
    }
    return token;
  }

  checkToken() async {
    try {
      ref.read(semaphoreApiProvider.notifier).rebuild();
      final api = ref.read(semaphoreApiProvider).getProjectsApi();
      await api.projectsGet();
      ref.read(signInStateProvider.notifier).changeToSigned();
    } catch (e) {
      ref.read(signInStateProvider.notifier).changeToNotSigned();
      state = '';
    }
  }
}
