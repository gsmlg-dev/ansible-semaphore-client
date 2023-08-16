import 'package:isar/isar.dart';

part 'app_activities.g.dart';

enum ActiveState {
  active,
  deactive,
  pause,
  resume,
}

@collection
class AppActivities {
  Id id = Isar.autoIncrement;

  @enumerated
  late ActiveState state;

  DateTime createdAt = DateTime.now();
}
