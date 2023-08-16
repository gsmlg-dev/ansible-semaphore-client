import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;

import 'schema.dart' show allSchema;

class Database {
  final version = 1;
  final saveKey = 'database_version';

  static late Database _singleton;

  static Future<void> initialize() async {
    final dir = await getApplicationSupportDirectory();
    final isar = await Isar.open(
      name: 'GSMLG.app',
      allSchema,
      directory: dir.path,
      inspector: !kReleaseMode,
    );
    _singleton = Database._(isar);
  }

  final Isar instance;

  factory Database() {
    return _singleton;
  }

  Database._(this.instance);

  static Future<void> performMigrationIfNeeded() async {
    try {
      final db = Database();

      final currentVersion = await db.getDataVersion();

      switch (currentVersion) {
        case 1:
          // current version, we do not need to migrate
          return;
        // case 2:
        //   await migrateV1ToV2();
        //   break;
        default:
          throw Exception('Unknown version: $currentVersion');
      }

      // Update version
      // await prefs.setInt(saveKey, db.version);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getDataVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final currentVersion = prefs.getInt(saveKey) ?? version;
    return currentVersion;
  }

  // Future<void> migrateV1ToV2() async {
  //   final userCount = await instance.users.count();
  //   final pageSize = 50;
  //   // We paginate through the users to avoid loading all users into memory at once
  //   for (var i = 0; i < userCount; i += pageSize) {
  //     final users = await isar.users.where().offset(i).limit(pageSize).findAll();
  //     await isar.writeTxn((isar) async {
  //       // We don't need to update anything since the birthYear getter is used
  //       await isar.users.putAll(users);
  //     });
  //   }
  // }
}
