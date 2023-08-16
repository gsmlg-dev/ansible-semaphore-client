import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'shared_prefs.g.dart';

@riverpod
Future<SharedPreferences> sharedPrefs(SharedPrefsRef ref) async {
  ref.keepAlive();
  return await SharedPreferences.getInstance();
}

@riverpod
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  ref.keepAlive();
  return const FlutterSecureStorage();
}
