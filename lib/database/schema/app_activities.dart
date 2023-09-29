import 'package:flutter/scheduler.dart' show AppLifecycleState;
import 'package:isar/isar.dart';

part 'app_activities.g.dart';

@collection
class AppActivities {
  Id id = Isar.autoIncrement;

  @enumerated
  late AppLifecycleState state;

  DateTime createdAt = DateTime.now();
}
