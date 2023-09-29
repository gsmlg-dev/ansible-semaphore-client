import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/database/database.dart';
import 'package:semaphore/database/schema/app_activities.dart';

part 'user_app_activity.g.dart';

@riverpod
class UserAppActivityData extends _$UserAppActivityData {
  @override
  Future<List<AppActivities>> build() async {
    final db = Database().instance;
    final allActivities = await db.appActivities
        .filter()
        .idGreaterThan(0)
        .sortByCreatedAtDesc()
        .limit(100)
        .findAll();
    return allActivities;
  }
}
